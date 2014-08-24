require 'spec_helper'

feature 'A user uploading comics' do
  before { create_and_sign_in_user }


  scenario "a user uploading a comic", :retry => 5 do
    test_issue = FactoryGirl.build(:issue, :user_id => @user.id)
    visit new_issue_path
    page.should have_content("New Issue")
    page.attach_file('new-issue-pages', File.join(Rails.root, '/spec/support/test_image.png'))
    page.attach_file('new-issue-pages', File.join(Rails.root, '/spec/support/test_image_2.jpg'))
    page.attach_file('new-issue-pages', File.join(Rails.root, '/spec/support/test_image_3.jpg'))
    fill_in 'title_name', :with => test_issue.title.name
    select("1", :from => "issue_number")
    fill_in 'title_genre_name', :with => test_issue.title.genre
    click_button 'Submit Issue'
    page.should have_content "has been submitted."
  end

  scenario "if a comic has been uploaded by a user, that user can view it even if it's not approved" do
    test_issue = FactoryGirl.create(:issue, :user_id => @user.id)
    test_page = FactoryGirl.create(:page, :issue_id => test_issue.id)
    visit user_issues_path(@user.username)
    click_link "#{test_issue.title.name} ##{test_issue.number}"
    page.find('img')['src'].should have_content test_page.image
  end

  scenario "a comic uploaded by a user cannot be seen until approved" do
    test_issue = FactoryGirl.create(:issue, :user_id => @user.id)
    test_page = FactoryGirl.create(:page, :issue_id => test_issue.id)
    visit root_url
    page.should_not have_content test_issue
    test_issue.approved == 1
    visit root_url
    page.should have_content "#{test_issue.title.name} ##{test_issue.number}"
  end
end
