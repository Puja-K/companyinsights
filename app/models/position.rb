class Position < ApplicationRecord
	#validates :title, presence: true, length: {maximum: 40}
	#validates :description, presence: true , length: {minimum: 30, maximum: 1000}
	#validates :job_expectation, presence: true, length: {minimum: 30, maximum: 1000}
	#validates :avg_yrs_exp, presence: true
	#validates :criteria_for_next_level, presence: true, length: {minimum: 30, maximum: 1000}

	has_many :bands
	has_many :internal_levels, through: :bands
	#has_many :companies, through: :internal_levels
	belongs_to :company

	searchkick
end
