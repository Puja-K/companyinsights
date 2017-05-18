class CompaniesController < ApplicationController
	def index
		@companies = Company.all
	end

	def show
		@company = Company.find(params[:id])
	end

	def new
		@company = Company.new
	end

	def create
		@company = Company.new(company_params)
		if @company.save
			flash[:success] ="Company was created successfully"
			redirect_to company_path(@company)
		else
			render 'new'
		end
				
	end

	#submits to update
	def edit
		@company = Company.find(params[:id])
	
	end

	def update
		@company = Company.find(params[:id])
		if @company.update(company_params)
			flash[:success] = "Company was updated successfully!"
			redirect_to company_path(@company)
		else
			render 'edit'
		end
	end

	def destroy
		@company = Company.find(params[:id]).destroy
		flash[:success] = "Company delete successfully !"
		redirect_to companies_path

	end

	private

	def company_params
		params.require(:company).permit(:name, :company_type)
	end
end