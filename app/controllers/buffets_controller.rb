class BuffetsController < ApplicationController
  before_action :set_buffet, only: [:show, :edit, :update]
  before_action :authenticate_owner!, only: [:new, :create, :edit, :update]
  before_action :check_owner, only: [:edit, :update]

  def show; end

  def new
    @buffet = Buffet.new
  end

  def create
    @buffet = Buffet.new(buffet_params)
    @buffet.owner = current_owner
    if @buffet.save
      @buffet.payment_methods << PaymentMethod.where(id: params[:buffet][:payment_method_ids])
      redirect_to root_path, notice: 'Buffet cadastrado com sucesso.'
    else
      flash.now[:notice] = 'Não foi possível cadastrar o Buffet.'
      render 'new', status: 422
    end
  end

  def edit; end

  def update
    if @buffet.update(buffet_params)
      @buffet.payment_methods = PaymentMethod.where(id: params[:buffet][:payment_method_ids])
      redirect_to @buffet, notice: 'Buffet atualizado com sucesso.'
    else
      flash.now[:notice] = 'Não foi possível atualizado o buffet.'
      render 'new', status: 422
    end
  end

  private

  def check_owner
    unless current_owner == @buffet.owner
      redirect_to root_path
    end
  end

  def set_buffet
    @buffet = Buffet.find(params[:id])
  end

  def buffet_params
    params.require(:buffet).permit(
      :brand_name,
      :corporate_name,
      :registration_code,
      :phone_number,
      :email,
      :address,
      :neighborhood,
      :city,
      :state,
      :postal_code,
      :description,
      :payment_method_ids)
  end
end