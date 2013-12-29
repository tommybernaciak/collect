class User < ActiveRecord::Base
	has_many :posts, dependent: :destroy

	before_save { self.email = email.downcase }
	before_create :create_remember_token

	has_secure_password
	validates :password, length: { minimum: 6 }
	validates_presence_of :email, :nick
	validates :nick, length: { maximum: 30, minimum: 5 }
	validates_uniqueness_of :nick, :email
	VALID_EMAIL = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
	validates :email, format: { with: VALID_EMAIL }

	has_attached_file :profile_photo, :styles => {:avatar => "130x130>"},
					:url  => "/assets/users/:id/:style/:basename.:extension",
                 	:path => ":rails_root/public/assets/users/:id/:style/:basename.:extension"

	validates_attachment_presence :profile_photo
	validates_attachment_size :profile_photo, :less_than => 5.megabytes
	validates_attachment_content_type :profile_photo, :content_type => ['image/jpeg', 'image/png']

	def User.new_remember_token
    	SecureRandom.urlsafe_base64
  	end

	def User.encrypt(token)
	   	Digest::SHA1.hexdigest(token.to_s)
	end

	def feed
  		posts
	end

  private

    def create_remember_token
      self.remember_token = User.encrypt(User.new_remember_token)
    end

end
