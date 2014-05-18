class TitlesController < ApplicationController

  require 'will_paginate/array'

  def index
    @titles = Title.search(params[:search].titleize)
    @issues = []

    @titles.each do |title|
      title.issues.each do |issue|
        @issues << issue
      end
    end
    @issues = @issues.paginate(:per_page => 3, :page => params[:page])
  end

private
  def title_params
    params.require(:title).permit(:name, :genre_id)
  end
end
