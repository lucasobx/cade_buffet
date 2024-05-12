class OrdersController < ApplicationController
  before_action :authenticate_client!, only: [:new, :create, :index]
  before_action :authenticate_owner!, only: [:my_buffet_orders]
  before_action :set_order_and_check_client, only: [:show], if: -> { client_signed_in? }
  before_action :set_order_and_check_owner, only: [:show, :canceled], if: -> { owner_signed_in? }

  def index
    @orders = current_client.orders
  end
  
  def show
    @same_day_orders = @order.buffet.orders.where(event_date: @order.event_date).where.not(id: @order.id)
  end

  def new
    @event_type = EventType.find(params[:event_type_id])
    @order = Order.new
    @show_address = @event_type.location_option
  end

  def create
    @event_type = EventType.find(params[:event_type_id])
    @order = @event_type.orders.new(order_params)
    @order.client = current_client
    @order.buffet = @event_type.buffet

    if @order.save
      redirect_to @order, notice: 'Agendamento realizado com sucesso!'
    else
      flash.now[:notice] = 'Não foi possível concluir o agendamento.'
      render 'new', status: 422
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

  private
  
  def order_params
    params.require(:order).permit(:event_date, :estimated_guests, :event_details, :event_address)
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
end