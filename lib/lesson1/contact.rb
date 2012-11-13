require "net/smtp"

module Lesson1
  class Contact
    attr_reader :name, :email, :feedback
  
    def initialize(name, email, feedback)
      @name = name
      @email = email
      @feedback = feedback
      @subject = "Feedback"
      @toaddress = "2233965@gmail.com"
      @fromaddress = "From: webserver@example.com"
    end

    def send
      message = <<MESSAGE_END
      From: Web app <@fromaddress>
      To: Admin <@toaddress>
      Subject: @subject
      @name @email
      @feedback

      <b>This is HTML message.</b>
      <h1>This is headline.</h1>
MESSAGE_END

      Net::SMTP.start('localhost') do |smtp|
    smtp.send_message message, '@fromaddress','@toaddress'
    smtp.finish
    end
  end
  end
end