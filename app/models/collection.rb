class Collection < ActiveRecord::Base
	belongs_to 	:user
	belongs_to 	:album
	validates 	:user_id, presence: true
	validates 	:album_id, presence: true
end
