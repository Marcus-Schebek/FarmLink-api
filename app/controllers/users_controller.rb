class UsersController < ApplicationController
  skip_before_action :authorize_request, only: [:create]
  def create
    user = AppUser.new(user_params)
    if user.save
      render json: { message: "Usuário criado com sucesso" }, status: :created
    else
      render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private
  def user_params
    params.permit(:name, :phone, :email, :cpf_cnpj, :address, :password, :password_confirmation)
  end
end
