class PagesController < ApplicationController

  def index
    @pages = Page.all
  end

  def new
    @page = Page.new
  end

  def create
    @page = Page.new page_params
    if @page.save
      flash[:notice] = "Your page has been saved."
      redirect_to pages_path
    else
      flash[:alert] = "Something went wrong. Please try to save your page again."
      render 'new'
    end
  end

  def show
    @page = Page.find(params[:id])
    @issue = @page.issue
    @title = @page.issue.title
  end

  def edit
    @page = Page.find(params[:id])
  end

  def update
    @page = Page.find(params[:id])
    if @page.update page_params
      flash[:notice] = "Your page has been changed."
      redirect_to page_path @page
    else
      render 'edit'
    end
  end

  def destroy
    @page = Page.find(params[:id])
    @page.destroy
    flash[:notice] = "Your page has been removed."
    redirect_to pages_path
  end

private
  def page_params
    params.require(:page).permit(:image, :issue_id)
  end
end
