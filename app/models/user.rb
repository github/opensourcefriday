class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable,
         omniauth_providers: [:github]

  def email
    nil
  end

  def email_required?
    false
  end

  def email_changed?
    false
  end

  def will_save_change_to_email?
    false
  end

  def self.github_auth(auth)
    github_username = auth.info.nickname
    user = find_or_create_by(github_username: github_username) do |u|
      u.github_username = github_username
      u.password = Devise.friendly_token[0, 20]
      u.oauth_token = auth.credentials.token
      u.language = I18n.locale
    end
    return unless user
    if user.oauth_token != auth.credentials.token
      user.update_attribute(:oauth_token, auth.credentials.token)
    end
    user
  end
end
