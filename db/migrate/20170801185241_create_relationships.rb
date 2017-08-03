class CreateRelationships < ActiveRecord::Migration[5.1]
  def change
    create_table :relationships do |t|
      t.integer :reporter_id
      t.integer :reported_id

      t.timestamps
    end
    add_index :relationships, :reporter_id
    add_index :relationships, :reported_id
    add_index :relationships, [:reporter_id, :reported_id], unique: true
  end
end
