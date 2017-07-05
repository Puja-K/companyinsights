class OauthsController < ApplicationController

  include Wisper::Publisher 

  def create
    auth = request.env["omniauth.auth"]
    user = User.find_by_provider_and_uid(auth["provider"], auth["uid"]) 
      if user
        log_in user
      else
        User.create_with_omniauth(auth)
        broadcast(:create_new_company, auth)
      end
    redirect_to root_url, flash[:Success] => "Signed in!"
  end

  def create_oauth_account(auth)
    @user.oauthAccounts.create(uid: auth[:uid],
          provider: auth[:provider],
          image_url: auth[:info][:image],
          profile_url: auth[:info][:urls][:public_profile],
          raw_data: auth[:extra][:raw_info].to_json)
    @user.save
  end

  def callback
    logger.debug "INSIDE CALLBACK FUNCTION "
    logger.debug request.env['omniauth.auth']
    begin

    auth = request.env["omniauth.auth"]
    user = OauthAccount.find_by_provider_and_uid(auth["provider"], auth["uid"]) || OauthAccount.create_with_omniauth(auth)
    log_in user
    redirect_to root_url, :notice => "Signed in!"

      #oauth = OauthService.new(request.env['omniauth.auth'])
      #if oauth_account = oauth.create_oauth_account!
          #log_in @user
      #flash["success"] = "Welcome #{@user.name} to Company Insights!!"
          #redirect_to Config.provider_login_path
     # end
    rescue => e
      flash[:alert] = "There was an error while trying to authenticate your account."
      redirect_to signup_path
    end
  end

  def failure
    flash[:alert] = "There was an error while trying to authenticate your account."
    redirect_to signup_path
  end

  private


end