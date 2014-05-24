require 'spec_helper'

feature "Viewing a comic book page" do
  scenario "after choosing a book to read they can see the first page" do
    issue = FactoryGirl.create(:page).issue
    visit issue_page_path(issue, issue.pages.first)

    page.find('img')['src'].should have_content issue.pages.first.image
  end

  scenario "cannot go to the next page on the last page of a book" do
    issue = FactoryGirl.create(:page).issue
    visit issue_page_path(issue, issue.pages.last)
    find('img').click

    page.should have_content issue.title.name
  end

  scenario "can use the select dropdown to go to any page of the book they're reading" do
    issue = FactoryGirl.create(:page).issue
    issue.pages << Page.create(:number => 2, :image => "page_2_image_url")
    issue.pages << Page.create(:number => 3, :image => "page_3_image_url")
    visit issue_page_path(issue, issue.pages.first)
    select("3", :from => "page_id")
    click_button "Go to Page"
    page.should have_content
  end
end
