class User < ActiveRecord::Base
	has_many :posts

	before_save { self.email = email.downcase }
	before_create :create_remember_token

	has_secure_password
	validates :password, length: { minimum: 6 }

	validates_presence_of :email, :nick
	validates :nick, length: { maximum: 30, minimum: 5 }
	validates_uniqueness_of :nick, :email
	VALID_EMAIL = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
	validates :email, format: { with: VALID_EMAIL }

	def User.new_remember_token
    	SecureRandom.urlsafe_base64
  	end

	def User.encrypt(token)
	   	Digest::SHA1.hexdigest(token.to_s)
	end

  private

    def create_remember_token
      self.remember_token = User.encrypt(User.new_remember_token)
    end

end
