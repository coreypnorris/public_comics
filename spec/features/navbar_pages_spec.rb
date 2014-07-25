require 'spec_helper'

feature "Using navbar links" do

  scenario "can use homepage link to go to the homepage" do
    visit new_user_registration_path
    click_link "homepage-link"
    page.should have_content "Read comics from the public domain."
  end
end
