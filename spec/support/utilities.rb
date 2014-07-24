require 'spec_helper'

def create_user
  @user ||= FactoryGirl.create(:user)
end

def sign_in(user)
  visit new_user_session_path
  fill_in "Username", :with => user.username
  fill_in "Password", :with => user.password
  click_button "Sign in"
end

def sign_out
  visit root_url
  click_link "Sign Out"
end
