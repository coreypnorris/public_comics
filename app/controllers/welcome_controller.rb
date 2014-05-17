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
    @issues = @issues.paginate(:per_page => 2, :page => params[:page])
  end

end
