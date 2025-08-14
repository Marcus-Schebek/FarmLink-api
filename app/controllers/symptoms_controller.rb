class SymptomsController < ApplicationController
  before_action :set_symptom, only: %i[ show update destroy ]

  # GET /symptoms
  def index
    @symptoms = Symptom.all

    render json: @symptoms
  end

  # GET /symptoms/1
  def show
    render json: @symptom
  end

  # POST /symptoms
  def create
    @symptom = Symptom.new(symptom_params)

    if @symptom.save
      render json: @symptom, status: :created, location: @symptom
    else
      render json: @symptom.errors, status: :unprocessable_content
    end
  end

  # PATCH/PUT /symptoms/1
  def update
    if @symptom.update(symptom_params)
      render json: @symptom
    else
      render json: @symptom.errors, status: :unprocessable_content
    end
  end

  # DELETE /symptoms/1
  def destroy
    @symptom.destroy!
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_symptom
      @symptom = Symptom.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def symptom_params
      params.expect(symptom: [ :id_animal, :date_symptom, :description ])
    end
end
