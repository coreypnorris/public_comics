class IssuesController < ApplicationController
  before_filter :authenticate_user!

  require 'will_paginate/array'

  def index
    unless current_user.try(:admin?)
      redirect_to root_url
    end
    @issues = Issue.all.sort_by { |issue| issue.created_at }
    @issues = @issues.reverse.paginate(:per_page => 12, :page => params[:page])
  end

  def new
    @issue = Issue.new
  end

  def create
    @title = Title.find_or_initialize_by_name(params[:title_name].titleize)
    @genre = Genre.find_or_initialize_by_name(params[:title_genre_name].titleize)
    @issue = Issue.new(issue_params)
    @genre.titles << @title
    @title.issues << @issue
    current_user.issues << @issue
    if @title.save && @genre.save && @issue.save
      flash[:notice] = "Your issue has been submitted."
      redirect_to new_issue_page_path(@issue)
    else
      flash[:alert] = "Something went wrong. Please try to save your issue again."
      redirect_to :back
    end
  end

  def update
    unless current_user.try(:admin?)
      redirect_to :new_user_session_path
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
