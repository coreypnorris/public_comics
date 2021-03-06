require 'spec_helper'

def create_user
  @user = FactoryGirl.create(:user)
end

def create_admin
  @admin = FactoryGirl.create(:user, :admin => true)
end

def sign_in(user)
  visit new_user_session_path
  fill_in "Username", :with => user.username
  fill_in "Password", :with => user.password
  click_button "Sign in"
end

def create_and_sign_in_user
  create_user
  sign_in(@user)
end

def create_and_sign_in_admin
  create_admin
  sign_in(@admin)
end

def create_and_sign_in_user_for_poltergeist
  @user = FactoryGirl.build(:user)
  visit new_user_registration_path
  fill_in 'Username', :with => @user.username
  fill_in 'Email', :with => @user.email
  fill_in 'Password', :with => @user.password
  fill_in 'Password Confirmation', :with => @user.password_confirmation
  click_button "Sign up"
end

def sign_out
  visit root_path
  click_link "dropdown-toggle"
  click_on "Sign Out"
end

def create_user_and_page_and_post_comment
  @issue = FactoryGirl.create(:page).issue
  create_and_sign_in_user
  visit issue_page_path(@issue, @issue.pages.first)
  @comment = FactoryGirl.build(:comment, :user_id => @user.id)
  fill_in "issue-#{@issue.id}-comment-body", :with => @comment.body
  click_button "Comment on this issue"
end

def create_reply_to_comment
  @reply = FactoryGirl.build(:comment, :user_id => @user.id)
  click_on "Reply"
  fill_in "comment-#{(Comment.last.id)}-comment-body", :with => @reply.body
  click_button "Confirm"
end
