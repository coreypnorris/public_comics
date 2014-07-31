class TitlesController < ApplicationController

  require 'will_paginate/array'

  def index

    if params[:term]
      @titles = Title.order(:name).where("name like ?", "%#{params[:term].titleize}%")
      render json: @titles.map(&:name)
    else
      @titles = Title.search(params[:search].titleize)
      @issues = []

      @titles.each do |title|
        title.issues.each do |issue|
          @issues << issue
        end
      end
      @issues = @issues.sort_by { |issue| issue.created_at }
      @issues = @issues.reverse.paginate(:per_page => 12, :page => params[:page])
    end
  end

private
  def title_params
    params.require(:title).permit(:name, :genre_id)
  end
end
