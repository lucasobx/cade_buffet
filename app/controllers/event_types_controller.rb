class EventTypesController < ApplicationController
  before_action :set_event_type, only: [:edit, :update]

  def index
    @event_types = EventType.all
  end

  def new
    @event_type = EventType.new
    @buffet = Buffet.find(params[:buffet_id])
  end

  def create
    @event_type = EventType.new(event_type_params)
    @event_type.buffet = current_owner.buffet
    if @event_type.save
      redirect_to @event_type.buffet, notice: 'Tipo de Evento cadastrado com sucesso.'
    else
      render 'new', status: 422
    end
  end

  def edit
    @buffet = Buffet.find(params[:buffet_id])
  end

  def update
    if @event_type.update(event_type_params)
      redirect_to @event_type.buffet, notice: 'Tipo de Evento atualizado com sucesso.'
    else
      render 'edit', status: 422
    end
  end

  private

  def set_event_type
    @event_type = EventType.find(params[:id])
  end

  def event_type_params
    params.require(:event_type).permit(
      :name,
      :description,
      :min_guests,
      :max_guests,
      :duration,
      :menu_details,
      :alcohol_option,
      :decoration_option,
      :parking_service_option,
      :location_option,)
  end
end