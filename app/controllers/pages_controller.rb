class PagesController < ApplicationController
  before_filter :authenticate_user!, except: [:index, :show]

  def index
    @issue = Issue.find(params[:issue_id])
    @pages = @issue.pages
  end

  def new
    @issue = Issue.find(params[:issue_id])
    @page = Page.new
  end

  def create
    @page = Page.new(page_params)
    @issue = Issue.find(params[:issue_id])
    if @issue.save
      @issue.pages << @page
      flash[:notice] = "Your page has been added to #{@issue.title.name} ##{@issue.number}."
      redirect_to new_issue_page_path(@issue)
    else
      flash[:alert] = "Something went wrong. Please try to save your page again."
      redirect_to :back
    end
  end

  def show
    @page = params[:page] ? Page.find(params[:page][:id].to_i) : Page.where(:issue_id => params[:issue_id].to_i, :number => params[:id]).first
    @issue = @page.issue
    @title = @page.issue.title
    @comment = Comment.new
    if @issue.approved == 0
      flash[:alert] = "That issue hasn't been approved yet"
      redirect_to root_url
    end
  end

  def destroy
    @page = Page.find(params[:id])
    @page.destroy
    flash[:notice] = "Your page has been removed."
    redirect_to :back
  end

private
  def page_params
    params.require(:page).permit(:image, :number, :issue_id)
  end
end
