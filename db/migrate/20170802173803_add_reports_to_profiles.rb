class AddReportsToProfiles < ActiveRecord::Migration[5.1]
  def change
    add_reference :profiles, :you_report_to, foreign_key: true
  end
end
