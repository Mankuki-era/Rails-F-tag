class FollowRelationshipsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user

  def create
    @following = current_user.follow(@user)
    @following.save
  end

  def destroy
    @following = current_user.unfollow(@user)
    @following.destroy
  end

  private

  def set_user
    @user = User.find(params[:follow_relationship][:following_id])
    @mainuser = User.find(params["mainuser_id"])
  end
end
