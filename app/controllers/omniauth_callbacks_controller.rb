class OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def github
    @user = User.github_auth(request.env["omniauth.auth"])
    return failure unless @user.persisted?

    sign_in_and_redirect @user
  end

  def failure
    redirect_to root_path
  end
end
