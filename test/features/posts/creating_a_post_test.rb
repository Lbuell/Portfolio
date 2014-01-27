require "test_helper"


feature "Creating a post" do
  scenario "authors can creat but not publish posts" do
     visit user_session_path
     fill_in "Email", with: users(:dude).email
     fill_in "Password", with: "password"
    click_button "Sign in"
     visit new_post_path
     fill_in "Title", with: posts(:cr).title
     fill_in "Body", with: posts(:cr).body

    click_on "Create Post"

    page.text.must_include "Post was successfully created."
    page.text.must_include posts(:cr).title
    #page.text.must_include users(:liam).email

     page.text.must_include "Unpublished"
  end

  scenario "Editors should be able to create and publish" do
     visit user_session_path
     click_on "Sign in"
    fill_in "Email", with: users(:liam).email
     fill_in "Password", with: "password"
    click_button "Sign in"

    visit new_post_path
     fill_in "Title",with: posts(:liam).title
     fill_in "Body", with: posts(:liam).body

    click_on "Create Post"

    page.text.must_include "Post was successfully created"
    page.text.must_include posts(:liam).title
  end

  scenario "Visitors should only have view access to posts" do

    visit new_post_path

    page.text.must_include "You need to sign in"
  end
end
