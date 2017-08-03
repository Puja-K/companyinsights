class Relationship < ApplicationRecord
	belongs_to :reporter, class_name: "Position"
  	belongs_to :reported, class_name: "Position"
  	validates :reporter_id, presence: true
  	validates :reported_id, presence: true
  	belongs_to :profile
end
