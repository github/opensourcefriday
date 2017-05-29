class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable,
         omniauth_providers: [:github]

  def self.github_auth(auth)
    where(github_uid: auth.uid).first_or_create do |user|
      user.github_uid = auth.uid
      user.github_username = auth.info.nickname
      user.github_name = auth.info.name
      user.email = auth.info.email
      user.password = Devise.friendly_token[0, 20]
      user.oauth_token = auth.info.token
    end
  end
end
