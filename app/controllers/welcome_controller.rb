class WelcomeController < ApplicationController
  def index
  	@welcome_message = 'ReCollect - Application for records collectors (message from welcome controller)'
  end
  # static pages
  def help
  end

  def about
  end

  def contact
  end
end
