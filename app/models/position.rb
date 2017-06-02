class Position < ApplicationRecord
	validates :title, presence: true, length: {maximum: 40}
	validates :description, presence: true , length: {minimum: 30, maximum: 1000}
	validates :job_expectation, presence: true, length: {minimum: 30, maximum: 1000}
	validates :avg_yrs_exp, presence: true
	validates :criteria_for_next_level, presence: true, length: {minimum: 30, maximum: 1000}

	belongs_to :company
	validates :company_id, presence: true

	searchkick
end
