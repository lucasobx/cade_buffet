class OrdersController < ApplicationController
  before_action :authenticate_client!, only: [:new, :create, :edit, :update, :index]
  before_action :authenticate_owner!, only: [:my_buffet_orders]
  before_action :set_order_and_check_client, only: [:show, :edit, :update, :canceled, :confirmed], if: -> { client_signed_in? }
  before_action :set_order_and_check_owner, only: [:show, :canceled, :approved], if: -> { owner_signed_in? }
  before_action :set_event_type_from_params, only: [:new, :create]
  before_action :set_event_type_from_order, only: [:edit, :update]

  def index
    @orders = current_client.orders
  end
  
  def show
    @payment_methods = @order.buffet.payment_methods
    @same_day_orders = @order.buffet.orders.where(event_date: @order.event_date).where.not(id: @order.id)
  end

  def new
    @order = Order.new
    @show_address = @event_type.location_option
  end

  def create
    @order = @event_type.orders.new(order_params)
    @order.client = current_client
    @order.buffet = @event_type.buffet

    if Order.where(client: current_client, buffet: @order.buffet, status: :pending).exists?
      flash[:alert] = 'Já existe um pedido pendente para este buffet.'
      redirect_to buffet_path(@order.buffet)
    elsif @order.save
      redirect_to @order, notice: 'Agendamento realizado com sucesso!'
    else
      flash.now[:alert] = 'Não foi possível concluir o agendamento.'
      render 'new', status: 422
    end
  end

  def edit; end

  def update
   if @order.update(order_params)
    redirect_to @order, notice: 'Pedido atualizado com sucesso!'
   else
    flash.now[:alert] = 'Não foi possível atualizar o pedido.'
    render 'edit', status: 422
   end
  end

  def my_buffet_orders
    @buffet = current_owner.buffet
    @orders = @buffet.orders.order(created_at: :desc)
  end

  def canceled
    @order.canceled!
    redirect_to @order, notice: 'Pedido Cancelado!'
  end

  def approved
    if @order.update(order_params)
      @order.update(status: :approved) 
      redirect_to @order, notice: 'Pedido aprovado com sucesso!'
    else
      render :show, status: 422
    end
  end

  def confirmed
    @order.confirmed!
    redirect_to @order, notice: 'Pedido confirmado com sucesso!'
  end

  private
  
  def order_params
    params.require(:order).permit(:event_date, :estimated_guests, :event_details, :event_address, :price_valid_until,
                                  :extra_fee, :discount, :adjustment_description, :payment_method_id)
  end

  def set_order_and_check_client
    @order = Order.find(params[:id])
    if @order.client != current_client
      return redirect_to root_path, alert: 'Você não possui acesso a este pedido.'
    end
  end

  def set_order_and_check_owner
    @order = Order.find(params[:id])
    if @order.buffet.owner != current_owner
      return redirect_to root_path, alert: 'Você não possui acesso a este pedido.'
    end
  end

  def set_event_type_from_params
    @event_type = EventType.find(params[:event_type_id])
  end

  def set_event_type_from_order
    @event_type = @order.event_type
  end
end