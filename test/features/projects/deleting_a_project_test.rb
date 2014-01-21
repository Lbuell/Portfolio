require "test_helper"

feature "As the site owner, I want to delete a portfolio item" do
  scenario "An item I don't want exists" do
    # Given an existing project (loaded from fixtures)
    # When I visit /projects/:id and click Delete
    visit project_path(projects(:freelance))
    click_on "Destroy"

    # Then I should no longer see the details of the project
    page.text.wont_include "Barnyard Cereal"
    page.text.wont_include "Ruby, Rails, Farmville API, Automilker"
  end
end
