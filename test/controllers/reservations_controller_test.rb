require "test_helper"

class ReservationsControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get reservations_create_url
    assert_response :success
  end

  test "should get destroy" do
    get reservations_destroy_url
    assert_response :success
  end

  test "should get index" do
    get reservations_index_url
    assert_response :success
  end
end
