class LikesController < ApplicationController
  def create
    @user = User.find(params[:user_id])
    @post = Post.find(params[:post_id])
    @like = Like.new(user: @user, post: @post)

    if @like.save
      flash[:notice] = 'You liked this post'
    else
      flash[:alert] = 'Failed to like this post'
    end

    redirect_to user_post_path(@user, @post)
  end
end
