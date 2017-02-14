class HomeController < ApplicationController
  def contributors
    @subtitle = "Contributors"
    render :contributors
  end

  def maintainers
    @subtitle = "Maintainers"
    render :maintainers
  end

  def companies
    @subtitle = "Companies"
    render :companies
  end
end
