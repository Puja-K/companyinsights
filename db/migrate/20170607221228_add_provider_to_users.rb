class AddProviderToUsers < ActiveRecord::Migration[5.1]
  def change
  	add_column :users, :provider, :string
  	add_column :users, :oauth_id, :integer
  end
end
