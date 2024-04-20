class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :check_buffet, if: :owner_signed_in?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
  end

  private

  def check_buffet
    return if request.path == destroy_owner_session_path || 
                              request.path == new_buffet_path ||
                             (request.path == buffets_path && request.post?)

    if current_owner.buffet.nil?
      redirect_to new_buffet_path, alert: 'Cadastre seu buffet antes de prosseguir.'
    end
  end

  def after_sign_in_path_for(resource)
    resource.instance_of?(Owner) && resource.buffet.nil? ? new_buffet_path : super
  end
end
