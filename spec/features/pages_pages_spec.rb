require 'spec_helper'

feature "Viewing a comic book page" do
  scenario "after choosing a book to read they can see the first page" do
    issue = FactoryGirl.create(:page).issue
    visit issue_page_path(issue, issue.pages.first)
    page.find('img')['src'].should have_content issue.pages.first.image
  end

  scenario "clicking on the image takes the user to the next image" do
    issue = FactoryGirl.create(:page, :image => "page_1_image_url").issue
    page_2 = issue.pages.create(:number => 2, :image => "page_2_image_url")
    visit issue_page_path(issue, issue.pages.first)
    find("#image-id-#{issue.pages.first.id}").click
    page.find('img')['src'].should have_content page_2.image
  end

  scenario "can use the select dropdown to go to any page of the issue" do
    issue = FactoryGirl.create(:page).issue
    page_2 = issue.pages.create(:number => 2, :image => "page_2_image_url")
    page_3 = issue.pages.create(:number => 3, :image => "page_3_image_url")
    visit issue_page_path(issue, issue.pages.first)
    select("3", :from => "page_id")
    click_button "Go to Page"
    page.find('img')['src'].should have_content page_3.image
  end

  scenario "can use the previous-arrow link to go to the previous page" do
    issue = FactoryGirl.create(:page, :image => "page_1_image_url").issue
    page_2 = issue.pages.create(:number => 2, :image => "page_2_image_url")
    visit issue_page_path(issue, page_2)
    find("#previous-arrow").click
    page.find('img')['src'].should have_content issue.pages.first.image
  end

  scenario "can use the next-arrow link to go to the next page" do
    issue = FactoryGirl.create(:page, :image => "page_1_image_url").issue
    page_2 = issue.pages.create(:number => 2, :image => "page_2_image_url")
    visit issue_page_path(issue, issue.pages.first)
    find("#next-arrow").click
    page.find('img')['src'].should have_content page_2.image
  end
end

# page.first("#image-id-#{issue.pages.find_by_number(2)}").click
# page.should have_css('img', text: "image1.jpg")
