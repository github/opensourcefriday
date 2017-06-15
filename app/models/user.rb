class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable,
         omniauth_providers: [:github]

  def self.github_auth(auth)
    user = where(github_uid: auth.uid).first_or_create do |u|
      u.github_uid = auth.uid
      u.github_username = auth.info.nickname
      u.github_name = auth.info.name
      u.email = auth.info.email
      u.password = Devise.friendly_token[0, 20]
      u.oauth_token = auth.credentials.token
    end
    if user && !user.oauth_token && auth.credentials.token
      user.update_attribute(:oauth_token, auth.credentials.token)
    end
    user
  end
end
