require "test_helper"

feature "user sign in" do
  scenario "user signs in" do
    # Given an existing user
    visit root_path
    click_on "Log in"

    # When the user creates a new session
    fill_in "Email", with: users(:liam).email
    fill_in "Password", with: "password"
    click_on "Sign in"

    # Then the user should be signed in
    page.must_have_content "Signed in successfully"
    page.wont_have_content "Sign In"
  end
end
