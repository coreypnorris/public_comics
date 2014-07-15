class CommentsController < ApplicationController
  before_filter :authenticate_user!, only: [:create]

  def new
    @comment = Comment.new(:parent_id => params[:parent_id])
    @page = Page.find(params[:page_id])
  end

  def create
    @parent = Issue.find(params[:issue_id]) if params[:issue_id]
    @parent = Comment.find(params[:comment][:parent_id]) if params[:comment][:parent_id]
    @page = Page.find(params[:page_id]) if params[:page_id]
    @issue = @parent.class == Issue ? @parent : @parent.commentable
    @comment = Comment.build_from( @issue, current_user.id, comment_params[:body] )
    if @comment.save
      current_user.comments << @comment
      flash[:notice] = "Your comment has been submitted."
      if params[:issue_id]
        respond_to do |format|
          format.html { redirect_to :back }
          format.js
        end
      elsif params[:comment][:parent_id]
        @comment.move_to_child_of(@parent)
        redirect_to issue_path(@parent.commentable)
      end
    else
      flash[:error] = "Something went wrong. Please try to save your comment again."
      redirect_to :back
    end
  end

private
  def comment_params
    params.require(:comment).permit(:body)
  end
end
