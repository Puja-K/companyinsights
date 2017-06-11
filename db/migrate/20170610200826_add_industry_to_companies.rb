class AddIndustryToCompanies < ActiveRecord::Migration[5.1]
  def change
  	add_column :companies, :industry, :string
  	add_column :companies, :location, :string
  end
end
