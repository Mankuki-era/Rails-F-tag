class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :force_redirect, only: [:edit, :update, :destroy]

  def index
    return redirect_to new_user_registration_path
  end

  def show
    @posts = Post.where(user_id: @user.id).order(created_at: :desc).page(params[:page2]).per(5)
    @favorites = @user.favorites
    @favoriteposts = []
    @favorites.each do |favorite|
      @favoriteposts << favorite.post
    end
    @favoriteposts = Kaminari.paginate_array(@favoriteposts).page(params[:page3]).per(5)
    if params[:page3]
      @detname = "favoriteposts"
    end
  end

  def new
    return redirect_to "/users/#{params[:user]}?page3=#{params[:page3]}"
  end

  def create

  end

  def edit

  end

  def update
    @user.update(user_params)
  end

  def destroy
    @user.destroy
  end
  private

  def user_params
    params.require(:user).permit(
      :user_name, :profile_content, :profile_img
    )
  end

  def set_user
    @user = User.find(params[:id])
  end

  def force_redirect
    if @user != current_user
      return redirect_to root_path, alert: "不正なアクセスです"
    end
  end
end
