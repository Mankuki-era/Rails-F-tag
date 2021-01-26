class FavoritesController < ApplicationController
  # ログインしていない場合ログインページへリダイレクト
  before_action :authenticate_user!

  # タッグ
  def create
    @page = params[:page]
    if @page == "usershow"
      @user = params[:user]
    end
    @favorite = current_user.favorites.create(post_id: params[:post_id])
    @posts = Post.all.order(created_at: :desc).page(params[:page]).per(5)
    @post = Post.find(params[:post_id])
  end

  # タッグ解除
  def destroy
    @post = Post.find(params[:post_id])
    @favorite = current_user.favorites.find_by(post_id: @post.id)
    @favorite.destroy
    @page = params[:page]
    if @page == "usershow"
      @user = params[:user]
      @favorites = User.find(@user).favorites
      @favoriteposts = []
      @favorites.each do |favorite|
        @favoriteposts << favorite.post
      end
      @favoriteposts = Kaminari.paginate_array(@favoriteposts).page(params[:page]).per(5)
    end
  end
end
