class SessionsController < ApplicationController
  skip_before_action :require_login, only: [:create, :destroy]
  def create
    user = AppUser.find_by(email: params[:email])
    if user&.authenticate(params[:password])
      session[:user_id] = user.id
      render json: { message: "Login realizado com sucesso" }
    else
      render json: { error: "Credenciais inválidas" }, status: :unauthorized
    end
  end

  def destroy
    session.delete(:user_id)
    render json: { message: "Logout realizado com sucesso" }
  end
end
