class OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def github
    @user = User.github_auth(request.env["omniauth.auth"])
    if @user.persisted?
      sign_in_and_redirect @user
      if is_navigational_format?
        set_flash_message(:notice, :success, kind: "Github")
      end
    else
      session["devise.facebook_data"] = request.env["omniauth.auth"]
      redirect_to new_user_registration_url
    end
  end

  def failure
    redirect_to root_path
  end
end
