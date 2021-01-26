class UsersController < ApplicationController
  # ログインしていない場合ログインページへリダイレクト
  before_action :authenticate_user!
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :force_redirect, only: [:edit, :update, :destroy]

  # ユーザー一覧表示
  def index
    return redirect_to new_user_registration_path
  end

  # ユーザー詳細表示
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

  # ページネーション
  def new
    return redirect_to "/users/#{params[:user]}?page3=#{params[:page3]}"
  end

  # プロフィール更新
  def update
    @user.update(user_params)
  end

  # ユーザー削除
  def destroy
    @user.destroy
  end

  private

  # ストロングパラメータ
  def user_params
    params.require(:user).permit(
      :user_name, :profile_content, :profile_img
    )
  end

  # 対象ユーザーの設定
  def set_user
    @user = User.find(params[:id])
  end

  # 不正アクセスの防止
  def force_redirect
    if @user != current_user
      return redirect_to root_path, alert: "不正なアクセスです"
    end
  end
end
