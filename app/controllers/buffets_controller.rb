class BuffetsController < ApplicationController
  before_action :set_buffet, only: [:show, :edit, :update]
  before_action :authenticate_owner!, only: [:new, :create, :edit, :update]
  before_action :check_existing_buffet, only: [:new, :create]
  before_action :check_owner, only: [:edit, :update]
  before_action :set_payment_methods, only: [:create, :update]

  def show
    @event_types = @buffet.event_types
    @pending_order = current_client.orders.find_by(buffet: @buffet, status: :pending) if client_signed_in?
  end

  def new
    @buffet = Buffet.new
  end

  def create
    @buffet = Buffet.new(buffet_params)
    @buffet.owner = current_owner
    @buffet.payment_methods << @payment_methods
    if @buffet.save 
      redirect_to root_path, notice: 'Buffet cadastrado com sucesso.'
    else
      flash.now[:alert] = 'Não foi possível cadastrar o Buffet.'
      render 'new', status: 422
    end
  end

  def edit; end

  def update
    if @buffet.update(buffet_params)
      @buffet.payment_methods = @payment_methods
      redirect_to @buffet, notice: 'Buffet atualizado com sucesso.'
    else
      flash.now[:alert] = 'Não foi possível atualizar o buffet.'
      render 'new', status: 422
    end
  end

  def search
    @name = params["query"]
    @buffets = Buffet.joins(:event_types)
                     .where("buffets.brand_name LIKE :name OR buffets.city LIKE :name OR event_types.name LIKE :name",
                            name: "%#{@name}%").distinct.order(:brand_name)
  end

  private

  def check_owner
    unless current_owner == @buffet.owner
      redirect_to root_path
    end
  end

  def check_existing_buffet
    if current_owner.buffet
      redirect_to root_path, alert: 'Você já cadastrou um buffet.'
    end
  end

  def set_buffet
    @buffet = Buffet.find(params[:id])
  end

  def set_payment_methods
    @payment_methods = PaymentMethod.where(id: params[:buffet][:payment_method_ids])
  end

  def buffet_params
    params.require(:buffet).permit(:brand_name, :corporate_name, :registration_code, :phone_number, :email, :address,
                                   :neighborhood, :city, :state, :postal_code, :description, :payment_method_ids)
  end
end