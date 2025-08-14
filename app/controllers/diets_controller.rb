class DietsController < ApplicationController
  before_action :set_diet, only: %i[ show update destroy ]

  # GET /diets
  def index
    @diets = Diet.all

    render json: @diets
  end

  # GET /diets/1
  def show
    render json: @diet
  end

  # POST /diets
  def create
    @diet = Diet.new(diet_params)

    if @diet.save
      render json: @diet, status: :created, location: @diet
    else
      render json: @diet.errors, status: :unprocessable_content
    end
  end

  # PATCH/PUT /diets/1
  def update
    if @diet.update(diet_params)
      render json: @diet
    else
      render json: @diet.errors, status: :unprocessable_content
    end
  end

  # DELETE /diets/1
  def destroy
    @diet.destroy!
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_diet
      @diet = Diet.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def diet_params
      params.expect(diet: [ :aliment_type, :cost_kg, :nutrients ])
    end
end
