require 'spec_helper'

feature 'Signing Up' do
  scenario 'with valid inputs' do
    visit new_user_registration_path
    fill_in 'Username', :with => "snapper"
    fill_in 'Email', :with => "snapper_carr@jla.org"
    fill_in 'Password', :with => "foobarbaz"
    fill_in 'Password Confirmation', :with => "foobarbaz"
    click_button "Sign up"
    page.should have_content 'successfully'
  end

  scenario "with no inputs" do
    visit new_user_registration_path
    click_button "Sign up"
    page.should have_content 'blank'
  end
end
