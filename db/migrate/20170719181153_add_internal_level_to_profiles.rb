class AddInternalLevelToProfiles < ActiveRecord::Migration[5.1]
  def change
    add_reference :profiles, :internal_level, foreign_key: true
  end
end
