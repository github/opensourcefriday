require "test_helper"
require "minitest/mock"
require "./app/models/mailchimp"

class SubscriptionsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  def mock_omniauth!
    OmniAuth.config.add_mock \
      :github,
      uid: "foobar",
      info: {
        nickname: "bar",
        name: "foobar",
        email: "foo@bar.com",
        token: "abc123",
      }
    Rails.application.env_config["omniauth.auth"] =
      OmniAuth.config.mock_auth[:github]
  end

  test "should get redirected when logged out" do
    post subscriptions_url
    assert_response :redirect
  end

  test "should track subscription when successful" do
    user = users(:test)
    sign_in user
    refute user.subscribed_to_newsletter, "should not be subscribed at first"

    MailChimp.stub(:subscribe, true) do
      post subscriptions_url
    end

    assert_response :redirect
    assert user.reload.subscribed_to_newsletter, "should be subscribed"
  end

  test "should not mark as subscribed if subscription failed" do
    user = users(:test)
    sign_in user
    refute user.subscribed_to_newsletter, "should not be subscribed at first"

    MailChimp.stub(:subscribe, false) do
      post subscriptions_url
    end

    assert_response :redirect
    refute user.reload.subscribed_to_newsletter, "should not be subscribed"
  end

  test "should not mark as subscribed on error" do
    user = users(:test)
    sign_in user
    refute user.subscribed_to_newsletter, "should not be subscribed at first"

    MailChimp.stub(:subscribe, ->(_) { raise StandardError, "boom" }) do
      post subscriptions_url
    end

    assert_response :redirect
    refute user.reload.subscribed_to_newsletter, "should not be subscribed"
  end
end
