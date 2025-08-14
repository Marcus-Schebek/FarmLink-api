class AnimalsController < ApplicationController
  before_action :set_animal, only: %i[ show update destroy ]
  skip_before_action :authorize_request, only: [:index, :show]

  # GET /animals
  def index
    @animals = Animal.all

    render json: @animals
  end

  # GET /animals/1
  def show
    render json: @animal
  end

  # POST /animals
  def create
    @animal = Animal.new(animal_params)

    if @animal.save
      render json: @animal, status: :created, location: @animal
    else
      render json: @animal.errors, status: :unprocessable_content
    end
  end

  # PATCH/PUT /animals/1
  def update
    if @animal.update(animal_params)
      render json: @animal
    else
      render json: @animal.errors, status: :unprocessable_content
    end
  end

  # DELETE /animals/1
  def destroy
    @animal.destroy!
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_animal
      @animal = Animal.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def animal_params
      params.expect(animal: [ :ear_tag, :breed, :sex, :birth_date, :current_weight, :status, :production_objective, :lot_id, :id_owner ])
    end
end
