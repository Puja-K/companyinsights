class RemoveInternalLevelsFromProfiles < ActiveRecord::Migration[5.1]
  def change
    remove_column :profiles, :internal_levels_id
  end
end
