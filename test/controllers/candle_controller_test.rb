require "test_helper"

class CandleControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get candle_create_url
    assert_response :success
  end

  test "should get new" do
    get candle_new_url
    assert_response :success
  end

  test "should get destroy" do
    get candle_destroy_url
    assert_response :success
  end

  test "should get show" do
    get candle_show_url
    assert_response :success
  end

  test "should get edit" do
    get candle_edit_url
    assert_response :success
  end

  test "should get update" do
    get candle_update_url
    assert_response :success
  end
end
