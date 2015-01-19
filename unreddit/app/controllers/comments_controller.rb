class CommentsController < ApplicationController

  def new
    @post = Post.find(params[:post_id])
    @comment = Comment.new
    render :new
  end

  def create
    @post = Post.find(params[:comment][:post_id])
    @comment = @post.comments.new(comment_params)
    @comment.author_id = current_user.id
    if @comment.save
      flash[:notice] = "Comment saved."
      redirect_to comment_url(@comment)
    else
      flash.now[:errors] = @comment.errors.full_messages
      render :new
    end
  end

  def show
    @comment = Comment.find(params[:id])
    @post = @comment.post
    @comments_hash = @post.comments_by_parent_id
    render :show
  end

  private

  def comment_params
    params.require(:comment).permit(:content, :parent_comment_id)
  end
end
