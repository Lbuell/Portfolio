require "test_helper"

feature "as a user i want to recieve contact email" do
  scenario "fill out form and send" do
    visit contact_path

    fill_in "Name", with: "Buddy the elf"
    fill_in "Email", with: "test@test.com"
    fill_in "Subject", with: "Sample subjext"
    fill_in "Body", with: "Sample Text"

    click_on "Send"

    page.text.must_include "Message was successfully sent"
  end
end

