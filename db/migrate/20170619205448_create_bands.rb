class CreateBands < ActiveRecord::Migration[5.1]
  def change
    create_table :bands do |t|
      t.references :position, foreign_key: true, index: true
      t.references :internal_level, foreign_key: true, index: true

      t.timestamps
    end
  end
end
