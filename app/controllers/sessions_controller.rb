class SessionsController < ApplicationController
  skip_before_action :login_request, only: [:create, :destroy]
  def create
    user = AppUser.find_by(email: params[:email])
    if user && user.authenticate(params[:password])
      # Gera o token JWT com o ID do usuário
      token = JsonWebToken.encode(user_id: user.id)
      render json: { message: "Login realizado com sucesso", token: token, user_id: user.id }, status: :ok
    else
      render json: { error: "Credenciais inválidas" }, status: :unauthorized
    end
  end

  def destroy
    # Com JWT, o "logout" é simplesmente descartar o token no lado do cliente.
    # Não há nada para "destruir" no servidor, pois não há estado de sessão.
    render json: { message: "Logout simulado com sucesso (descarte o token no cliente)" }
  end
end