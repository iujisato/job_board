class Job < ActiveRecord::Base
	has_many :comments
 	scope :most_recent, -> {
 		order("created_at DESC")
 		}
 	validates_presence_of :description, :title
end
