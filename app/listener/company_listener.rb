class CompanyListener

	def create_new_company(auth, user)
		raw_data = auth[:extra][:raw_info].as_json

		c_name = raw_data["positions"]["values"][0]["company"]["name"]
			if Rails.env.production?
				company = Company.where("name ILIKE ?", "#{c_name}")
			else
				company = Company.find_by(name: "#{c_name}")
				puts company.nil?
			end
		if company.nil?
			company = Company.create!(name: c_name, industry: raw_data["positions"]["values"][0]["company"]["industry"],
				location: raw_data["positions"]["values"][0]["location"]["name"], company_type:raw_data["positions"]["values"][0]["company"]["type"] ) 
			
			position = company.positions.create!(title: raw_data["positions"]["values"][0]["title"],
						 description: raw_data["positions"]["values"][0]["summary"])
			
		else
			puts company.name
			position = company.positions.find_by(title: raw_data["positions"]["values"][0]["title"])
			if position.nil?
				puts "Creating a new position"
				position = company.positions.create!(title: raw_data["positions"]["values"][0]["title"],
						 description: raw_data["positions"]["values"][0]["summary"])
			else
				puts "#{position.title} Exists for #{c_name}"
			end

		end

		#Build a profile for this user
		#@user = User.find(current_user.id)
		@profile =user.create_profile!(company_id: company.id, position_id: position.id)
		if @profile
					puts "*** Horray profile sucessfully created for LinkedIn User ***"
					
		end
				
		
	end
end


{"emailAddress":"puja.kamath@gmail.com",
	"firstName":"Puja",
	"headline":"Sr. Technical Program Manager",
	"id":"CEFPLMYAzi",
	"industry":"Computer Software",
	"lastName":"Kamath",
	"location":{"country":
					{"code":"us"},
					"name":"San Francisco Bay Area"},
	"pictureUrl":"https://media.licdn.com/mpr/mprx/0_-pfWV1-ke1fg27W8ZSMHckB5D1Y3EDsjUpzWyF75dNY8fgcKRpzFOARkI1j8fgQKUScblkqXh1mhdWHDg7ov-FMH51mTdWPpU7oEJ6uLm-UDixe8cOyXMtCqLQNl8WXD-2m5YNSg-pq",
	"positions":{"_total":1,"values":[
										{"company":{"id":93902,"industry":"Internet","name":"Ooyala","size":"501-1000","type":"Privately Held"},
										"id":792038877,"isCurrent":true,
										"location":{"name":"Santa Clara, CA"},"startDate":{"month":1,"year":2016},
										"title":"Sr. Technical Program Manager"}]},"publicProfileUrl":"https://www.linkedin.com/in/pujakamath"}