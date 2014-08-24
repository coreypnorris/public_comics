require 'spec_helper'

feature "Viewing home page" do

  scenario "User sees 12 latest issues and their covers" do
    first_issue = FactoryGirl.create(:page, :number => 1).issue
    FactoryGirl.create(:page, :number => 2)
    FactoryGirl.create(:page, :number => 3)
    FactoryGirl.create(:page, :number => 4)
    FactoryGirl.create(:page, :number => 5)
    FactoryGirl.create(:page, :number => 6)
    FactoryGirl.create(:page, :number => 7)
    FactoryGirl.create(:page, :number => 8)
    FactoryGirl.create(:page, :number => 9)
    FactoryGirl.create(:page, :number => 10)
    FactoryGirl.create(:page, :number => 11)
    FactoryGirl.create(:page, :number => 12)
    last_issue = FactoryGirl.create(:page, :number => 13).issue

    visit root_url
    within("#main") do
      page.should have_content last_issue.title.name, last_issue.pages.first.image
      page.should_not have_content first_issue.title.name, first_issue.pages.first.image
    end
  end

  scenario "User can use pagination links to see issues added earlier" do
    first_issue = FactoryGirl.create(:page, :number => 1).issue
    FactoryGirl.create(:page, :number => 2)
    FactoryGirl.create(:page, :number => 3)
    FactoryGirl.create(:page, :number => 4)
    FactoryGirl.create(:page, :number => 5)
    FactoryGirl.create(:page, :number => 6)
    FactoryGirl.create(:page, :number => 7)
    FactoryGirl.create(:page, :number => 8)
    FactoryGirl.create(:page, :number => 9)
    FactoryGirl.create(:page, :number => 10)
    FactoryGirl.create(:page, :number => 11)
    FactoryGirl.create(:page, :number => 12)
    last_issue = FactoryGirl.create(:page, :number => 13).issue

    visit root_path

    within("#paginate-one") do
      click_link "Next"
    end

    within("#main") do
      page.should have_content first_issue.title.name, first_issue.pages.first.image
      page.should_not have_content last_issue.title.name, last_issue.pages.first.image
    end
  end
end
