class ProfilesController < ApplicationController

	def new
		@user = User.find(params[:user_id])
		@profile = Profile.new
		@profile.company = Company.new
		#@user.build_profile
		#@user.profile.build_company
	end

	def edit
		@user = User.find(params[:user_id])
		if @user.profile.nil?
			@profile = Profile.new
			@profile.company = Company.new
		else
			@profile = @user.profile
		end

	end

	def show
		@profile = Profile.find(params[:id])
	end

	def update
		@profile = Profile.find(params[:id])
		company = Company.find_by(name: params[:company][:name])
		puts company.nil?
		if company.nil?
			puts "creating a new company"
			company = Company.create!(name: params[:company][:name])
			if company.persisted?
				puts "Compny saved, now creating the position"
				@profile.company = company
				position = company.positions.create!(title: params[:position][:title])
				
				if params[:internal_level].present? && !params[:internal_level][:name].blank?
					internal_level = company.internal_levels.create!(name: params[:internal_level][:name])
					position.internal_levels << internal_level 
					@profile.internal_level = internal_level
				elsif params[:internal_level].present? && params[:internal_level][:name].blank?
					@profile.internal_level = nil
				end
				if params[:name].present? && !params[:name].blank?
					internal_level = company.internal_levels.create!(name: params[:name])
					position.internal_levels << internal_level 
					@profile.internal_level = internal_level
				elsif params[:name].present? && params[:name].blank?
					@profile.internal_level = nil
				end
				@profile.position = position
				if @profile.update_attributes(profile_params)
					puts "*** Horray profile sucessfully UPDATED !! ***"
			      # Handle a successful update.
			      	flash[:success] = "Profile updated !!"
			      	#redirect_to @user
			    else
			      redirect_to "/users/#{current_user.id}/profile" 
			    end
				#@profile = @user.build_profile(company_id: company.id, position_id: position.id, internal_level_id: internal_level.id)
				#if params[:profile][:promotion_criteria].present?
					#@profile.promotion_criteria = params[:profile][:promotion_criteria] 
				#end	
				
			end
			
		else
			puts "*** EXISTING COMPANY !!!"
			@profile.company = company
			position = company.positions.find_by(title: params[:position][:title])
			puts position.nil?
			if position.nil?
				puts "Creating a new position"
				position = company.positions.create!(title: params[:position][:title])
				if params[:internal_level].present? && !params[:internal_level][:name].blank?
					internal_level = company.internal_levels.find_or_create_by(name: params[:internal_level][:name])
					position.internal_levels << internal_level 
					@profile.internal_level = internal_level
				elsif params[:internal_level].present? && params[:internal_level][:name].blank?
					@profile.internal_level = nil
				end
				if params[:name].present? && !params[:name].blank?
					internal_level = company.internal_levels.find_or_create_by(name: params[:name])
					position.internal_levels << internal_level 
					@profile.internal_level = internal_level
				elsif params[:name].present? && params[:name].blank?
					@profile.internal_level = nil
				end
				@profile.position = position
				if @profile.update_attributes(profile_params)
					puts "*** Horray profile sucessfully UPDATED !! ***"
			      # Handle a successful update.
			      	flash[:success] = "Profile updated!!"
			      	#redirect_to @user
			    else
			      redirect_to "/users/#{current_user.id}/profile" 
			    end
			
			else
				puts "*** Position already exists !!"
				@profile.position = position
				if params[:internal_level].present? && !params[:internal_level][:name].blank?
					internal_level = company.internal_levels.find_or_create_by(name: params[:internal_level][:name])
					if !position.internal_levels.exists?(internal_level.id)
					puts "**Adding the internal level to this position since it does not exists!!!! **"
					position.internal_levels << internal_level
					@profile.internal_level = internal_level
					end 
				elsif params[:internal_level].present? && params[:internal_level][:name].blank?
					@profile.internal_level = nil
				end
					
				if params[:name].present? && !params[:name].blank?
					internal_level = company.internal_levels.find_or_create_by(name: params[:name])
					if !position.internal_levels.exists?(internal_level.id)
					puts "**Adding the internal level to this position since it does not exists!!!! **"
					position.internal_levels << internal_level
					@profile.internal_level = internal_level
					end 
				elsif params[:name].present? && params[:name].blank?
					@profile.internal_level = nil
				end

				if @profile.update_attributes(profile_params)
					puts "*** Horray profile sucessfully UPDATED !! ***"
			      # Handle a successful update.
			      	flash[:success] = "Profile updated!!"
			      	redirect_to "/users/#{current_user.id}/profile" 
			      	return
			    else
			    	flash.now[:error] = "Could not update your profile"
			      redirect_to "/users/#{current_user.id}/profile" 
			    end

			end
		end
		redirect_to "/users/#{current_user.id}/profile" 
	    
	end

	def create
		@user = User.find(current_user.id)
		company = Company.find_by(name: params[:company][:name])
		puts company.nil?
		if company.nil?
			puts "creating a new company"
			company = Company.create!(name: params[:company][:name])
			if company.persisted?
				puts "Compny saved, now creating the position"
				
				position = company.positions.create!(title: params[:title])
				
				
				@profile =@user.build_profile(company_id: company.id, position_id: position.id)
				if params[:internal_level].present? || params[:name].present? #:name is the level name
					internal_level = company.internal_levels.create!(name: params[:name])
					position.internal_levels << internal_level 
					@profile.internal_level = internal_level
				end
				if params[:profile][:promotion_criteria].present?
					@profile.promotion_criteria = params[:profile][:promotion_criteria]
				end
				
				if @profile.save
					flash.now[:success] = "Thank you for creating your profile !!"
					puts "*** Horray profile sucessfully created ***"
					redirect_to "/users/#{@user.id}/profile"
				end
			end
			
		else
			puts "*** EXISTING COMPANY !!!"
			position = company.positions.find_by(title: params[:title])
			puts position.nil?
			if position.nil?
				puts "Creating a new position"
				position = company.positions.create!(title: params[:title])
				@profile =@user.build_profile(company_id: company.id, position_id: position.id)
				if params[:name].present? #:name is the internal level name
					internal_level = company.internal_levels.find_or_create_by(name: params[:name])
					position.internal_levels << internal_level 
					@profile.internal_level = internal_level
				end
				if params[:profile][:promotion_criteria].present?
					@profile.promotion_criteria = params[:profile][:promotion_criteria]
				end
				if @profile.save
					puts "*** Horray profile sucessfully created ***"
					flash[:success] = "Thank you for creating your profile !!"
					redirect_to "/users/#{@user.id}/profile"
				end
				#company.internal_levels.where(name: params[:name])
			
			else
				puts "*** Position already exists !!"
				@profile =@user.build_profile(company_id: company.id, position_id: position.id)

				if params[:name].present?
					internal_level = company.internal_levels.find_or_create_by(name: params[:name])
				
					if !position.internal_levels.exists?(internal_level.id)
					puts "**Adding the internal level to this position since it does not exists!!!! **"
					position.internal_levels << internal_level
					end 
					@profile.internal_level = internal_level
				end
				if params[:profile][:promotion_criteria].present?
					@profile.promotion_criteria = params[:profile][:promotion_criteria]
				end

				
					
				if @profile.save
					puts "*** Horray profile sucessfully created ***"
					flash.now[:success] = "Thank you for creating your profile !!"
					redirect_to "/users/#{@user.id}/profile"
				end

			end
		end

		
	end


	private

	def profile_params
		params.require(:profile).permit(:promotion_criteria, :user_id, :company_id, :position_id, :internal_level_id)
		
	end
end