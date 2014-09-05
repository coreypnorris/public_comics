require 'spec_helper'

feature "Using universal navbar links" do
  let(:superhero) { FactoryGirl.create(:genre, :name => "Super Hero") }
  let(:action_comics) { FactoryGirl.create(:title, :name => "Action Comics", :genres => [superhero]) }
  let(:action_comics_1) { FactoryGirl.create(:issue, :number => 1, :title_id => action_comics.id) }
  let!(:action_comics_1_page_1) { FactoryGirl.create(:page, :number => 1, :issue_id => action_comics_1.id) }
  let(:horror) { FactoryGirl.create(:genre, :name => "Horror") }
  let(:tomb_of_dracula) { FactoryGirl.create(:title, :name => "Tomb of Dracula", :genres => [horror]) }
  let(:tomb_of_dracula_1) { FactoryGirl.create(:issue, :number => 1, :title_id => tomb_of_dracula.id) }
  let!(:tomb_of_dracula_1_page_1) { FactoryGirl.create(:page, :number => 1, :issue_id => tomb_of_dracula_1.id) }

  before { visit root_path }

  scenario "can use homepage link to go to the homepage" do
    visit new_user_registration_path
    click_link "homepage-link"
    page.should have_content "Read comics from the public domain."
  end

  scenario "User can search for issues with search bar", :retry => 3 do
    issue_1 = FactoryGirl.create(:page).issue
    issue_2 = FactoryGirl.create(:page).issue
    fill_in 'search', with: issue_2.title.name
    click_button 'Search'
    within("#main") do
      page.should have_content issue_2.title.name
      page.should_not have_content issue_1.title.name
    end
  end

  scenario "User can filter issues by title with title selector" do
    select("Action Comics", :from => "title-selector")
    click_button "Go to Title"
    within("#main") do
      page.should have_content action_comics_1.title.name
      page.should_not have_content tomb_of_dracula_1.title.name
    end
  end

  scenario "User can filter issues by genre with genre selector" do
    select("Horror", :from => "genre-selector")
    click_button "Go to Genre"
    within("#main") do
      page.should have_content tomb_of_dracula_1.title.name
      page.should_not have_content action_comics_1.title.name
    end
  end
end

feature "Using navbar links when signed in" do
  before { create_and_sign_in_user }

  scenario "User can access profile page", :retry => 5 do
    click_link "#{@user.username}"
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
