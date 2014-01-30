require "test_helper"

feature "Deleting a Post" do
  scenario "only editors can delete posts" do

     sign_in(:editor)
     visit posts_path
     save_and_open_page
     #page.find("tbody tr:last").click_on "Destroy"

     page.must_have_content posts(:cf).title
     page.must_have_content posts(:cf).body
     end

    scenario "authors can't delete all posts" do
     sign_in(:editor)
     visit posts_path

     #page.find("tbody tr:first").click_on "Edit"

     #page.must_have_content "That shit aint yours!"

     end

     scenario "authors can delete posts that belong to them" do
     end
end



