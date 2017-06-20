class DropInternalLevelPositions < ActiveRecord::Migration[5.1]
  def change
  	drop_table :internal_levels_positions
  end
end
