class HeatsController < ApplicationController
  before_action :set_heat, only: %i[ show update destroy ]

  # GET /heats
  def index
    @heats = Heat.all

    render json: @heats
  end

  # GET /heats/1
  def show
    render json: @heat
  end

  # POST /heats
  def create
    @heat = Heat.new(heat_params)

    if @heat.save
      render json: @heat, status: :created, location: @heat
    else
      render json: @heat.errors, status: :unprocessable_content
    end
  end

  # PATCH/PUT /heats/1
  def update
    if @heat.update(heat_params)
      render json: @heat
    else
      render json: @heat.errors, status: :unprocessable_content
    end
  end

  # DELETE /heats/1
  def destroy
    @heat.destroy!
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_heat
      @heat = Heat.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def heat_params
      params.expect(heat: [ :id_animal, :date_heat, :observation ])
    end
end
