class CompaniesController < ApplicationController

	before_action :set_company, only: [:show, :edit, :update]
	#def index
	#	@companies = Company.all
	#end

	def index
		if params[:term]
			#needed for case insensitive search
			if Rails.env.production?
				@companies = Company.order(:name).where("name ILIKE ?", "%#{params[:term]}%")
			else
				@companies = Company.order(:name).where("name like ?", "%#{params[:term]}%")
			end
    		render json: @companies.map(&:name)

    	else
    		@companies = Company.paginate(page: params[:page], per_page: 10)
    		
    	end

  	end
	
	def show
		
	end



	def search
		if params[:search_company].present?
			@companies= Company.search params[:search_company], fields: [:name]
			render 'index'
		else
			@companies = Company.paginate(page: params[:page], per_page: 10)

		end
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
		
	
	end

	def update
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

	def set_company
		@company = Company.find(params[:id])
	end

	def company_params
		params.require(:company).permit(:name, :company_type, :picture, :location, :industry)
	end
end