require "test_helper"

feature("
  As a site visitor
  I want to be able to sign up for an account
  so that I can perform actions that require me to be logged in.
") do
  scenario "sign up" do
    # Given a registration form
    visit "/"
    click_on "Sign Up"

    # When I register with valid info
    fill_in "Email", with: "2babies11@example.com"
    fill_in "Password", with: "password11"
    fill_in "Password confirmation", with: "password11"
    click_on "Sign up"

    #save_and_open_page
    page.must_have_content "Welcome! You have signed up successfully."
    page.wont_have_content "There was a problem with your sign up"
  end
end
