class IssuesController < ApplicationController
  before_filter :authenticate_user!

  def new
    @issue = Issue.new
    @title = Title.new
  end

private
  def issue_params
    params.require(:issue).permit(:number, :cover, :title_id)
  end
end
