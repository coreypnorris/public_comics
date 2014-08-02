class IssuesController < ApplicationController
  before_filter :authenticate_user!

  def new
    @issue = Issue.new
  end

  def create
    @title = Title.find_or_initialize_by_name(params[:title_name].titleize)
    @issue = Issue.new(issue_params)
    if @title.save && @issue.save
      @title.issues << @issue
      flash[:notice] = "Your title has been submitted."
      redirect_to new_issue_page_path(@issue)
    else
      flash[:alert] = "Something went wrong. Please try to save your issue again."
      redirect_to :back
    end
  end

private
  def issue_params
    params.require(:issue).permit(:number, :cover, :title_id)
  end
end
