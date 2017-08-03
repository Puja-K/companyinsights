class PositionsController < ApplicationController
	
	before_action :set_company, only: [:create, :update, :new, :edit]
	before_action :set_position, only: [:update, :edit]
	

	def index
		if params[:term]
			if Rails.env.production?
				@titles = Position.select("distinct title").where("title ILIKE ?", "%#{params[:term]}%").order(:title)
			else
				@titles = Position.select("distinct title").where("title like ?", "%#{params[:term]}%").order(:title)
			end
    		render json: @titles.map(&:title)
    	end

    	
  	end
	

	def search
		if params[:search_company].present? && params[:search_position].present?

			#@company = Company.find_by_name(params[:search_company])
			@company = Company.where('lower(name)= ?', params[:search_company].downcase).first

			#query = Company.joins(:positions).where('positions.title' => params[:search_position]) 
			if !@company.nil?
				@results = Position.search(params[:search_position], fields: [:title], match: :word_start, load: false, where: {company_id: @company.id})
				puts @results.size
				position = @results.first
				@results.each do |position|
					puts position.title
  					puts position.company_name
  					puts position.internal_levels

				end
				if @results.size ==0
					flash.now[:warning] = "We don't have data for this position currently."
				return
			end
			else
				flash.now[:warning] = "Search returned 0 results."
				return
			end
			
		elsif params[:search_company].present? && !params[:search_position].present?
			@company = Company.where('lower(name)= ?', params[:search_company].downcase).first
			puts "ONLY COMPANY NO POSITION"
			if @company.nil?
				flash.now[:warning] = "Search returned 0 results."
				return
			end
			
		else
			puts "NO COMPANY OR POSITION PROVIDED FOR SEARCH"
			flash.now[:error] = "Search returned 0 results."
			#redirect_to root_url

		end
	end

	def autocomplete
    render json: Position.search(params[:search_position], {
      fields: ["title^5"],
      match: :word_start,
      limit: 10,
      load: false,
      misspellings: {below: 5}
    }).map do |position|
    	{title: position.title, value: position.id}
    end
  end



	def new
		@position = Position.new
	end

	def create

		puts params[:position][:internal_level_ids]

		@position = @company.positions.build(position_params)
		if @position.save
			flash[:success] = "Position saved successfully."
			redirect_to company_path(@company)
		else
			flash[:danger] = "Position did not save."
			render 'new'
		end
		#@position.internal_level_ids << params[:position][:internal_level_ids]
		#@position.save
		#@position.internal_levels << @internal_level
		
		

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
			flash[:success] = "This position was updated successfully."
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
