class UsersController < ApplicationController
  # Pula a verificação de login apenas para a rota de criação de usuário
  skip_before_action :login_request, only: [:create]

def show
  user = AppUser.find(params[:id])
  render json: user
rescue ActiveRecord::RecordNotFound
  render json: { error: "Usuário não encontrado." }, status: :not_found
end
  
  def create
    user = AppUser.new(user_params)
    if user.save
      # Opcional: Gerar um token automaticamente no signup
      token = JsonWebToken.encode(user_id: user.id)
      render json: { message: "Usuário criado com sucesso", token: token }, status: :created
    else
      render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.permit(:name, :phone, :email, :cpf_cnpj, :address, :password, :password_confirmation)
  end
end