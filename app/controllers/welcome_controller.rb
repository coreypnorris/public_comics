class WelcomeController < ApplicationController

  require 'will_paginate/array'

  def index
    @issues = Issue.approved.sort_by { |issue| issue.created_at }
    @issues = @issues.reverse.paginate(:per_page => 12, :page => params[:page])
  end

end
