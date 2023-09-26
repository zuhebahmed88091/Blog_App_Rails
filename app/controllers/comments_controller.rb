class CommentsController < ApplicationController
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

    private

    def comment_params
        params.require(:comment).permit(:text)
    end
end