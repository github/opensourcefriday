module ApplicationHelper
  def nbsp_last_word(string)
    string.sub(/ ([a-z]+\.?)$/, "&nbsp;\\1").html_safe
  end

  def language_name(l)
    Rails.configuration.Languages[l.to_s]
  end
end
