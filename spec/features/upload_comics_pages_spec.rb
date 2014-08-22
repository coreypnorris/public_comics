require 'spec_helper'

feature 'A user uploading a comic' do
  before { create_and_sign_in_user }
  let!(:test_user) { FactoryGirl.build(:user) }
  let!(:test_issue) { FactoryGirl.build(:issue, :user_id => test_user.id) }
  let!(:test_page) { FactoryGirl.build(:page, :issue_id => test_issue.id) }

  scenario "a user hasn't uploaded any comics", :retry => 5 do
    visit new_issue_path
    page.should have_content("New Issue")
    page.attach_file('new-issue-pages', File.join(Rails.root, '/spec/support/test_image.png'))
    fill_in 'title_name', :with => test_issue.title.name
    fill_in 'Issue Number', :with => test_issue.number
    fill_in 'title_genre_name', :with => test_issue.title.genre
    click_button 'Submit Issue'
    page.should have_content "has been submitted."
  end
end
