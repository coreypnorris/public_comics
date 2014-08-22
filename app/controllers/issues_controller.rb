class IssuesController < ApplicationController
  before_filter :authenticate_user!

  require 'will_paginate/array'

  def index
    @user = User.find_by_username(params[:user_id])
    if @user.admin == true
      @issues = Issue.all.sort_by { |issue| issue.created_at }
    else
      @issues = @user.issues.sort_by { |issue| issue.created_at }
    end
    @issues = @issues.reverse.paginate(:per_page => 12, :page => params[:page])
  end

  def new
    @issue = Issue.new
  end

  def create
    @title = Title.find_or_create_by(name: params[:title_name].titleize)
    @genre = Genre.find_or_create_by(name: params[:title_genre_name].titleize)
    @issue = Issue.new(issue_params)
    @genre.titles << @title
    @title.issues << @issue
    current_user.issues << @issue
    if params[:images]
      params[:images].each { |image|
        @issue.pages.create(image: image, number: (@issue.pages.count + 1))
      }
    end
    if @issue.save
      flash[:notice] = "#{@title.name} ##{@issue.number} has been submitted."
      redirect_to user_issues_path(current_user)
    else
      flash[:alert] = "Something went wrong. Please try to save your issue again."
      redirect_to :back
    end
  end

  def update
    unless current_user.try(:admin?)
      redirect_to root_url
    end
    @issue = Issue.find(params[:id])
    if params[:kind] == "approve"
      @issue.approved = 1
      @issue.save
      flash[:notice] = "#{@issue.title.name} ##{@issue.number} has been approved."
      redirect_to :back
    elsif params[:kind] == "unapprove"
      @issue.approved = 0
      @issue.save
      flash[:notice] = "#{@issue.title.name} ##{@issue.number} has been unapproved."
      redirect_to :back
    else
      flash[:error] = "Something went wrong. Please try to save your issue again."
      redirect_to :back
    end
  end

  def destroy
    @issue = Issue.find(params[:id])
    @issue.destroy
    flash[:notice] = "The issue has been removed."
    redirect_to :back
  end

private
  def issue_params
    params.require(:issue).permit(:number, :cover, :approved, :user_id, :title_id)
  end
end
