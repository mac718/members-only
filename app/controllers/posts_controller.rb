class PostsController < ApplicationController
  before_action :signed_in_user, only: [:new, :create]

  def new
    @post = Post.new
  end

  def create
    @post = set_current_user.posts.build(post_params)
    if @post.save
      redirect_to posts_index_path
    else
      flash.now[:danger] = "Invalid Post. Try again."
      render :post
    end
  end

  def index
    @posts = Post.all
  end

  private
    def post_params
      params.require(:post).permit(:title, :body)
    end
end
