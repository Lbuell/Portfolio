require "test_helper"

feature "Editing a Post" do
  scenario "Editors have full access" do
     # Given an authorized user complets a new post form
     visit new_user_session_path
     fill_in "Email", with: users(:liam).email
     fill_in "Password", with: "password"
    click_on "Sign in"

    visit post_path(posts(:liam))
    click_on "Edit"
    page.text.must_include "Publish"
    #save_and_open_page
     fill_in "Title", with: "Dude."
    click_on "Update Post"
    # Then the post is updated
     page.text.must_include "Post was successfully updated"
    page.text.must_include "Dude."
  end

  scenario "Authors can edit posts but not publish" do
     visit new_user_session_path
     fill_in "Email", with: users(:dude).email
     fill_in "Password", with: "password"
    click_on "Sign in"
    #save_and_open_page
     visit post_path(posts(:dude))

    click_on "Edit"
    page.wont_have_content "Publish"
    #save_and_open_page
     fill_in "Title", with: "Hi there"
    click_on "Update Post"

    page.text.must_include "Hi there"

  end
end
