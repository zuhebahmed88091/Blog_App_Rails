class PostsController < ApplicationController
  load_and_authorize_resource
  before_action :authenticate_user!
  def index
    per_page = 10
    page = params[:page].to_i
    page = 1 if page <= 0
    @user = User.find(params[:user_id])
    @posts = @user.posts.includes(:comments)
      .order(created_at: :desc)
      .offset((page - 1) * per_page)
      .limit(per_page)

    total_posts = @user.posts.count
    @total_pages = (total_posts.to_f / per_page).ceil
  end

  def show
    @post = Post.new
    @post = Post.find params[:id]
    @posts = Post.all
    @user = current_user
    @recent_comments = @post.recent_comments
  end

  def new
    @user = User.find(params[:user_id])
    @post = @user.posts.build
  end

  def create
    @user = User.find(params[:user_id])
    @post = @current_user.posts.build(post_params)

    if @post.save
      flash[:notice] = 'Post successfully created.'
      redirect_to user_post_path(@user, @post)
    else
      flash[:alert] = 'Error creating the post.'
      render :new
    end
  end

  def destroy
    @user = current_user
    @post = Post.find(params[:id])
    @post.destroy
    flash[:notice] = 'Post successfully deleted.'
    redirect_to user_posts_path
  end

  private

  def post_params
    params.require(:post).permit(:title, :text)
  end
end
