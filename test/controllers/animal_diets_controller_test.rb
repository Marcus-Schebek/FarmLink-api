require "test_helper"

class AnimalDietsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @animal_diet = animal_diets(:one)
  end

  test "should get index" do
    get animal_diets_url, as: :json
    assert_response :success
  end

  test "should create animal_diet" do
    assert_difference("AnimalDiet.count") do
      post animal_diets_url, params: { animal_diet: { daily_quantity: @animal_diet.daily_quantity, date_beginning: @animal_diet.date_beginning, date_end: @animal_diet.date_end, id_animal: @animal_diet.id_animal, id_diet: @animal_diet.id_diet } }, as: :json
    end

    assert_response :created
  end

  test "should show animal_diet" do
    get animal_diet_url(@animal_diet), as: :json
    assert_response :success
  end

  test "should update animal_diet" do
    patch animal_diet_url(@animal_diet), params: { animal_diet: { daily_quantity: @animal_diet.daily_quantity, date_beginning: @animal_diet.date_beginning, date_end: @animal_diet.date_end, id_animal: @animal_diet.id_animal, id_diet: @animal_diet.id_diet } }, as: :json
    assert_response :success
  end

  test "should destroy animal_diet" do
    assert_difference("AnimalDiet.count", -1) do
      delete animal_diet_url(@animal_diet), as: :json
    end

    assert_response :no_content
  end
end
