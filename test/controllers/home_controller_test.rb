require "test_helper"

class HomeControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get root_url
    assert_response :success
  end

  test "should get businesses" do
    get businesses_url
    assert_response :success
  end

  test "should get maintainers" do
    get maintainers_url
    assert_response :success
  end
end
