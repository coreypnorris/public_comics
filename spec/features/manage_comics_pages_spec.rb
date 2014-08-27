require 'spec_helper'

feature 'A non-admin user managing his/her uploaded comics' do
  background do
    create_and_sign_in_user
  end

  scenario "a user hasn't uploaded any comics", :retry => 5 do
    visit user_issues_path(@user.username)
    page.should have_content("You havent uploaded any comics yet.")
  end

  scenario "as a non-admin user I can see the comics I've uploaded", :retry => 5 do
    @issue = FactoryGirl.create(:issue, :user_id => @user.id)
    visit user_issues_path(@user.username)
    page.should have_content @issue.title.name
  end

  scenario "as a non-admin user I can add pages to a comic I've already uploaded", :retry => 5 do
    @issue = FactoryGirl.create(:issue, :user_id => @user.id)
    @page = FactoryGirl.create(:page, :issue_id => @issue.id)
    visit user_issues_path(@user.username)
    click_link "issue-#{@issue.id}-edit-btn"
    page.attach_file('new-pages', File.join(Rails.root, '/spec/support/test_image.png'))
    click_button 'Submit'
    page.should have_content "Your pages were added"
  end

  scenario "as a non-admin user I can delete a comic I've uploaded", :retry => 5 do
    @issue = FactoryGirl.create(:issue, :user_id => @user.id)
    visit user_issues_path(@user.username)
    click_link "issue-#{@issue.id}-delete-btn"
    page.should_not have_content @issue.title.name
  end
end

feature 'An admin managing other users comics' do
  let!(:test_user) { FactoryGirl.create(:user) }
  let!(:test_issue) { FactoryGirl.create(:issue, :user_id => test_user.id) }
  let!(:test_page) { FactoryGirl.create(:page, :issue_id => test_issue.id) }
  before { create_and_sign_in_admin }
  before { click_link "Manage Comics" }

  scenario "as an admin I can approve a comic another user has uploaded", :retry => 5 do
    click_link "issue-#{test_issue.id}-approve-btn"
    page.should have_content "approved"
  end

  scenario "as an admin I can approve a comic another user has uploaded", :retry => 5 do
    click_link "issue-#{test_issue.id}-unapprove-btn"
    page.should have_content "unapproved"
  end

  scenario "as an admin I can delete a comic another user has uploaded", :retry => 5 do
    click_link "issue-#{test_issue.id}-delete-btn"
    page.should_not have_content test_issue.title.name
  end

  scenario "as an admin I can add a page to a comic another user has uploaded", :retry => 5 do
    click_link "issue-#{test_issue.id}-edit-btn"
    page.attach_file('new-pages', File.join(Rails.root, '/spec/support/test_image.png'))
    click_button 'Submit'
    page.should have_content "Your pages were added"
  end
end
