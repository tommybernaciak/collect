class Message < ActiveRecord::Base
	#belongs_to :user

	belongs_to :sender, :class_name=>'User', :foreign_key=>'sender_id'
  belongs_to :receiver, :class_name=>'User', :foreign_key=>'receiver_id'

	#scope :sent, where(:sent => true)
	#scope :received, where(:sent => false)

	validates :sender_id, presence: true
	validates :receiver_id, presence: true
	validates :content, presence: true, length: { maximum: 240 }

	#ef send_message(sender, receiver)
	#	receiver.message.
  #  receivers.each do |receiver|
  #    msg = self.clone
  #    msg.sent = false
  #    msg.user_id = receiver
  #    msg.save
  #  end
  #  self.update_attributes :user_id => from.id, :sent => true
  #end   
end
