class PositionsController < ApplicationController
	
	before_action :set_company, only: [:create, :update, :new, :edit]
	before_action :set_position, only: [:update, :edit]
	

	def search
		if params[:company].present? && params[:search_position].present?

			#query = Company.joins(:positions).where('positions.title' => params[:search_position]) 
			@positions = Position.search(params[:search_position], fields: [:title], load: false, where: {company_id: params[:company][:company_id]})
			#@positions = Company.search query
		else
			flash[:success] = "Sorry search returned 0 results"
			redirect_to root_url

		end
	end

	def new
		@position = Position.new
	end

	def create

		puts params[:position][:internal_level_ids]

		@position = @company.positions.create!(position_params)
		#@position.internal_level_ids << params[:position][:internal_level_ids]
		#@position.save
		#@position.internal_levels << @internal_level
		redirect_to company_path(@company)
		

	end

	def create_old
		Position.transaction do
			Company.transaction do
				@position = Position.new(position_params)
				if @position.save
					@company = @company.internal_levels.new(position: @position, name: params[:internal_level][:name])
						if @company.save
							flash[:success] ="Position was created successfully"
							redirect_to company_path(@company)
						else
							raise 'Position did not save'
							render 'new'
						end
				else
					raise 'Position did not save'
					flash[:error] = "Position did not save"
					render 'new'
				end
				

			end
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
		params.require(:position).permit(:title, :description, :job_expectation, :avg_yrs_exp, :criteria_for_next_level, internal_level_ids: [])
	end
end
