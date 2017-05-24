class PositionsController < ApplicationController
	
	before_action :set_company, only: [:create, :update, :new]
	before_action :set_position, only: [:update, :edit]
	
	def new
		@position = Position.new
	end

	def create
    	@position = @company.positions.create(position_params)
		if @position.save
			flash[:success] ="Position was created successfully"
			redirect_to company_path(@company)
		else
			render 'new'
		end
	end

	def edit
		
	end

	def update
		if @position.update(position_params)
			flash[:success] = "This position was updated successfully!"
			redirect_to company_path(@company)
		else
			render 'edit'
		end
	end

	private

	def set_position
		@position = Position.find(params[:id])
	end
	def set_company
		@company = Company.find(params[:company_id])
	end

	def position_params
		params.require(:position).permit(:title, :description, :job_expectation, :avg_yrs_exp, :criteria_for_next_level)
	end
end
