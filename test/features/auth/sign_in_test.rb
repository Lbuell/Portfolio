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

  scenario "sign in with twitter works" do
    visit root_path
    click_on "Log in"
    OmniAuth.config.test_mode = true
    Capybara.current_session.driver.request.env['devise.mapping'] = Devise.mappings[:user]
    Capybara.current_session.driver.request.env['omniauth.auth'] = OmniAuth.config.mock_auth[:twitter]
    OmniAuth.config.add_mock(:twitter,
      { uid: '12345',
        info: { nickname: 'test_twitter_user'},
        })
    #binding.pry
    page.first(:link, "Sign in with Twitter").click
    page.must_have_content "test_twitter_user, you are signed in!"
    #save_and_open_page
  end

end
