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

	def update
		@profile = Profile.find(params[:id])
		company = Company.find_by(name: params[:company][:name])
		puts company.nil?
		if company.nil?
			puts "creating a new company"
			company = Company.create!(name: params[:company][:name])
			if company.persisted?
				puts "Compny saved, now creating the position"
				internal_level = company.internal_levels.create!(name: params[:internal_level][:name])
				position = company.positions.create!(title: params[:position][:title])
				@profile.position = position
				position.internal_levels << internal_level 
				if @profile.update_attributes(profile_params)
					puts "*** Horray profile sucessfully UPDATED !! ***"
			      # Handle a successful update.
			      	flash.now[:success] = "Profile updated"
			      	#redirect_to @user
			    else
			      render 'edit'
			    end
				#@profile = @user.build_profile(company_id: company.id, position_id: position.id, internal_level_id: internal_level.id)
				#if params[:profile][:promotion_criteria].present?
					#@profile.promotion_criteria = params[:profile][:promotion_criteria] 
				#end	
				
			end
			
		else
			puts "*** EXISTING COMPANY !!!"
			internal_level = company.internal_levels.find_or_create_by(name: params[:internal_level][:name])
			position = company.positions.find_by(title: params[:position][:title])
			puts position.nil?
			if position.nil?
				puts "Creating a new position"
				position = company.positions.create!(title: params[:position][:title])
				position.internal_levels << internal_level 
				@profile.position = position
				if @profile.update_attributes(profile_params)
					puts "*** Horray profile sucessfully UPDATED !! ***"
			      # Handle a successful update.
			      	flash.now[:success] = "Profile updated"
			      	#redirect_to @user
			    else
			      render 'edit'
			    end
			
			else
				puts "*** Position already exists !!"
				internal_level = company.internal_levels.find_or_create_by(name: params[:internal_level][:name])
				@profile.position = position
				if !position.internal_levels.exists?(internal_level.id)
					puts "**Adding the internal level to this position since it does not exists!!!! **"
					position.internal_levels << internal_level
				end 
				if @profile.update_attributes(profile_params)
					puts "*** Horray profile sucessfully UPDATED !! ***"
			      # Handle a successful update.
			      	flash.now[:success] = "Profile updated"
			      	#redirect_to @user
			    else
			      render 'edit'
			    end

			end
		end
		render 'edit'
	    
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
				internal_level = company.internal_levels.create!(name: params[:name])
				position = company.positions.create!(title: params[:title])
				position.internal_levels << internal_level 
				@profile =@user.build_profile(company_id: company.id, position_id: position.id, internal_level_id: internal_level.id)
				if params[:profile][:promotion_criteria].present?
					@profile.promotion_criteria = params[:profile][:promotion_criteria] 
				end	
				if @profile.save
					flash.now[:success] = "Thank you for creating your profile !!"
					puts "*** Horray profile sucessfully created ***"
					#redirect_to user_profile_url(@user,@profile)
				end
			end
			
		else
			puts "*** EXISTING COMPANY !!!"
			internal_level = company.internal_levels.find_or_create_by(name: params[:name])
			position = company.positions.find_by(title: params[:title])
			puts position.nil?
			if position.nil?
				puts "Creating a new position"
				position = company.positions.create!(title: params[:title])
				position.internal_levels << internal_level 
				@profile =@user.build_profile(company_id: company.id, position_id: position.id, internal_level_id: internal_level.id)
				if params[:profile][:promotion_criteria].present?
					@profile.promotion_criteria = params[:profile][:promotion_criteria] 
				end	
				if @profile.save
					puts "*** Horray profile sucessfully created ***"
					flash.now[:success] = "Thank you for creating your profile !!"
					#redirect_to user_profile_url(@user,@profile)
				end
				#company.internal_levels.where(name: params[:name])
			
			else
				puts "*** Position already exists !!"
				internal_level = company.internal_levels.find_or_create_by(name: params[:name])
				if !position.internal_levels.exists?(internal_level.id)
					puts "**Adding the internal level to this position since it does not exists!!!! **"
					position.internal_levels << internal_level
				end 
				@profile =@user.build_profile(company_id: company.id, position_id: position.id, internal_level_id: internal_level.id)
				if params[:profile][:promotion_criteria].present?
					@profile.promotion_criteria = params[:profile][:promotion_criteria] 
				end	
				if @profile.save
					puts "*** Horray profile sucessfully created ***"
					flash.now[:success] = "Thank you for creating your profile !!"
					#redirect_to user_profile_url(@user,@profile)
				end

			end
		end
		
	end


	private

	def profile_params
		params.require(:profile).permit(:promotion_criteria, :user_id, :company_id, :position_id, :internal_level_id)
	end
end