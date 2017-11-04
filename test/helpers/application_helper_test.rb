require "test_helper"
require "application_helper"
require Rails.root.join("config/initializers/constants")

class ApplicationHelperTest < ActionDispatch::IntegrationTest
  include ApplicationHelper
  test "should nbsp_last_word returns last word" do
    assert_equal "abc def&nbsp;ghi", nbsp_last_word("abc def ghi")
  end
  test "language_name(:en) should returns English" do
    assert_equal "English", language_name(:en)
  end
end
