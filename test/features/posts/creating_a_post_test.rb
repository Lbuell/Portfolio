require "test_helper"


feature "Creating a post" do
  scenario "authors can creat but not publish posts" do
     sign_in(:author)
     visit new_post_path
     fill_in "Title", with: posts(:cr).title
     fill_in "Body", with: posts(:cr).body

    click_on "Create Post"

    page.text.must_include "You did it!"
    page.text.must_include posts(:cr).title
    #page.text.must_include users(:liam).email

     page.text.must_include "Unpublished"
     #save_and_open_page
  end

  scenario "Editors should be able to create and publish" do
     sign_in

     visit new_post_path
     fill_in "Title",with: posts(:liam).title
     fill_in "Body", with: posts(:liam).body

    click_on "Create Post"

    page.text.must_include "You did it!"
    page.text.must_include posts(:liam).title
  end

  scenario "unauthenticated site vistiors cannot see new post button" do
    # When I visit the blog index page
    visit posts_path
    # Then I should not see the "New Post" button
    page.wont_have_link "New Blog Post"
  end
   scenario "authors can't publish" do
    # Given an author's account
    sign_in(:author)

    # When I visit the new page
    visit new_post_path

    # There is no checkbox for published
    page.wont_have_field('published')
  end

  scenario "editors can publish" do
    # Given an editor's account
    sign_in(:editor)

    # When I visit the new page
    visit new_post_path

    page.must_have_field('Published')

    # When I submit the form
    fill_in "Title", with: posts(:cl).title
    fill_in "Body", with: posts(:cl).body

    check "Published"
    click_on "Create Post"
    save_and_open_page

    # Then the published post should be shown
    page.text.must_include "You did it!"
  end
end
