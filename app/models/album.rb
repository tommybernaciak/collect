class Album < ActiveRecord::Base
	has_many :collections
	has_many :users, through: :collections

	validates_presence_of :title, :artist
	validates :year, format: {with: /\d/, message: "only allows numbers"}
	validates :format, inclusion: { in: %w(CD DVD LP), message: "%{value} is not a valid format" }

end
