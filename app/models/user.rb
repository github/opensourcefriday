class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable,
         omniauth_providers: [:github]

  def email_required?
    false
  end

  def email_changed?
    false
  end

  def self.github_auth(auth)
    github_username = auth.info.nickname
    user = where(github_username: github_username).first_or_create do |u|
      u.github_username = github_username
      u.password = Devise.friendly_token[0, 20]
      u.oauth_token = auth.credentials.token
      u.language = I18n.locale
    end
    if user && user.oauth_token != auth.credentials.token
      user.update_attribute(:oauth_token, auth.credentials.token)
    end
    user
  end
end
