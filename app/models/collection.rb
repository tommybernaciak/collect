class Collection < ActiveRecord::Base
	belongs_to :user	
	validates :user_id, presence: true
  validates :album_id, presence: true
end
