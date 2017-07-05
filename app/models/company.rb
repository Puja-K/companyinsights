class Company < ApplicationRecord

	validates :name, presence: true
	validates :company_type, presence: true
	mount_uploader :picture, PictureUploader
	has_many :internal_levels
	#has_many :positions, through: :internal_levels
	validate  :picture_size
	has_many :positions, dependent: :destroy

	#searchkick 

	
	

	private

    # Validates the size of an uploaded picture.
    def picture_size
      if picture.size > 5.megabytes
        errors.add(:picture, "should be less than 5MB")
      end
    end
end