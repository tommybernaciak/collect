class Message < ActiveRecord::Base
	belongs_to :sender, :class_name=>'User', :foreign_key=>'sender_id'
  belongs_to :receiver, :class_name=>'User', :foreign_key=>'receiver_id'

  default_scope -> { order('created_at DESC') }

	validates :sender_id, presence: true
	validates :receiver_id, presence: true
	validates :content, presence: true, length: { maximum: 240 }
end
