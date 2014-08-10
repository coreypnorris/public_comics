class UsersController < ApplicationController

  require 'will_paginate/array'

  def show
    @user = User.find_by_username(params[:id].downcase)
    @sorted_issues = @user.issues.approved.sort_by { |issue| issue.created_at }
    @paginated_issues = @sorted_issues.reverse.paginate(:per_page => 12, :page => params[:page])
  end

  def update
    @user = User.find_by_username(params[:id])
    if @user.update user_params
      flash[:notice] = "Your avatar has been added."
      redirect_to :back
    else
      flash[:error] = "Something went wrong. Please try to save your user again."
      redirect_to :back
    end
  end


  private
    def user_params
      params.require(:user).permit(:avatar)
    end

end
