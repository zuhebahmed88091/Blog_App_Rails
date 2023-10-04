class CommentsController < ApplicationController
  load_and_authorize_resource
  def new
    @comment = Comment.new
    @post = Post.find(params[:post_id])
    @user = @current_user
  end

  def create
    @post = Post.find(params[:post_id])
    @user = User.find(params[:user_id])
    @comment = @post.comments.new(comment_params.merge(user: @user))

    if @comment.save
      redirect_to user_post_path(@user, @post), notice: 'Your comment was successfully created.'
    else
      render :new
    end
  end

  def destroy
    @user = current_user
    @comment = Comment.find(params[:id])

    if @comment.user == @user
      @comment.destroy
      flash[:notice] = 'Comment is successfully deleted.'
    else
      flash[:alert] = 'You are not authorized to delete this comment.'
    end
    redirect_to user_post_path
  end

  private

  def comment_params
    params.require(:comment).permit(:text)
  end
end
