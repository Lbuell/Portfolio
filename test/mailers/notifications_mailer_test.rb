require "test_helper"

class NotificationsMailerTest < ActionMailer::TestCase
  tests NotificationsMailer
  test "invite" do

    email = NotificationsMailer.new_message(@message).deliver
    email.must deliver_to("jojo@yahoo.com")
  end
end
