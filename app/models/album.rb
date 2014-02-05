class Album < ActiveRecord::Base
	has_many :collections, dependent: :destroy
	has_many :users, through: :collections

	default_scope -> { order('created_at DESC') }

	validates_presence_of :title, :artist, :year, :format
	validates :year, format: {with: /\d/, message: "only allows numbers"}
	validates :format, inclusion: { in: %w(CD 2CD 3CD DVD 2LP LP 12" 10" 7" other), message: "%{value} is not a valid format" }

	attr_accessor :to_buy, :for_sale

end
