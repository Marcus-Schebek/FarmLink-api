class ApplicationController < ActionController::API
  include ActionController::Cookies

  before_action :require_login

  private
  def require_login
    unless session[:user_id]
      render json: { error: "Acesso não autorizado" }, status: :unauthorized
    end
  end
end
