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

    page.should_not have_content issue_1.title.name
    page.should have_content issue_2.title.name
  end

end
