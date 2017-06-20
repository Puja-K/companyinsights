class InternalLevelsController < ApplicationController
	before_action :set_company

	def new
		@level = InternalLevel.new
	end

	def create
		@level = @company.internal_levels.new(level_params)
		if @level.save
      		flash[:success] = "Successfully created #{@level.name}"
      		#@company.internal_levels
      		redirect_to new_company_internal_level_path(@company)
		else
			render 'new'
		end
	end

	def destroy
		@company.internal_levels.find(params[:id]).destroy
		#@company = InternalLevel.find(params[:id]).destroy
		flash[:success] = "Level deleted successfully !"
		redirect_to new_company_internal_level_path(@company)

	end

	private
	def set_company
		@company = Company.find(params[:company_id])
	end

	def level_params
		params.require(:internal_level).permit(:name)
	end

end