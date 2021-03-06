require 'spec_helper'

feature "Viewing a comic book page" do
  let(:superhero) { FactoryGirl.create(:genre, :name => "Super Hero") }
  let(:action_comics) { FactoryGirl.create(:title, :name => "Action Comics", :genre_id => superhero.id) }
  let(:action_comics_1) { FactoryGirl.create(:issue, :number => 1, :title_id => action_comics.id) }
  let!(:action_comics_1_page_1) { FactoryGirl.create(:page, :number => 1, :issue_id => action_comics_1.id) }
  let!(:action_comics_1_page_2) { FactoryGirl.create(:page, :number => 2, :issue_id => action_comics_1.id) }
  let!(:action_comics_1_page_3) { FactoryGirl.create(:page, :number => 3, :issue_id => action_comics_1.id) }

  before { visit issue_page_path(action_comics_1, action_comics_1_page_1) }

  scenario "clicking on an issue goes to that issue's first page" do
    page.find('img')['src'].should have_content action_comics_1_page_1.image
  end

  scenario "clicking on the image takes the user to the next image" do
    find("#image-id-#{action_comics_1_page_1.id}").click
    page.find('img')['src'].should have_content action_comics_1_page_2.image
  end

  scenario "can use the select dropdown to go to any page of the issue" do
    select("3", :from => "page-selector")
    click_button "Go to Page"
    page.find('img')['src'].should have_content action_comics_1_page_3.image
  end

  scenario "can use the next-arrow link to go to the next page" do
    find("#next-arrow").click
    page.find('img')['src'].should have_content action_comics_1_page_2.image
  end

  scenario "can use the previous-arrow link to go to the previous page" do
    visit issue_page_path(action_comics_1, action_comics_1_page_2)
    find("#previous-arrow").click
    page.find('img')['src'].should have_content action_comics_1_page_1.image
  end

  scenario "can use the thumbnails button to view thumbnails of all the pages in the issue" do
    find("#thumbnails-button").click
    page.should have_css("img.thumbnail-#{action_comics_1_page_1.number}")
    page.should have_css("img.thumbnail-#{action_comics_1_page_2.number}")
    page.should have_css("img.thumbnail-#{action_comics_1_page_3.number}")
  end

  scenario "can use the genre button to view all titles with that genre" do
    action_comics_2 = FactoryGirl.create(:issue, :number => 2)
    action_comics.issues << action_comics_2
    action_comics_2_page_1 = FactoryGirl.create(:page, :number => 1)
    action_comics_2.pages << action_comics_2_page_1
    find("#issue-genre-button").click
    page.should have_content "#{superhero.name} Comics"
    page.should have_css("img.#{action_comics.name.delete(' ')}-#{action_comics_1.pages.first.number}")
    page.should have_css("img.#{action_comics.name.delete(' ')}-#{action_comics_2.pages.first.number}")
  end
end

feature "Commenting on the page's issue" do

  scenario "creating a comment" do
    create_and_sign_in_user
    comment = FactoryGirl.build(:comment, :user_id => @user.id)
    reply = FactoryGirl.build(:comment, :user_id => @user.id)
    issue = FactoryGirl.create(:page).issue
    visit issue_page_path(issue, issue.pages.first)
    fill_in "issue-#{issue.id}-comment-body", :with => comment.body
    click_button "Comment on this issue"
    page.should have_content 'posted'
  end

  scenario "creating a reply to a comment", :retry => 5, js: true do
    create_user_and_page_and_post_comment
    create_reply_to_comment
    page.should have_content 'posted'
    page.should have_content '2 Comments'
  end

  scenario "creating a reply to a reply", :retry => 5, js: true do
    create_user_and_page_and_post_comment
    create_reply_to_comment
    reply_to_reply = FactoryGirl.build(:comment, :user_id => @user.id)
    within(:css, "div#comment-#{Comment.last.id}-div") do
      click_on "Reply"
    end
    fill_in "comment-#{(Comment.last.id)}-comment-body", :with => reply_to_reply.body
    click_button "Confirm"
    page.should have_content 'posted'
    page.should have_content '3 Comments'
  end

  scenario "canceling a reply to a comment", :retry => 5, js: true do
    create_user_and_page_and_post_comment
    click_on "Reply"
    click_button "Cancel"
    page.should have_content 'Reply'
    page.should_not have_content 'Confirm'
  end
end

feature "editing a comment" do
  before { create_user_and_page_and_post_comment }

  scenario "changing the body a posted comment", :retry => 5, js: true do
    click_on 'edit'
    fill_in "comment_body", :with => "changed comment"
    click_on 'Confirm'
    page.should have_content 'changed comment'
  end

  scenario "cancel editing a comment", :retry => 5, js: true do
    click_on 'edit'
    click_button "Cancel"
    page.should have_content 'edit'
    page.should_not have_content 'Confirm'
  end
end

feature "deleting a comment" do
  scenario "deleting a comment" do
    create_user_and_page_and_post_comment
    click_on 'delete'
    page.should_not have_content @comment.body
  end
end

feature "voting on a comment" do
  before { create_user_and_page_and_post_comment }
  before { sign_out }
  before { create_and_sign_in_user_for_poltergeist }
  before { visit issue_page_path(@issue, @issue.pages.first) }

  scenario "upvoting a comment", :retry => 5, js: true do
    click_on("comment-#{Comment.last.id}-upvote")
    page.should have_content '1 point'
  end

  scenario "downvoting a comment", :retry => 5, js: true do
    click_on("comment-#{Comment.last.id}-downvote")
    page.should have_content '-1 points'
  end
end
