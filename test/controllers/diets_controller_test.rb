require "test_helper"

class DietsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @diet = diets(:one)
  end

  test "should get index" do
    get diets_url, as: :json
    assert_response :success
  end

  test "should create diet" do
    assert_difference("Diet.count") do
      post diets_url, params: { diet: { aliment_type: @diet.aliment_type, cost_kg: @diet.cost_kg, nutrients: @diet.nutrients } }, as: :json
    end

    assert_response :created
  end

  test "should show diet" do
    get diet_url(@diet), as: :json
    assert_response :success
  end

  test "should update diet" do
    patch diet_url(@diet), params: { diet: { aliment_type: @diet.aliment_type, cost_kg: @diet.cost_kg, nutrients: @diet.nutrients } }, as: :json
    assert_response :success
  end

  test "should destroy diet" do
    assert_difference("Diet.count", -1) do
      delete diet_url(@diet), as: :json
    end

    assert_response :no_content
  end
end
