class AnimalDietsController < ApplicationController
  before_action :set_animal_diet, only: %i[ show update destroy ]

  # GET /animal_diets
  def index
    @animal_diets = AnimalDiet.all

    render json: @animal_diets
  end

  # GET /animal_diets/1
  def show
    render json: @animal_diet
  end

  # POST /animal_diets
  def create
    @animal_diet = AnimalDiet.new(animal_diet_params)

    if @animal_diet.save
      render json: @animal_diet, status: :created, location: @animal_diet
    else
      render json: @animal_diet.errors, status: :unprocessable_content
    end
  end

  # PATCH/PUT /animal_diets/1
  def update
    if @animal_diet.update(animal_diet_params)
      render json: @animal_diet
    else
      render json: @animal_diet.errors, status: :unprocessable_content
    end
  end

  # DELETE /animal_diets/1
  def destroy
    @animal_diet.destroy!
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_animal_diet
      @animal_diet = AnimalDiet.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def animal_diet_params
      params.expect(animal_diet: [ :id_animal, :id_diet, :date_beginning, :date_end, :daily_quantity ])
    end
end
