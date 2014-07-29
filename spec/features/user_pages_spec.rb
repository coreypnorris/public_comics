require 'spec_helper'

feature 'Viewing profile' do
  before { create_and_sign_in_user }
  before { visit user_path(@user) }

  scenario 'user can upload an avatar', :retry => 5 do
    attach_file('user_avatar', File.join(Rails.root, '/spec/support/test_avatar.png'))
    page.should have_content "Username: #{@user.username}"
  end
end
