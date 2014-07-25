require 'spec_helper'

feature "Using navbar links" do
  before { visit new_user_registration_path }

  scenario "can use homepage link to go to the homepage" do
    click_link "homepage-link"
    page.should have_content "Read comics from the public domain."
  end

  scenario "User can search for issues with search bar", :retry => 3 do
    issue_1 = FactoryGirl.create(:page).issue
    issue_2 = FactoryGirl.create(:page).issue
    visit root_path
    fill_in 'search', with: issue_2.title.name
    click_button 'Search'

    page.should_not have_content issue_1.title.name
    page.should have_content issue_2.title.name
  end

  scenario "User can filter issues by genre with genre selector" do
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
end
