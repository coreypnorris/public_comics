require 'spec_helper'

feature "Viewing home page" do

  scenario "User sees 4 latest issues" do
    comic_1 = FactoryGirl.create(:page).issue
    comic_2 = FactoryGirl.create(:page).issue
    comic_3 = FactoryGirl.create(:page).issue
    comic_4 = FactoryGirl.create(:page).issue
    comic_5 = FactoryGirl.create(:page).issue
    visit root_path

    page.should have_content comic_5.title.name
    page.should_not have_content comic_1.title.name
  end

  scenario "User can use pagination links to see comics added earlier" do
    comic_1 = FactoryGirl.create(:page).issue
    comic_2 = FactoryGirl.create(:page).issue
    comic_3 = FactoryGirl.create(:page).issue
    comic_4 = FactoryGirl.create(:page).issue
    comic_5 = FactoryGirl.create(:page).issue
    visit root_path
    click_link "Next"

    page.should have_content comic_1.title.name
    page.should_not have_content comic_5.title.name
  end

  scenario "User can filter comics by genre" do
    comic_1 = FactoryGirl.create(:page).issue
    comic_2 = FactoryGirl.create(:page).issue
    visit root_path
    click_link comic_2.title.genre.name

    page.should_not have_content comic_1
  end

  scenario "User can search for comics with search bar" do
    comic_1 = FactoryGirl.create(:page).issue
    comic_2 = FactoryGirl.create(:page).issue
    visit root_path
    fill_in 'search', with: comic_2.title.name
    click_button 'Search'

    page.should_not have_content comic_1
  end

end
