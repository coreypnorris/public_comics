require 'spec_helper'

feature 'A user managing his/her uploaded comics' do
  before { create_and_sign_in_user }
  before { visit user_issues_path(@user.username) }

  scenario "a user hasnt uploaded any comics", :retry => 5 do
    page.should have_content("You havent uploaded any comics yet.")
  end
end
