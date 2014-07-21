require 'spec_helper'

feature "Viewing a comic book page" do
  scenario "clicking on an issue goes to that issue's first page" do
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
    select("3", :from => "page-selector")
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

  scenario "can use the thumbnails button to view thumbnails of all the pages in the issue" do
    issue = FactoryGirl.create(:page, :image => "page_1_image_url").issue
    page_2 = issue.pages.create(:number => 2, :image => "page_2_image_url")
    page_3 = issue.pages.create(:number => 3, :image => "page_3_image_url")
    visit issue_page_path(issue, issue.pages.first)
    find("#thumbnails-button").click
    page.should have_css("img.thumbnail-#{issue.pages.first.number}")
    page.should have_css("img.thumbnail-#{page_2.number}")
    page.should have_css("img.thumbnail-#{page_3.number}")
  end

  scenario "can use the genre button to view all titles with that genre" do
    horror = FactoryGirl.create(:genre, :name => "Horror")
    tomb_of_dracula = horror.titles.create(:name => "Tomb of Dracula")
    western = FactoryGirl.create(:genre, :name => "Western")
    raw_hide_kid = western.titles.create(:name => "Raw Hide Kid")
    tomb_of_dracula_1 = tomb_of_dracula.issues.create(:number => 1, :cover =>"tomb_of_dracula_1_cover")
    raw_hide_kid_1 = raw_hide_kid.issues.create(:number => 1, :cover =>"raw_hide_kid_1_cover")
    tomb_of_dracula_1.pages.create(:number => 1, :image => "tomb_of_dracula_1_page_1_image_url")
    raw_hide_kid_1.pages.create(:number => 1, :image => "raw_hide_kid_1_page_1_image_url")
    visit issue_page_path(tomb_of_dracula_1, tomb_of_dracula_1.pages.first)
    find("#issue-genre-button").click

    page.should have_content "#{horror.name} Comics"
    page.should have_css("img.#{tomb_of_dracula.name.delete(' ')}-#{tomb_of_dracula_1.pages.first.number}")
    page.should_not have_content "#{western.name} Comics"
    page.should_not have_css("img.#{raw_hide_kid.name.delete(' ')}-#{raw_hide_kid_1.pages.first.number}")
  end
end
