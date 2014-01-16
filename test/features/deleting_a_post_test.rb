require "test_helper"

feature "Deleting a Post" do
  scenario "post is deleted with a click" do
    # Given an existing post
    visit posts_path

    # When the delete link is clicked
    page.find(:cr).click_on "Destroy"

    # Then the post is deleted
    page.wont_have_content "Code Rails"
    page.must_have_content posts(:cf).title
    page.must_have_content posts(:cz).title
  end
end
