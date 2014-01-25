require "test_helper"

feature "Editing a Post" do
  scenario "submit updates to an existing post" do
     # Given an authorized user complets a new post form
    visit new_user_session_path
    fill_in "Email", with: users(:liam).email
    fill_in "Password", with: "password"
    click_on "Sign in"

    visit new_post_path# Given an existing post
    #post = Post.create(title: "Becoming a Code Fellow", body: "Means striving for excellence.")
    visit post_path(posts(:cr))

    # When I click edit and submit changed data
    click_on "Edit"
    fill_in "Title", with: "Becoming a Web Developer"
    click_on "Update Post"

    # Then the post is updated
    page.text.must_include "Post was successfully updated"
    page.text.must_include "Web Developer"
  end
end
