class UsersController < ApplicationController
  skip_before_action :login_request, only: [:create]
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