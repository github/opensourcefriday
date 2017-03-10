class HomeController < ApplicationController
  def contributors
    render :contributors
  end

  def maintainers
    render :maintainers
  end
end
