unless Rails.env.test?
  Figaro.require_keys("github_client_id", "github_client_secret")
end

if Rails.env.production?
  mailchimp_keys = %w[
    mailchimp_user
    mailchimp_api_key
    mailchimp_list_id
  ]
  Figaro.require_keys(*mailchimp_keys)
end
