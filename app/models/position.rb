class Position < ApplicationRecord
	validates :title, presence: true, length: {maximum: 50}
	validates :title, uniqueness: { scope: :company,
    message: "Already exists!!" , case_sensitive: false}
	#validates :description, presence: true , length: {minimum: 30, maximum: 1000}
	#validates :job_expectation, presence: true, length: {minimum: 30, maximum: 1000}
	#validates :avg_yrs_exp, presence: true
	#validates :criteria_for_next_level, presence: true, length: {minimum: 30, maximum: 1000}

	has_many :bands
	has_many :internal_levels, through: :bands
	#has_many :companies, through: :internal_levels
	belongs_to :company

	#defines the org/reporting structure
	has_many :active_relationships, class_name:  "Relationship",
                                  foreign_key: "reporter_id",
                                  dependent:   :destroy 

    has_many :reporting, through: :active_relationships, source: :reported

    has_many :passive_relationships, class_name:  "Relationship",
                                   foreign_key: "reported_id",
                                   dependent:   :destroy

    has_many :reporters, through: :passive_relationships, source: :reporter
    has_many :profiles

	searchkick word_start: [:title]
	scope :search_import, -> { includes(:company, :internal_levels) }
	after_commit :reindex_position

	  def reindex_position
	    Position.reindex # or reindex_async
	  end
	

	def search_data
	    attributes.merge(
	      title: title,
	      company_name: company.try(:name),
	      company_id: company.try(:id),
	      description: description,
	      internal_levels: "#{internal_levels.map(&:name).join(" ")}"
	    )
	end

	# Follows a user.
  def report(other_position)
    reporting << other_position
  end

  # Unfollows a user.
  def unreport(other_position)
    reporting.delete(other_position)
  end

  # Returns true if the current user is following the other user.
  def reporting?(other_position)
    reporting.include?(other_position)
  end

end
