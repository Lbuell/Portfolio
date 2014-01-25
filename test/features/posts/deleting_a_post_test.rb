require "test_helper"

feature "Deleting a Post" do
  scenario "post is deleted with a click" do
  	visit new_user_session_path
    fill_in "Email", with: users(:liam).email
    fill_in "Password", with: "password"
    click_on "Sign in"
    # Given an existing post
    visit posts_path

    # When the delete link is clicked
    page.find("tbody tr:last").click_on "Destroy"

    # Then the post is deleted
    page.must_have_content posts(:cf).title
    page.must_have_content posts(:cf).body
    end
end


