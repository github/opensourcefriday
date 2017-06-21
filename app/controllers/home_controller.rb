class HomeController < ApplicationController
  def businesses
    render :businesses
  end

  def maintainers
    render :maintainers
  end

  def boomtown
    raise "Welcome to Boom Town!"
  end
end
