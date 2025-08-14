class MedicinesController < ApplicationController
  before_action :set_medicine, only: %i[ show update destroy ]

  # GET /medicines
  def index
    @medicines = Medicine.all

    render json: @medicines
  end

  # GET /medicines/1
  def show
    render json: @medicine
  end

  # POST /medicines
  def create
    @medicine = Medicine.new(medicine_params)

    if @medicine.save
      render json: @medicine, status: :created, location: @medicine
    else
      render json: @medicine.errors, status: :unprocessable_content
    end
  end

  # PATCH/PUT /medicines/1
  def update
    if @medicine.update(medicine_params)
      render json: @medicine
    else
      render json: @medicine.errors, status: :unprocessable_content
    end
  end

  # DELETE /medicines/1
  def destroy
    @medicine.destroy!
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_medicine
      @medicine = Medicine.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def medicine_params
      params.expect(medicine: [ :name, :manufacturer, :dosage, :type, :cost ])
    end
end
