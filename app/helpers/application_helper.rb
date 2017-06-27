module ApplicationHelper
  def nbsp_last_word(string)
    string.sub(/ ([a-z]+\.?)$/, "&nbsp;\\1").html_safe
  end
end
