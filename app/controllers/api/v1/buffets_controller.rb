class Api::V1::BuffetsController < ActionController::API
  def show
    buffet = Buffet.find(params[:id])
    render status: 200, json: buffet
  end
end