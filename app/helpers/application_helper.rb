module ApplicationHelper
  def nbsp_last_word(string)
    raise "#{string} is not HTML safe!" unless string.html_safe?

    # We're not adding any user input here and the string is already safe so
    # it's fine to force html_safe afterwards
    string.sub(/ ([a-z]+\.?)$/, "&nbsp;\\1")
          .html_safe # rubocop:disable Rails/OutputSafety
  end

  def language_name(locale)
    Rails.configuration.Languages[locale.to_s].capitalize
  end
end
