class AddCompanyIdToPositions < ActiveRecord::Migration[5.1]
  def change
  	add_column :positions, :company_id, :integer, index: true
  end
end
