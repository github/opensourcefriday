require "test_helper"

class UsersControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  def mock_omniauth!
    OmniAuth.config.add_mock \
      :github,
      uid: "foobar",
      info: { nickname: "bar" },
      credentials: { token: "abc123" }
    Rails.application.env_config["omniauth.auth"] =
      OmniAuth.config.mock_auth[:github]
  end

  test "should get show when logged out" do
    VCR.use_cassette("user_mikemcquaid") do
      get user_url("MikeMcQuaid")
    end
    assert_response :success
  end

  test "should get show when logged in" do
    sign_in users(:test)
    VCR.use_cassette("user_mikemcquaid") do
      get user_url("MikeMcQuaid")
    end
    assert_response :success
  end

  test "should get show when logged in and viewing your own page" do
    sign_in users(:MikeMcQuaid)
    VCR.use_cassette("user_mikemcquaid") do
      get user_url("MikeMcQuaid")
    end
    assert_response :success
  end

  test "should get show when logged in and viewing japanese own page" do
    sign_in users(:Miurahr)
    VCR.use_cassette("user_miurahr") do
      get user_url("Miurahr")
    end
    assert_response :success
  end

  test "should sign in" do
    mock_omniauth!
    VCR.use_cassette("user_foobar") do
      get user_github_omniauth_authorize_url
      follow_redirect!
      follow_redirect!
    end
    assert_response :success
  end

  test "should handle sign in failures" do
    mock_omniauth!
    OmniAuth.config.mock_auth[:github] = :invalid_credentials
    VCR.use_cassette("user_foobar") do
      get user_github_omniauth_authorize_url
      follow_redirect!
      follow_redirect!
    end
    assert_response :success
  end

  test "should sign in with locale url parameter" do
    mock_omniauth!
    VCR.use_cassette("user_foobar") do
      get user_github_omniauth_authorize_url, params: { locale: "ja" }
      follow_redirect!
      follow_redirect!
      get root_url(locale: "en")
    end
    assert_response :success
  end
end
