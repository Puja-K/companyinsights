class AddProfileIdToRelationships < ActiveRecord::Migration[5.1]
  def change
    add_reference :relationships, :profile, foreign_key: true, index: true
  end
end
