class Company < ApplicationRecord

	validates :name, presence: true
	validates :company_type, presence: true
	
	has_many :positions
end