require 'spec_helper'

feature "Viewing home page" do

  scenario "User sees 12 latest issues" do
    old_issue = FactoryGirl.create(:page).issue
    11.times { FactoryGirl.create(:page).issue }
    new_issue = FactoryGirl.create(:page).issue

    visit root_path

    page.should have_content new_issue.title.name
    page.should_not have_content old_issue.title.name
  end

  scenario "User can use pagination links to see issues added earlier" do
    old_issue = FactoryGirl.create(:page).issue
    11.times { FactoryGirl.create(:page).issue }
    new_issue = FactoryGirl.create(:page).issue
    visit root_path

    within("#paginate-one") do
        click_link "Next"
    end

    page.should have_content old_issue.title.name
    page.should_not have_content new_issue.title.name
  end

  scenario "User can filter issues by genre with genre buttons" do
    horror = FactoryGirl.create(:genre, :name => "Horror")
    tomb_of_dracula = horror.titles.create(:name => "Tomb of Dracula")
    western = FactoryGirl.create(:genre, :name => "Western")
    two_gun_kid = western.titles.create(:name => "Two Gun Kid")
    tomb_of_dracula_1 = tomb_of_dracula.issues.create(:number => 1, :cover =>"tomb_of_dracula_1_cover")
    two_gun_kid_1 = two_gun_kid.issues.create(:number => 1, :cover =>"two_gun_kid_1_cover")
    tomb_of_dracula_1.pages.create(:number => 1, :image => "page_1_image_url")
    two_gun_kid_1.pages.create(:number => 1, :image => "page_1_image_url")
    visit issue_page_path(tomb_of_dracula_1, tomb_of_dracula_1.pages.first)

    select("Horror", :from => "genre-selector")
    click_button "Go to Genre"
    page.should have_content tomb_of_dracula_1.title.name
  end

  scenario "User can search for issues with search bar" do
    issue_1 = FactoryGirl.create(:page).issue
    issue_2 = FactoryGirl.create(:page).issue
    visit root_path
    fill_in 'search', with: issue_2.title.name
    click_button 'Search'

    page.should_not have_content issue_1.title.name
    page.should have_content issue_2.title.name
  end

end
