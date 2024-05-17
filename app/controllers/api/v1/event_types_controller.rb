class Api::V1::EventTypesController < Api::V1::ApiController
  def index
    buffet = Buffet.find(params[:buffet_id])
    if buffet.event_types.present?
      render status: 200, json: buffet.event_types.order(:name).as_json(except: [:created_at, :updated_at, :buffet_id])
    else
      render json: {}, status: 404
    end
  end

  def show
    event_type = EventType.find(params[:id])
    event_date = Date.parse(params[:event_date])
    guest_number = params[:guest_number].to_i
    same_day_events = event_type.orders.where(status: [:pending, :approved, :confirmed], event_date: event_date)

    if event_date <= Date.today
      return render status: 400, json: { error: "A data deve ser futura" }.to_json
    end

    if same_day_events.any?
      return render status: 409, json: { error: "Data indisponível para este evento" }.to_json
    end

    if guest_number > event_type.max_guests
      return render status: 409, json: { error: "Quantidade de convidados excede o limite para este evento" }.to_json
    end

    estimated_price = calculate_price(event_type, event_date, guest_number)

    render status: 200, json: event_type.as_json(only: [:id, :name]).merge(estimated_price: estimated_price)
  end

  private

  def calculate_price(event_type, event_date, guest_number)
    base_price, extra_guest_price = if event_date.on_weekend?
                                      [event_type.we_base_price, event_type.we_extra_guest]
                                    else
                                      [event_type.base_price, event_type.extra_guest]
                                    end

    if guest_number > event_type.min_guests
      extra_guests = guest_number - event_type.min_guests
      base_price + (extra_guests * extra_guest_price)
    else
      base_price
    end
  end
end