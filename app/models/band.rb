class Band < ApplicationRecord
  belongs_to :position
  belongs_to :internal_level
end
