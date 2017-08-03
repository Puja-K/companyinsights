class RelationshipsController < ApplicationController
  before_action :logged_in_user

  def create
    reported_position = Position.find(params[:reported_id])
    
    @current_position.report(reported_position)
    
  end

  def destroy
    user = Relationship.find(params[:id]).followed
    current_user.unfollow(user)
    redirect_to user
  end
end