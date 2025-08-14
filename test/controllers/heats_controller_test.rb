require "test_helper"

class HeatsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @heat = heats(:one)
  end

  test "should get index" do
    get heats_url, as: :json
    assert_response :success
  end

  test "should create heat" do
    assert_difference("Heat.count") do
      post heats_url, params: { heat: { date_heat: @heat.date_heat, id_animal: @heat.id_animal, observation: @heat.observation } }, as: :json
    end

    assert_response :created
  end

  test "should show heat" do
    get heat_url(@heat), as: :json
    assert_response :success
  end

  test "should update heat" do
    patch heat_url(@heat), params: { heat: { date_heat: @heat.date_heat, id_animal: @heat.id_animal, observation: @heat.observation } }, as: :json
    assert_response :success
  end

  test "should destroy heat" do
    assert_difference("Heat.count", -1) do
      delete heat_url(@heat), as: :json
    end

    assert_response :no_content
  end
end
