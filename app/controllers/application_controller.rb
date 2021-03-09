class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :set_language

  def set_language
    I18n.locale =
      if user_signed_in?
        if params[:locale].present? && available_language?(params[:locale])
          current_user.language = params[:locale]
          current_user.save!
        end
        current_user.language
      else
        determine_language
      end
  end

  def default_url_options(*)
    locale =
      if I18n.locale && available_language?(I18n.locale) &&
         I18n.locale != I18n.default_locale
        I18n.locale
      end

    {
      locale: locale,
    }
  end

  def after_sign_in_path_for(_resource)
    user_path(current_user.github_username)
  end

  private

  def determine_language
    if params[:locale].present? && available_language?(params[:locale])
      return params[:locale]
    end

    language = request.env["HTTP_ACCEPT_LANGUAGE"] || ""
    language = language.scan(/^[a-z]{2}/).first
    return language if available_language?(language)

    I18n.default_locale
  end

  def available_language?(language)
    I18n.available_locales.map(&:to_s).include?(language)
  end
end
