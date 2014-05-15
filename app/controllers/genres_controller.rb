class GenresController < ApplicationController

  def index
    @genres = Genre.all
  end

  def new
    @genre = Genre.new
  end

  def create
    @genre = Genre.new genre_params
    if @genre.save
      flash[:notice] = "Your genre has been saved."
      redirect_to genres_path
    else
      flash[:alert] = "Something went wrong. Please try to save your genre again."
      render 'new'
    end
  end

  def show
    @genre = Genre.find(params[:id])
  end

  def edit
    @genre = Genre.find(params[:id])
  end

  def update
    @genre = Genre.find(params[:id])
    if @genre.update genre_params
      flash[:notice] = "Your genre has been changed."
      redirect_to genre_path @genre
    else
      render 'edit'
    end
  end

  def destroy
    @genre = Genre.find(params[:id])
    @genre.destroy
    flash[:notice] = "Your genre has been removed."
    redirect_to genres_path
  end

private
  def genre_params
    params.require(:genre).permit(:name)
  end
end
