class WelcomeController < ApplicationController
  def index
  	@welcome_message = 'Collect - Application for records collectors (message from welcome controller)'
  end

  def help
  end
end
