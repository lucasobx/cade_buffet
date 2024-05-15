class EventTypesController < ApplicationController
  before_action :set_event_type, only: [:edit, :update]
  before_action :authenticate_owner!, only: [:new, :create, :edit, :update]
  before_action :check_owner, only: [:edit, :update]

  def new
    @buffet = Buffet.find(params[:buffet_id])
    @event_type = EventType.new
  end

  def create
    @buffet = Buffet.find(params[:buffet_id])
    @event_type = @buffet.event_types.create(event_type_params)
    if @event_type.save
      redirect_to @buffet, notice: 'Tipo de Evento cadastrado com sucesso.'
    else
      flash.now[:notice] = 'Não foi possível cadastrar o tipo de evento.'
      render 'new', status: 422
    end
  end

  def edit; end

  def update
    if @event_type.update(event_type_params)
      redirect_to @event_type.buffet, notice: 'Tipo de Evento atualizado com sucesso.'
    else
      flash.now[:notice] = 'Não foi possível atualizar o tipo de evento.'
      render 'edit', status: 422
    end
  end

  private

  def check_owner
    unless current_owner == @event_type.buffet.owner
      redirect_to root_path
    end
  end

  def set_event_type
    @event_type = EventType.find(params[:id])
  end

  def event_type_params
    params.require(:event_type).permit(:name, :description, :min_guests,:max_guests, :duration, :menu_details,
                                       :alcohol_option, :decoration_option, :parking_service_option, :location_option,
                                       :base_price, :extra_guest, :extra_hour, :we_base_price, :we_extra_guest,
                                       :we_extra_hour, pictures: [])
  end
end