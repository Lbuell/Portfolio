require "test_helper"

feature "As the site owner, I want to add a portfolio item so that I can show off my work" do
  scenario "adding a new project" do
    sign_in(:liam)
    visit projects_path
    click_on "New project"
    #save_and_open_page
    fill_in "Name", with: "Code Fellows Portfolio"
    fill_in "Technologies used", with: "Rails, Ruby, Bootstrap, HTML5, CSS3"
    click_on "Create Project"
    #save_and_open_page
    page.text.must_include "You did it!"
    page.text.must_include "Ninja"
  end

  scenario "new project has invalid data" do
    sign_in(:liam)
    # Given invalid project data is entered in a form
    visit new_project_path
    fill_in "Name", with: "L"
    # When the form is submitted with a short name and missing technologies_used field
    click_on "Create Project"
    # Then the form should be displayed again, with an error message
    current_path.must_match /projects$/
    page.text.must_include "Not sure what you were thinking there buddy"
    #page.text.must_include "Name is too short"
    #page.text.must_include "Technologies used can't be blank"
  end
end
