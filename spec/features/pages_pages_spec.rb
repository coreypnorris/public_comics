require 'spec_helper'

feature "Viewing a comic book page" do
  scenario "User sees cover of comic" do
    issue = FactoryGirl.create(:page).issue
    visit issue_page_path(issue, issue.pages.first)

    page.find('img')['src'].should have_content issue.pages.first.image
  end

  scenario "Disable next page links on the last page of an issue" do
    issue = FactoryGirl.create(:page).issue
    visit issue_page_path(issue, issue.pages.last)
    find('img').click

    page.should have_content issue.title.name
  end
end

feature "User can use arrow keys to navigate pages" do
  # let(:issue) { FactoryGirl.create(:page).issue }
  # scenario "left arrow key links to previous page and right arrow key links to next page" do
  #   visit issue_page_path(issue, issue.pages.first)
  #   send_keys :arrow_right
  #   page.find('img')['src'].should have_content issue.pages.first.next
  # end
end
