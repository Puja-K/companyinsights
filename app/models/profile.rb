class Profile < ApplicationRecord
  belongs_to :user
  belongs_to :company
  belongs_to :position
  belongs_to :internal_level, optional: true
end
