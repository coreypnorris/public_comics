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
end
