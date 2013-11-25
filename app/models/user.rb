class User < ActiveRecord::Base
	has_many :posts

	before_save { self.email = email.downcase }

	has_secure_password
	validates :password, length: { minimum: 6 }


	validates_presence_of :email, :nick
	validates :nick, length: { maximum: 30, minimum: 5 }
	validates_uniqueness_of :nick, :email
	VALID_EMAIL = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
	validates :email, format: { with: VALID_EMAIL }

	ROLES = %w{admin user}


	def is_admin?
    	role == "admin"
  	end

  	def is_user?
    	role == "user"
  	end
end
