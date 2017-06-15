require "test_helper"
require "./app/models/mailchimp"

class MailChimpTest < ActiveSupport::TestCase
  def before
    @old_env = ENV.to_hash
  end

  def after
    ENV.replace @old_env
  end

  test "fails to subscribe without email" do
    refute MailChimp.subscribe("")
  end

  test "subscribes user" do
    ENV["mailchimp_api_key"] = "foo-us11"
    ENV["mailchimp_list_id"] = "MAILCHIMP_LIST_ID"
    VCR.use_cassette("mailchimp_kytrinyx") do
      MailChimp.subscribe("katrina.owen@gmail.com")
    end
  end
end
