class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  def after_sign_in_path_for(resource)
    flowers_path(resource)
  end

  protected

  def configure_permitted_parameters
    # サインアップする際にnameの値を送信することを許可
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :profile_image] )
    devise_parameter_sanitizer.permit(:account_update, keys: [:name, :profile_image])
  end
end
