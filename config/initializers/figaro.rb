unless Rails.env.test?
  Figaro.require_keys("github_client_id", "github_client_secret")
end
