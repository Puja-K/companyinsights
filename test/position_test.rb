require 'test_helper'

class PositionTest < ActiveSupport::TestCase
	
	def setup
		@position = Position.new(title: "Project Manager", description: "Responsible for planning, managing, executing, and controlling the project deliverables", 
			job_expectation: "Responsible for planning, managing, executing, and controlling the project deliverables", avg_yrs_exp: "5", criteria_for_next_level: " Ability to manage 2-3 different programs")
	end

	test "position should be valid" do
	    assert @position.valid?
	  end  
	  
	  test "title should be present" do
	    @position.title = " "
	    assert_not @position.valid?
	  end
	  
	  test "description should be present" do
	    @position.description = " "
	    assert_not @recipe.valid?
	  end
	  
	  test "description shouldn't be less than 30 characters" do
	    @position.description = "a" * 3
	    assert_not @position.valid?
	  end
	  
	  test "description shouldn't be more than 500 characters" do
	    @position.description = "a" * 501
	    assert_not @postion.valid?
	  end
end
