require "test_helper"

class LotsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @lot = lots(:one)
  end

  test "should get index" do
    get lots_url, as: :json
    assert_response :success
  end

  test "should create lot" do
    assert_difference("Lot.count") do
      post lots_url, params: { lot: { creation_date: @lot.creation_date, origin_location: @lot.origin_location } }, as: :json
    end

    assert_response :created
  end

  test "should show lot" do
    get lot_url(@lot), as: :json
    assert_response :success
  end

  test "should update lot" do
    patch lot_url(@lot), params: { lot: { creation_date: @lot.creation_date, origin_location: @lot.origin_location } }, as: :json
    assert_response :success
  end

  test "should destroy lot" do
    assert_difference("Lot.count", -1) do
      delete lot_url(@lot), as: :json
    end

    assert_response :no_content
  end
end
