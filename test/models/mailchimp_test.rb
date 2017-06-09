require "test_helper"
require "./app/models/mailchimp"

class MailChimpTest < ActiveSupport::TestCase
  test "fails to subscribe without email" do
    refute MailChimp.subscribe("")
  end

  test "subscribes user" do
    VCR.use_cassette("mailchimp_kytrinyx") do
      MailChimp.subscribe("katrina.owen@gmail.com")
    end
  end
end
