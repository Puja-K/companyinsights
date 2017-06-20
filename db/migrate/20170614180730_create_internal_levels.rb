class CreateInternalLevels < ActiveRecord::Migration[5.1]
  def change
    create_table :internal_levels do |t|
      t.references :company, foreign_key: true
      t.references :position, foreign_key: true
      t.string :name

      t.timestamps
    end
  end
end
