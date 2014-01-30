require "test_helper"

feature "Post and project comments" do
    scenario "A logged in user should be able to post comments" do
     sign_in(:dude)
     visit post_path(posts(:dude))
     #fill_in "comment_content", with: "You are amazing!"
     click_on "Create Comment"

     page.text.must_include "Comment created."
    end


  scenario "Only editors can approve comments" do
     sign_in(:editor)
     visit post_path(posts(:dude))
     fill_in "comment_content", with: "You rules!"
     click_on "Create Comment"
     click_on "Approve"
     #save_and_open_page
     page.text.must_include "Comment approved."
  end
end


feature "Commenting on projects" do
    scenario "a logged in user should be able to post comments on projects" do
     sign_in(:dude)
     visit project_path(projects(:portfolio))
     fill_in "comment_content", with: "You rules!"
     click_on "Create Comment"

     #save_and_open_page
     page.text.must_include "Comment created."
    end

  scenario "editors can approve comments" do

    sign_in(:editor)
    visit project_path(projects(:portfolio))
    #save_and_open_page
    fill_in "comment_content", with: "You rules!"
    click_on "Create Comment"
    page.text.must_include "Comment created."
    click_on "Approve"
     save_and_open_page
    page.text.must_include "Comment approved."
  end
end
