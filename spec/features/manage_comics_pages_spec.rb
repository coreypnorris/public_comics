require 'spec_helper'

feature 'A user managing his/her uploaded comics' do
  before { create_and_sign_in_user }

  scenario "a user hasn't uploaded any comics", :retry => 5 do
    visit user_issues_path(@user.username)
    page.should have_content("You havent uploaded any comics yet.")
  end

  scenario "a user can see the comics they've uploaded", :retry => 5 do
    @issue = FactoryGirl.create(:issue, :user_id => @user.id)
    visit user_issues_path(@user.username)
    page.should have_content @issue.title.name
  end

  scenario "as a non-admin I can delete a comic I've uploaded", :retry => 5 do
    @issue = FactoryGirl.create(:issue, :user_id => @user.id)
    visit user_issues_path(@user.username)
    click_link "issue-#{@issue.id}-delete-btn"
    page.should_not have_content @issue.title.name
  end

  scenario "as an admin I can approve a comic another user has uploaded" do
    @issue = FactoryGirl.create(:issue, :user_id => @user.id)
    FactoryGirl.create(:page, :issue_id => @issue.id)
    click_link "Sign Out"
    create_and_sign_in_admin
    click_link "Manage Comics"
    click_link "issue-#{@issue.id}-approve-btn"
    page.should have_content "approved"
  end

  scenario "as an admin I can delete a comic another user has uploaded" do
    @issue = FactoryGirl.create(:issue, :user_id => @user.id)
    FactoryGirl.create(:page, :issue_id => @issue.id)
    click_link "Sign Out"
    create_and_sign_in_admin
    click_link "Manage Comics"
    click_link "issue-#{@issue.id}-delete-btn"
    page.should_not have_content @issue.title.name
  end
end
