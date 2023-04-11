class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    # サインアップする際にnameの値を送信することを許可
    devise_parameter_sanitizer.permit(:sign_up, keys: [ :avatar] )
    devise_parameter_sanitizer.permit(:account_update, keys: [ :avatar])
  end
end
