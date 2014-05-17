class TitlesController < ApplicationController

  def index
    @titles = Title.search(params[:search].titleize)
  end

  def new
    @title = Title.new
  end

  def create
    @title = Title.new title_params
    if @title.save
      flash[:notice] = "Your title has been saved."
      redirect_to titles_path
    else
      flash[:alert] = "Something went wrong. Please try to save your title again."
      render 'new'
    end
  end

  def show
    @title = Title.find(params[:id])
  end

  def edit
    @title = Title.find(params[:id])
  end

  def update
    @title = Title.find(params[:id])
    if @title.update title_params
      flash[:notice] = "Your title has been changed."
      redirect_to title_path @title
    else
      render 'edit'
    end
  end

  def destroy
    @title = Title.find(params[:id])
    @title.destroy
    flash[:notice] = "Your title has been removed."
    redirect_to titles_path
  end

private
  def title_params
    params.require(:title).permit(:name, :genre_id)
  end
end
