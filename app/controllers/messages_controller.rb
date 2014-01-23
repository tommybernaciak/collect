class MessagesController < ApplicationController
	before_action :signed_in_user
  #before_action :set_message, only: [:index]

  def index
    @all_sent_messages = current_user.sent_messages.all
    @all_received_messages = current_user.received_messages.all
    #@message = Message.find(params[:message][:id])
    #@sender = User.find(@message.sender_id)
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

  # Use callbacks to share common setup or constraints between actions.
    #def set_message
    #  @message = Message.find(params[:id])
    #end

    def message_params
      params.require(:message).permit(:content, :receiver_id, :sender_id)
    end
end
