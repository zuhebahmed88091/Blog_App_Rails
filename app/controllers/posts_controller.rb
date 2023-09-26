class PostsController < ApplicationController
  def index
    @user = User.find(params[:user_id])
    @posts = @user.posts
  end

  def show
    @posts = Post.all
    @post = Post.find(params[:id])
    @recent_comments = @post.recent_comments
  end

  def new
    @user = User.find(params[:user_id])
    @post = Post.new
  end

  def create
    set_current_user
    @post = @current_user.posts.build(post_params)
    @post.comment_counter = 0
    @post.like_counter = 0

    if @post.save
      redirect_to user_post_path(@current_user.id, @post.id), notice: 'Your post was successfully created.'
    else
      render :new
    end
  end

  def post_params
    params.require(:post).permit(:title, :text)
  end
end
