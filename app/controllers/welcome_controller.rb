class WelcomeController < ApplicationController

  def index
    @titles = Title.all
  end

end
