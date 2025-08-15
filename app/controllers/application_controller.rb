class ApplicationController < ActionController::API
  before_action :login_request

  def current_user
    @current_user ||= AppUser.find(session[:user_id]) if session[:user_id]
  end

  def logged_in?
    !!current_user
  end


  private

  def login_request
    header = request.headers['Authorization']
    token = header.split(' ').last if header

    if token
      decoded_token = JsonWebToken.decode(token)
      if decoded_token
        # Encontra o usuário pelo ID do token
        @current_user = AppUser.find_by(id: decoded_token[:user_id])
      end
    end

    unless @current_user
      render json: { error: 'Não autorizado ou token inválido/expirado' }, status: :unauthorized
    end
  rescue JWT::DecodeError => e
    render json: { error: "Token inválido: #{e.message}" }, status: :unauthorized
  end
end