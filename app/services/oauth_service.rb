class OauthService
  attr_reader :auth_hash

  def initialize(auth_hash)
    @auth_hash = auth_hash
  end

  def create_oauth_account!
    unless oauth_account = OauthAccount.where(uid: @auth_hash[:uid]).first
      logger.debug "DID NOT FIND AN OAUTH ACCOUNT"
      oauth_account = OauthAccount.create!(oauth_account_params)
      create_user_with_omniauth(auth_hash)
    end
    oauth_account
  end

private

  def create_user_with_omniauth(auth_hash)
    logger.debug "CREATING A USER"
      @user = User.new
      @user.provider = @auth_hash[:provider]
      @user.name = @auth_hash[:info][:name]
      if user.save
        log_in @user
        redirect_to root_url
      else
        flash[:alert] ="User could not be created !!"
    end
  end

  def oauth_account_params
    logger.debug "INSIDE oauth_account_params"
    { uid: @auth_hash[:uid],
      provider: @auth_hash[:provider],
      image_url: @auth_hash[:info][:image],
      profile_url: @auth_hash[:info][:urls][:public_profile],
      raw_data: @auth_hash[:extra][:raw_info].to_json }
  end

end