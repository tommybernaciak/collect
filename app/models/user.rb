class User < ActiveRecord::Base
	has_many :posts

	#attr_accessor :nick, :email

	validates_presence_of :email, :nick

	def is_admin?
    	role == "admin"
  	end

  	def is_user?
    	role == "user"
  	end
end
