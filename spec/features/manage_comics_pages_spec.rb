require 'spec_helper'

feature 'A user managing his/her uploaded comics' do
  before { create_and_sign_in_user }

  scenario "a user hasn't uploaded any comics", :retry => 5 do
    visit user_issues_path(@user.username)
    page.should have_content("You havent uploaded any comics yet.")
  end

  scenario "a user can see the comics they've uploaded" do
    @issue = FactoryGirl.create(:issue, :user_id => @user.id)
    visit user_issues_path(@user.username)
    page.should have_content @issue.title.name
  end

  scenario "a can delete a comic they've uploaded", :retry => 5 do
    @issue = FactoryGirl.create(:issue, :user_id => @user.id)
    FactoryGirl.create(:page, :issue_id => @issue.id)
    visit user_issues_path(@user.username)
    click_link "issue-#{@issue.id}-delete-btn"
  end
end
