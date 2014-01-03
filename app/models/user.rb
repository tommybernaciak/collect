class User < ActiveRecord::Base
	has_many :posts, dependent: :destroy

	#relationship - to follow/unfollow users
	has_many :relationships, foreign_key: "follower_id", dependent: :destroy
	has_many :followed_users, through: :relationships, source: :followed
	has_many :reverse_relationships, foreign_key: "followed_id", class_name: "Relationship", dependent: :destroy
 	has_many :followers, through: :reverse_relationships, source: :follower

 	#collections and albums
 	has_many 	:collections, class_name: "Collection", dependent: :destroy
 	has_many	:albums, through: :collections

	before_save { self.email = email.downcase }
	before_create :create_remember_token

	#password and email validation
	has_secure_password
	validates :password, length: { minimum: 6 }
	validates_presence_of :email, :nick
	validates :nick, length: { maximum: 30, minimum: 5 }
	validates_uniqueness_of :nick, :email
	VALID_EMAIL = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
	validates :email, format: { with: VALID_EMAIL }

	# used for profile_photo
	has_attached_file :profile_photo, :styles => {:avatar => "130x130>", :small_avatar => "60x60>"},
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
		Post.from_users_followed_by(self)
	end

	def following?(other_user)
  	relationships.find_by(followed_id: other_user.id)
  end

  def follow!(other_user)
    relationships.create!(followed_id: other_user.id)
  end

  def unfollow!(other_user)
    relationships.find_by(followed_id: other_user.id).destroy!
  end

	def collected?(some_album)
  	collections.find_by(album_id: some_album.id)
  end

  def collect!(some_album)
    collections.create!(album_id: some_album.id)
  end

  def uncollect!(some_album)
    collections.find_by(album_id: some_album.id).destroy!
  end

  private

  def create_remember_token
    self.remember_token = User.encrypt(User.new_remember_token)
  end

end
