class Profile < ApplicationRecord
  belongs_to :user
  belongs_to :company
  belongs_to :position
  belongs_to :internal_level, optional: true
 # belongs_to :reporter, optional: true, class_name: "Position", foreign_key: :you_report_to_id
  belongs_to :you_report_to, optional: true, class_name: "Position", foreign_key: :you_report_to_id
  belongs_to :who_reports_to_you, optional: true, class_name: "Position", foreign_key: :who_reports_to_you_id
  
  has_many :relationships
end
