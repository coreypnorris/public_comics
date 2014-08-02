class GenresController < ApplicationController

  require 'will_paginate/array'

  def index
    @genres = Genre.order(:name).where("name like ?", "%#{params[:term].titleize}%")
    render json: @genres.map(&:name)
  end

  def show
    if params[:genre]
      @genre = Genre.find(params[:genre][:id])
    else
      @genre = Genre.where(:name => params[:id]).first
    end
    @issues = []
    @genre.titles.each do |title|
      title.issues.each do |issue|
        @issues << issue
      end
    end
    @issues = @issues.sort_by { |issue| issue.created_at }
    @issues = @issues.reverse.paginate(:per_page => 12, :page => params[:page])
  end

private
  def genre_params
    params.require(:genre).permit(:name)
  end
end
