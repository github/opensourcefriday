class HomeController < ApplicationController
  def businesses
    render :businesses
  end

  def maintainers
    render :maintainers
  end
end
