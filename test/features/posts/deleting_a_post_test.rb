require "test_helper"

feature "Deleting a Post" do
  scenario "only editors can delete posts" do
  	visit new_user_session_path
     fill_in "Email", with: users(:liam).email
     fill_in "Password", with: "password"
     click_on "Sign in"
     visit posts_path

     page.find("tbody tr:last").click_on "Destroy"

     page.must_have_content posts(:cf).title
     page.must_have_content posts(:cf).body
     end

    scenario "authors can't delete all posts" do
     visit new_user_session_path
     fill_in "Email", with: users(:dude).email
     fill_in "Password", with: "password"
     click_on "Sign in"
     visit posts_path

     page.find("tbody tr:first").click_on "Edit"

     page.must_have_content "That shit aint yours!"

     end

     scenario "authors can delete posts that belong to them" do
     end
end



