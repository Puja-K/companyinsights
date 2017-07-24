class CreateProfiles < ActiveRecord::Migration[5.1]
  def change
    create_table :profiles do |t|
      t.text :promotion_criteria
      t.references :user, foreign_key: true
      t.references :company, foreign_key: true
      t.references :position, foreign_key: true
      t.references :internal_levels, foreign_key: true

      t.timestamps
    end
  end
end
