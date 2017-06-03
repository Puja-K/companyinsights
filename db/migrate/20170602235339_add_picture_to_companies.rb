class AddPictureToCompanies < ActiveRecord::Migration[5.1]
  def change
    add_column :companies, :picture, :string
  end
end
