class UsersController < ApplicationController

  def show
    @user = User.find_by_username(params[:id].downcase)
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
