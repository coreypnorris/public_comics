require 'spec_helper'

feature "Using universal navbar links" do
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
    tomb_of_dracula_1 = FactoryGirl.create(:issue)
    tomb_of_dracula.issues << tomb_of_dracula_1
    two_gun_kid_1 = FactoryGirl.create(:issue)
    two_gun_kid.issues << two_gun_kid_1
    tomb_of_dracula_1_page_1 = FactoryGirl.create(:page)
    tomb_of_dracula_1.pages << tomb_of_dracula_1_page_1
    two_gun_kid_1_page_1 = FactoryGirl.create(:page)
    two_gun_kid_1.pages << two_gun_kid_1_page_1

    visit issue_page_path(tomb_of_dracula_1, tomb_of_dracula_1_page_1)

    select("Horror", :from => "genre-selector")
    click_button "Go to Genre"

    page.should have_content tomb_of_dracula_1.title.name
  end
end

feature "Using navbar links when signed in" do
  before { create_and_sign_in_user }

  scenario "User can access profile page", :retry => 3 do
    click_link "Your Profile"
    page.should have_content "#{@user.username}"
  end
end


feature "Using navbar links when not signed in" do
  before { visit root_path }

  scenario "User can access sign up form" do
    click_link "Sign Up"
    page.should have_content "Username"
    page.should have_content "Email"
    page.should have_content "Password"
    page.should have_content "Password Confirmation"
  end

  scenario "User can access sign in form" do
    click_link "Sign In"
    page.should have_content "Username"
    page.should have_content "Password"
    page.should have_content "Forgot your password?"
  end
end
