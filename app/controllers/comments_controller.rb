class CommentsController < ApplicationController
  before_action :authenticate_user!
  def create
    @comment = current_user.comments.new(comment_params)
    @post = @comment.post
    @comments = Comment.where(post_id: @post.id).order(created_at: :desc)
    @comment.save
    @comment = Comment.new
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
    @post = @comment.post
    @comments = Comment.where(post_id: @post.id).order(created_at: :desc)
    @comment = Comment.new
  end

  private

  def comment_params
    params.require(:comment).permit(
      :content, :post_id
    )
  end

end
