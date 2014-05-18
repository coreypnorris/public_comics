class WelcomeController < ApplicationController

  require 'will_paginate/array'

  def index
    @titles = Title.all
    @issues = []

    Title.all.each do |title|
      title.issues.each do |issue|
        @issues << issue
      end
    end
    @issues = @issues.sort_by { |issue| issue.created_at }
    @issues = @issues.paginate(:per_page => 3, :page => params[:page])
  end

end
