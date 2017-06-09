require_relative "../models/mailchimp"

class SubscriptionsController < ApplicationController
  # Subscribe to the MailChimp newsletter.
  def create
    redirect_to "/" and return unless current_user

    error = begin
      !MailChimp.subscribe(params[:email])
    rescue StandardError => e
      Rails.logger.error(e)
      true
    end

    if error
      flash[:error] = "We were unable to sign you up for the newsletter."
    else
      current_user.update_attributes(subscribed_to_newsletter: true)
    end

    redirect_to format("/users/%s", current_user.github_username)
  end
end
