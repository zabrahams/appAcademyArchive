class PostsController < ApplicationController
  respond_to :json

  def index
    respond_with(@posts = Post.all)
  end

  def show
    respond_with(@post = Post.find(params[:id]))
  end

  def create
    @post = Post.new(post_params)
    if @post.save
      respond_with(@post)
    else
      respond_with(@post, status: :unprocessable_entity)
    end
  end

  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      respond_with(@post)
    else
      respond_with(@post, status: :unprocessable_entity)
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    respond_with(@post)
  end

  private

  def post_params
    params.require(:post).permit(:title, :body)
  end

end
