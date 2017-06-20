class CreateJoinTablePositionInternalLevel < ActiveRecord::Migration[5.1]
  def change
    create_join_table :positions, :internal_levels do |t|
      t.references :position, foreign_key: true, index: true
      t.references :internal_level, foreign_key: true, index: true
    end
  end
end
