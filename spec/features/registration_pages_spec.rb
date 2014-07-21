require 'spec_helper'

feature 'Signing Up' do
  scenario 'with valid inputs' do
    user = FactoryGirl.build(:user)
    visit new_user_registration_path
    fill_in 'Username', :with => user.username
    fill_in 'Email', :with => user.email
    fill_in 'Password', :with => user.password
    fill_in 'Password Confirmation', :with => user.password_confirmation
    click_button "Sign up"
    page.should have_content 'successfully'
  end

  scenario "with no inputs" do
    visit new_user_registration_path
    click_button "Sign up"
    page.should have_content 'blank'
  end

  scenario "with nonmatching password" do
    user = FactoryGirl.build(:user)
    visit new_user_registration_path
    fill_in 'Username', :with => user.username
    fill_in "Email", :with => user.email
    fill_in "Password", :with => user.password
    fill_in "Password Confirmation", :with => "foobarbas"
    click_button "Sign up"
    page.should have_content 'match'
  end
end

feature 'Signed in' do
  scenario "can sign in" do
    user = FactoryGirl.create(:user)
    sign_in(user)
    page.should have_content "successfully"
  end

  scenario "can sign out" do
    user = FactoryGirl.create(:user)
    sign_in(user)
    visit root_path
    click_link "Sign Out"
    page.should have_content "successfully"
  end

  scenario "navbar should have link to profile page" do
    user = FactoryGirl.create(:user)
    sign_in(user)
    visit root_path
    page.should have_content "Signed in as #{user.username}"
  end

  scenario "navbar should not have a 'sign up' link" do
    user = FactoryGirl.create(:user)
    sign_in(user)
    visit root_path
    page.should_not have_content "Sign Up"
  end

  scenario 'site should block access to signing up' do
    user = FactoryGirl.create(:user)
    sign_in(user)
    visit new_user_registration_path
    page.should have_content "You are already signed in."
  end

  scenario 'site should block access to signing in' do
    user = FactoryGirl.create(:user)
    sign_in(user)
    visit new_user_session_path
    page.should have_content "You are already signed in."
  end
end
