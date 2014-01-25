require "test_helper"

feature "
  As a user,
  I want to sign out when I'm done
  so that my session is closed." do
  scenario "sign out current user" do
    # Given a current user
    visit user_session_path
    fill_in "Email", with: users(:dude).email
    fill_in "Password", with: "password"
    click_on "Sign in"

    page.must_have_content "Signed in successfully."
    #save_and_open_page
    page.must_have_content "Sign out"
    # When the sign out link is clicked
    click_on "Sign out"

    # Then the session should be destroyed
    page.must_have_content "Signed out successfully"
    page.wont_have_content "Sign Out"
  end
end
