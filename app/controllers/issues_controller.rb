class IssuesController < ApplicationController

  def index
    @issues = Issue.all
  end

  def new
    @issue = Issue.new
  end

  def create
    @issue = Issue.new issue_params
    if @issue.save
      flash[:notice] = "Your issue has been saved."
      redirect_to issues_path
    else
      flash[:alert] = "Something went wrong. Please try to save your issue again."
      render 'new'
    end
  end

  def show
    @issue = Issue.find(params[:id])
  end

  def edit
    @issue = Issue.find(params[:id])
  end

  def update
    @issue = Issue.find(params[:id])
    if @issue.update issue_params
      flash[:notice] = "Your issue has been changed."
      redirect_to issue_path @issue
    else
      render 'edit'
    end
  end

  def destroy
    @issue = Issue.find(params[:id])
    @issue.destroy
    flash[:notice] = "Your issue has been removed."
    redirect_to issues_path
  end

private
  def issue_params
    params.require(:issue).permit(:number, :cover, :title_id)
  end
end
