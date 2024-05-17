class Api::V1::BuffetsController < Api::V1::ApiController
  def index
    if params[:search].present?
      query = params[:search].downcase
      buffets = Buffet.where("brand_name LIKE :query OR city LIKE :query", query: "%#{query}%")
      render status: 200, json: serialize_buffets(buffets)
    else
      buffets = Buffet.all.order(:brand_name)
      render status: 200, json: serialize_buffets(buffets)
    end
  end

  def show
    buffet = Buffet.find(params[:id])
    render status: 200, json: serialize_buffet(buffet)
  end

  private

  def serialize_buffets(buffets)
    buffets.as_json(include: {payment_methods: {only: [:name]}}, except: [:corporate_name, :registration_code,
                                                                          :created_at, :updated_at, :owner_id])
  end

  def serialize_buffet(buffet)
    buffet.as_json(include: {payment_methods: {only: [:name]}}, except: [:corporate_name, :registration_code,
                                                                         :created_at, :updated_at, :owner_id])
  end
end