require 'spec_helper'

feature "Viewing home page" do

  scenario "User sees 4 latest issues" do
    issue_1 = FactoryGirl.create(:page).issue
    issue_2 = FactoryGirl.create(:page).issue
    issue_3 = FactoryGirl.create(:page).issue
    issue_4 = FactoryGirl.create(:page).issue
    issue_5 = FactoryGirl.create(:page).issue
    visit root_path

    page.should have_content issue_5.title.name
    page.should_not have_content issue_1.title.name
  end

  scenario "User can use pagination links to see issues added earlier" do
    issue_1 = FactoryGirl.create(:page).issue
    issue_2 = FactoryGirl.create(:page).issue
    issue_3 = FactoryGirl.create(:page).issue
    issue_4 = FactoryGirl.create(:page).issue
    issue_5 = FactoryGirl.create(:page).issue
    visit root_path
    click_link "Next"

    page.should have_content issue_1.title.name
    page.should_not have_content issue_5.title.name
  end

  scenario "User can filter issues by genre" do
    issue_1 = FactoryGirl.create(:page).issue
    issue_2 = FactoryGirl.create(:page).issue
    visit root_path
    click_link issue_2.title.genre.name

    page.should_not have_content issue_1
  end

  scenario "User can search for issues with search bar" do
    issue_1 = FactoryGirl.create(:page).issue
    issue_2 = FactoryGirl.create(:page).issue
    visit root_path
    fill_in 'search', with: issue_2.title.name
    click_button 'Search'

    page.should_not have_content issue_1
  end

end
