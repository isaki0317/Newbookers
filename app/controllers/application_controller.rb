class ApplicationController < ActionController::Base

  before_action :configure_permitted_parameters, if: :devise_controller?

  def after_sign_in_path_for(resource)
      if current_user
        flash[:notice] = "ログインに成功しました"
        user_path(resource)
      else
        flash[:notice] = "新規登録完了しました"
        user_path(resource)
      end
  end

protected

  def configure_permitted_parameters
    #strong parametersを設定し、usernameを許可
    devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit(:name, :email, :password, :password_confirmation) }
    devise_parameter_sanitizer.permit(:sign_in) { |u| u.permit(:name, :password, :password_confirmation) }
  end

end
