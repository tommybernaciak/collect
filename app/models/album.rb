class Album < ActiveRecord::Base
	belongs_to :user

	validates_presence_of :title, :artist

	def album_in_collection?(album)
  	collections.find_by(album_id: album.id)
  end

  def add_to_collection!(album)
  	collections.create!(album_id: album.id)
  end

  def delete_from_collection!(album)
    collections.find_by(album_id: album.id).destroy!
  end

  def self.added_to_collection(user)
    album_ids = "SELECT album_id FROM collections WHERE user_id = :user_id", user_id: user.id
  end

end
