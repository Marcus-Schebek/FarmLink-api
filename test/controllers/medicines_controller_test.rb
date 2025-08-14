require "test_helper"

class MedicinesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @medicine = medicines(:one)
  end

  test "should get index" do
    get medicines_url, as: :json
    assert_response :success
  end

  test "should create medicine" do
    assert_difference("Medicine.count") do
      post medicines_url, params: { medicine: { cost: @medicine.cost, dosage: @medicine.dosage, manufacturer: @medicine.manufacturer, name: @medicine.name, type: @medicine.type } }, as: :json
    end

    assert_response :created
  end

  test "should show medicine" do
    get medicine_url(@medicine), as: :json
    assert_response :success
  end

  test "should update medicine" do
    patch medicine_url(@medicine), params: { medicine: { cost: @medicine.cost, dosage: @medicine.dosage, manufacturer: @medicine.manufacturer, name: @medicine.name, type: @medicine.type } }, as: :json
    assert_response :success
  end

  test "should destroy medicine" do
    assert_difference("Medicine.count", -1) do
      delete medicine_url(@medicine), as: :json
    end

    assert_response :no_content
  end
end
