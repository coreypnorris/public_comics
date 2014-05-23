class PagesController < ApplicationController

  def index
    @pages = Page.all
  end

  def show
    @page = params[:page] ? Page.find(params[:page][:id].to_i) : Page.find(params[:id])
    @issue = @page.issue
    @title = @page.issue.title
  end

private
  def page_params
    params.require(:page).permit(:image, :issue_id)
  end
end
