require "test_helper"

class ApplicationControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  test "should handle locale url parameter" do
    get root_url, params: { locale: "en" }
    assert_response :success
  end

  test "should handle wrong locale url parameter" do
    get root_url, params: { locale: "xx" }
    assert_response :success
  end

  test "should handle ACCEPT_LANGUAGE header" do
    get root_url, headers: { "Accept-Language" => "en-US" }
    assert_response :success
  end
end
