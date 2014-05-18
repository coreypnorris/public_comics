class GenresController < ApplicationController

  require 'will_paginate/array'

  def show
    @genre = Genre.find(params[:id])
    @issues = []

    @genre.titles.each do |title|
      title.issues.each do |issue|
        @issues << issue
      end
    end
    @issues = @issues.sort_by { |issue| issue.created_at }
    @issues = @issues.paginate(:per_page => 3, :page => params[:page])
  end

private
  def genre_params
    params.require(:genre).permit(:name)
  end
end
