class AddWhoReportsToYouIdToProfiles < ActiveRecord::Migration[5.1]
  def change
  	add_reference :profiles, :who_reports_to_you, foreign_key: {to_table: :positions}
  end
end
