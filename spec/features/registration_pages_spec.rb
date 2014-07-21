require 'spec_helper'

feature 'Signing Up' do
  let(:user) { FactoryGirl.build(:user) }
  before { visit new_user_registration_path }

  scenario 'with valid inputs' do
    fill_in 'Username', :with => user.username
    fill_in 'Email', :with => user.email
    fill_in 'Password', :with => user.password
    fill_in 'Password Confirmation', :with => user.password_confirmation
    click_button "Sign up"
    page.should have_content 'successfully'
  end

  scenario "with blank field" do
    visit new_user_registration_path
    click_button "Sign up"
    page.should have_content "can't be blank"
  end

  scenario "with invalid email" do
    fill_in 'Username', :with => user.username
    fill_in "Email", :with => "my_email_address.com"
    fill_in "Password", :with => user.password
    fill_in "Password Confirmation", :with => "foobarbas"
    click_button "Sign up"
    page.should have_content 'invalid'
  end

  scenario "with password under 8 characters" do
    fill_in 'Username', :with => user.username
    fill_in "Email", :with => user.email
    fill_in "Password", :with => "1234"
    fill_in "Password Confirmation", :with => "1234"
    click_button "Sign up"
    page.should have_content 'too short'
  end

  scenario "with nonmatching passwords" do
    fill_in 'Username', :with => user.username
    fill_in "Email", :with => user.email
    fill_in "Password", :with => user.password
    fill_in "Password Confirmation", :with => "foobarbas"
    click_button "Sign up"
    page.should have_content 'match'
  end
end

feature 'Signing in' do
  let(:user) { FactoryGirl.create(:user) }
  before { sign_in(user) }

  scenario "can sign in" do
    page.should have_content "successfully"
  end

  scenario "can sign out" do
    visit root_path
    click_link "Sign Out"
    page.should have_content "successfully"
  end

  scenario "with incorrect information" do
    sign_out
    visit new_user_session_path
    fill_in "Username", :with => "Wrong Username"
    fill_in "Password", :with => user.password
    click_button "Sign in"
    page.should have_content 'Invalid'
  end

  scenario "navbar should have link to profile page" do
    visit root_path
    page.should have_content "Signed in as #{user.username}"
  end

  scenario "navbar should not have a 'sign up' link" do
    visit root_path
    page.should_not have_content "Sign Up"
  end

  scenario 'site should block access to signing up' do
    visit new_user_registration_path
    page.should have_content "You are already signed in."
  end

  scenario 'site should block access to signing in' do
    visit new_user_session_path
    page.should have_content "You are already signed in."
  end
end

feature "Editing account" do
  let(:user) { FactoryGirl.create(:user) }
  before { sign_in(user) }

  scenario "logged in user is able to access edit account form" do
    visit root_path
    click_link "Signed in as #{user.username}"
    click_link "Edit or cancel your account"
    page.should have_content "Edit Account"
  end

  scenario "logged in user is able to change their username" do
    visit edit_user_registration_path
    fill_in "Username", with: "NewUsername"
    fill_in "Current Password", with: user.password
    click_button "Update"
    page.should have_content "successfully"
  end

  scenario "logged in user is able to change their email" do
    visit edit_user_registration_path
    fill_in "Email", with: "newemail@example.com"
    fill_in "Current Password", with: user.password
    click_button "Update"
    page.should have_content "successfully"
  end

  scenario "logged in user is able to change their password" do
    visit edit_user_registration_path
    fill_in "Password", with: "NewPassword"
    fill_in "Password Confirmation", with: "NewPassword"
    fill_in "Current Password", with: user.password
    click_button "Update"
    page.should have_content "successfully"
  end
end

