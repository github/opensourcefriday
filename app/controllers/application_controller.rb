class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :set_language

  def set_language
    I18n.locale =
      if user_signed_in?
        current_user.language
      else
        determine_language
      end
  end

  def default_url_options(*)
    { locale: I18n.locale == I18n.default_locale ? nil : I18n.locale }
  end

  def after_sign_in_path_for(_resource)
    user_path(current_user.github_username)
  end

  private

  def determine_language
    if params[:locale].present? && available_language?(params[:locale])
      params[:locale]
    else
      language = request.env["HTTP_ACCEPT_LANGUAGE"] || ""
      language = language.scan(/^[a-z]{2}/).first
      if available_language?(language)
        language
      else
        I18n.default_locale
      end
    end
  end

  def available_language?(language)
    I18n.available_locales.map(&:to_s).include?(language)
  end
end
