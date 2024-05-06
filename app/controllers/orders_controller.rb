class OrdersController < ApplicationController
  before_action :authenticate_client!
  before_action :set_order_and_check_client, only: [:show]

  def index
    @orders = current_client.orders
  end
  
  def show; end

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
end