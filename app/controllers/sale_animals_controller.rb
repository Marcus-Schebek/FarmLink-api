class SaleAnimalsController < ApplicationController
  before_action :set_sale_animal, only: [:show, :update, :destroy]

  # GET /sale_animals
  def index
    sale_animals = SaleAnimal.all
    render json: sale_animals
  end

  # GET /sale_animals/:id
  def show
    render json: @sale_animal
  end

  # POST /sale_animals
  def create
    sale_animal = SaleAnimal.new(sale_animal_params)
    if sale_animal.save
      render json: sale_animal, status: :created
    else
      render json: { errors: sale_animal.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /sale_animals/:id
  def update
    if @sale_animal.update(sale_animal_params)
      render json: @sale_animal
    else
      render json: { errors: @sale_animal.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # DELETE /sale_animals/:id
  def destroy
    @sale_animal.destroy
    head :no_content
  end

  private

  def set_sale_animal
    @sale_animal = SaleAnimal.find(params[:id])
  end

  def sale_animal_params
    params.require(:sale_animal).permit(:sale_id, :animal_id)
  end
end