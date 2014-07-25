require 'spec_helper'

feature "Viewing home page" do

  scenario "User sees 12 latest issues and their covers" do
    action_comics = FactoryGirl.create(:title, :name => "Action Comics")
    action_comics_1 = action_comics.issues.create(:number => 1, :cover =>"action_comics_1_cover")
    action_comics_1.pages.create(:number => 1, :image => "page_1_image_url")
    11.times { FactoryGirl.create(:page).issue }
    detective_comics = FactoryGirl.create(:title, :name => "Detective Comics")
    detective_comics_27 = detective_comics.issues.create(:number => 27, :cover =>"detective_comics_27_cover")
    detective_comics_27.pages.create(:number => 1, :image => "page_1_image_url")
    visit root_url

    page.should have_content detective_comics.name, detective_comics_27.cover
    page.should_not have_content action_comics.name, action_comics_1.cover
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
end
