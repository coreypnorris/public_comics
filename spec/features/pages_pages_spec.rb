require 'spec_helper'

feature "Viewing a comic book page" do

  scenario "User sees cover of comic" do
    comic = FactoryGirl.create(:page).issue
    visit title_issue_page_path(comic.title, comic, comic.pages.first)

    page.find('img')['src'].should have_content comic.pages.first.image
  end

end
