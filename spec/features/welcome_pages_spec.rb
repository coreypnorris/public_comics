require 'spec_helper'

feature "Viewing home page" do

  scenario "User sees 4 latest issues" do
    visit root_url
    comic_1 = FactoryGirl.create(:title)
    comic_2 = FactoryGirl.create(:title)
    comic_3 = FactoryGirl.create(:title)
    comic_4 = FactoryGirl.create(:title)
    comic_5 = FactoryGirl.create(:title)

    page.should have_content comic_5.name
    page.should_not have_content comic_1.name
  end

end
