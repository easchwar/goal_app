class CommentsController < ApplicationController
  before_action :require_logged_in

  def create
    @comment = Comment.new(comment_params)
    @comment.author_id = current_user.id

    if @comment.save
      redirect_to commentable_url
    else
      flash[:errors] = @comment.errors.full_messages
      redirect_to commentable_url
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy

    redirect_to commentable_url
  end

  private

  def require_logged_in
    redirect_to new_session_url unless logged_in?
  end

  def commentable_url
    "/#{@comment.commentable_type.pluralize.underscore}/#{@comment.commentable_id}"
  end

  def comment_params
    params.require(:comment).permit(:body, :commentable_id, :commentable_type)
  end
end
