class PostsController < ApplicationController
  before_action :authenticate_user!, except: [:index]
  before_action :set_post, only: [:edit, :update, :destroy]
  before_action :force_redirect, only: [:edit, :update, :destroy]
  
  def index
    if params[:page2].present?
      return redirect_to "/users/#{params[:user]}?page2=#{params[:page2]}"
    end
    if params[:tag_id]
      @tag = Tag.find(params[:tag_id])
      @secondposts = @tag.posts.order(created_at: :desc).page(params[:page]).per(5)
    end 
    @search = "#{params[:q]}"
    @q = Post.ransack(params[:q])
    @posts = @q.result(distinct: true).order(created_at: :desc).page(params[:page]).per(5)
  end

  def show
    if Post.exists?(params[:id])
      @post = Post.find(params[:id])
    elsif params[:page2].present?
      return redirect_to "/users/#{params[:user]}?page2=#{params[:page2]}"
    else
      return redirect_to "/?page=#{params[:page]}"
    end
    @comment = Comment.new
    @comments = @post.comments.order(created_at: :desc)  
  end

  def new
    @page = params[:page]
  end

  def create
    @page = params['page']
    @post = Post.new(post_params)
    @post.user = current_user
    @user = current_user
    @post.save
    tags = @post.content.scan(/[#＃][\w\p{Han}ぁ-ヶｦ-ﾟー]+/)
    tags.uniq.map do |t|
      ta = t.downcase
      tag = Tag.find_or_create_by(name: ta.delete('#'))
      @post.tags << tag
    end
    @posts = Post.all.order(created_at: :desc).page(params[:page]).per(5)
    @userposts = Post.where(user_id: current_user.id).order(created_at: :desc).page(params[:page]).per(5)
  end

  def edit
    @page = params[:page]
  end

  def update
    @page = params['page']
    current_tags = @post.tags.pluck(:name) unless @post.tags.nil?
    @post.update(post_params)
    tags = @post.content.scan(/[#＃][\w\p{Han}ぁ-ヶｦ-ﾟー]+/)
    query_tags = []
    tags.uniq.map do |t|
      query_tags << t.downcase.delete('#')
    end
    old_tags = current_tags - query_tags
    new_tags = query_tags - current_tags

    old_tags.each do |old_name|
      @post.tags.delete Tag.find_by(name: old_name)
      @tag_id = Tag.find_by(name: old_name).id
      if !(TagRelationship.where(tag_id: @tag_id).present?) then
        Tag.find(@tag_id).delete
      end
    end

    new_tags.each do |new_name|
      post_tag = Tag.find_or_create_by(name: new_name)
      @post.tags << post_tag
    end
  end

  def destroy
    @page = params[:pagename]
    @user = current_user
    @tag_list = []
    @post.tags.each do |t|
      @tag_list << t.id
    end
    @post.destroy
    @tag_list.each do |t|
      if !(TagRelationship.where(tag_id: t).present?) then
        Tag.find(t).delete
      end
    end
    if @page == "postshow"
      return redirect_to root_path, notice: '投稿を削除しました'
    end
    @q = Post.ransack(params[:q])
    @posts = @q.result(distinct: true).order(created_at: :desc).page(params[:page]).per(5)
    @userposts = Post.where(user_id: current_user.id).order(created_at: :desc).page(params[:page]).per(5)
  end

  private

  def post_params
    params.require(:post).permit(
      :title, :content, :post_img, :tag_ids, :usershow
    )
  end

  def set_post
    @post = Post.find(params[:id])
  end

  def force_redirect
    if @post.user != current_user
      return redirect_to root_path, alert: "不正なアクセスです"
    end
  end
end
