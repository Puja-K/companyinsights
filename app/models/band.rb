class Band < ApplicationRecord
  belongs_to :position
  belongs_to :internal_level

  after_commit :reindex_position

  def reindex_position
    Position.reindex # or reindex_async
  end
end
