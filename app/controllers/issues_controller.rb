class IssuesController < ApplicationController
  before_filter :authenticate_user!

  def index
    @issues = Issue.all.sort_by { |issue| issue.created_at }
    @issues = @issues.reverse.paginate(:per_page => 12, :page => params[:page])
  end

  def new
    @issue = Issue.new
  end

  def create
    @title = Title.find_or_initialize_by_name(params[:title_name].titleize)
    @genre = Genre.find_or_initialize_by_name(params[:title_genre_name].titleize)
    @issue = Issue.new(issue_params)
    if @title.save && @genre.save && @issue.save
      @genre.titles << @title
      @title.issues << @issue
      current_user.issues << @issue
      flash[:notice] = "Your issue has been submitted."
      redirect_to new_issue_page_path(@issue)
    else
      flash[:alert] = "Something went wrong. Please try to save your issue again."
      redirect_to :back
    end
  end

private
  def issue_params
    params.require(:issue).permit(:number, :cover, :user_id, :title_id)
  end
end
