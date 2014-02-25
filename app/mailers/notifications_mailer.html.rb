class NotificationsMailer < ActionMailer::Base

  default from: "noreply@liambuell.com"
  default to: "liamcbuell@gmail.com"

  def new_message(message)
    @message = message
    mail(:subject => "[liambuell.com] #{message.subject}")
  end

end
