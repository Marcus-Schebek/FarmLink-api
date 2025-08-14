require "test_helper"

class SalesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @sale = sales(:one)
  end

  test "should get index" do
    get sales_url, as: :json
    assert_response :success
  end

  test "should create sale" do
    assert_difference("Sale.count") do
      post sales_url, params: { sale: { id_buyer: @sale.id_buyer, id_seller: @sale.id_seller, payment_method: @sale.payment_method, sale_date: @sale.sale_date, total_value: @sale.total_value } }, as: :json
    end

    assert_response :created
  end

  test "should show sale" do
    get sale_url(@sale), as: :json
    assert_response :success
  end

  test "should update sale" do
    patch sale_url(@sale), params: { sale: { id_buyer: @sale.id_buyer, id_seller: @sale.id_seller, payment_method: @sale.payment_method, sale_date: @sale.sale_date, total_value: @sale.total_value } }, as: :json
    assert_response :success
  end

  test "should destroy sale" do
    assert_difference("Sale.count", -1) do
      delete sale_url(@sale), as: :json
    end

    assert_response :no_content
  end
end
