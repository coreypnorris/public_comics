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

end
