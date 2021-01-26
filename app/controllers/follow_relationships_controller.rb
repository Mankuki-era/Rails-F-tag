class FollowRelationshipsController < ApplicationController
  # ログインしていない場合ログインページへリダイレクト
  before_action :authenticate_user!
  before_action :set_user

  # フォロー
  def create
    @following = current_user.follow(@user)
    @following.save
  end

  # フォロー解除
  def destroy
    @following = current_user.unfollow(@user)
    @following.destroy
  end

  private

  # フォロー対象ユーザーを設定
  def set_user
    @user = User.find(params[:follow_relationship][:following_id])
    @mainuser = User.find(params["mainuser_id"])
  end
end
