class MessagesController < ApplicationController
	before_action :signed_in_user

  def index
    @messages = current_user.sent_messages.all
  end

	def new
  	@message = current_user.sent_messages.build :receiver_id => params[:user_id]
  end

  def create
		@message = current_user.sent_messages.create(message_params)
  	if @message.save
  		flash[:notice] = "Successfully created message."
  		redirect_to root_url
		else
  		render :action => 'new'
  	end
 	end

 	private
    def message_params
      params.require(:message).permit(:content, :receiver_id, :sender_id)
    end
end
