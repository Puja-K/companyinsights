class InternalLevel < ApplicationRecord
  belongs_to :company
  has_many :bands #, dependent: :destroy
  has_many :positions, through: :bands
  validates :name, presence: :true, uniqueness: { case_sensitive: false }
end
