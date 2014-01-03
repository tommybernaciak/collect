class Album < ActiveRecord::Base
	has_many :collections
	has_many :users, through: :collections

	validates_presence_of :title, :artist

end
