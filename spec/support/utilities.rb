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
  visit root_path
  click_on "Sign Out"
end

def create_page_and_post_comment
  create_user
  sign_in(@user)
  @issue = FactoryGirl.create(:page).issue
  visit issue_page_path(@issue, @issue.pages.first)
  @comment = FactoryGirl.build(:comment, :user_id => @user.id)
  fill_in "issue-#{@issue.id}-comment-body", :with => @comment.body
  click_button "Comment on this Issue"
end
