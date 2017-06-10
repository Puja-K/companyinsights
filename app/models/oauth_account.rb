class OauthAccount < ApplicationRecord
	belongs_to :user

	attr_reader :auth_hash



end