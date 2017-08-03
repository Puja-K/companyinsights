class AddRelationsipIdToProfiles < ActiveRecord::Migration[5.1]
  def change
    add_reference :profiles, :relationship, foreign_key: true
  end
end
