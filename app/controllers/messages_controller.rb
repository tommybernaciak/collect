class MessagesController < ApplicationController
	before_action :signed_in_user

	def new
  	@message = current_user.sent_messages.build :receiver_id => params[:user_id]
  	#@message = Message.new
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
    #def set_post
    #  @post = Post.find(params[:id])
    #end
    # Never trust parameters from the internet, only allow the white list through.
    def message_params
      params.require(:message).permit(:content, :receiver_id, :sender_id)
    end
end
