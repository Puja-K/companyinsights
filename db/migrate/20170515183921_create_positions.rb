class CreatePositions < ActiveRecord::Migration[5.1]
  def change
    create_table :positions do |t|
    	t.string :title
    	t.text :description
    	t.text :job_expectation
    	t.decimal :avg_yrs_exp
    	t.text :criteria_for_next_level
    	t.timestamps
    end
  end
end
