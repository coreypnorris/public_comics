require 'spec_helper'

feature 'Viewing profile' do
  before { create_and_sign_in_user }
  before { visit user_path(@user) }

  scenario 'user can upload an avatar', :retry => 5 do
    page.attach_file('user_avatar', File.join(Rails.root, '/spec/support/test_image.png'))
    click_button 'Upload Image'
    page.should have_content("Your avatar has been added.")
  end
end
