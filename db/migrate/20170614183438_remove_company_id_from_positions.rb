class RemoveCompanyIdFromPositions < ActiveRecord::Migration[5.1]
  def change
  	remove_column :positions, :company_id, :integer
  end
end
