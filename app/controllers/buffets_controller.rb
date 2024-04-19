class BuffetsController < ApplicationController
  def show
    @buffet = Buffet.find(params[:id])
  end

  def new
    @buffet = Buffet.new
  end

  def create
    @buffet = Buffet.new(buffet_params)
    @buffet.owner = current_owner
    if @buffet.save
      redirect_to @buffet, notice: 'Buffet cadastrado com sucesso.'
    else
      flash.now[:notice] = 'Não foi possível cadastrar o Buffet.'
      render 'new', status: 422
    end
  end

  private
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
      :description)
  end
end