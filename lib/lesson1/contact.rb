require "mail"

module Lesson1
  class Contact
    attr_reader :content, :toaddress, :fromaddress, :subject
  
    def initialize(name, email, feedback)
      @name = name
      @email = email
      @@content = "<red>Name: #{@name} | Email: #{@email} |<hr /><br /> " << feedback
      @@subject = "Feedback from web-app"
      @@toaddress = '2233965@gmail.com'
      @@fromaddress = '2233965@gmail.com'
    end

    Mail.defaults do
      delivery_method :smtp, { :address              => "smtp.gmail.com",
                              :port                 => 587,
                              :domain               => 'localhost',
                              :user_name            => '2233965',
                              :password             => '02z105201r',
                              :authentication       => 'plain',
                              :enable_starttls_auto => true  }
      end

    def send
      Mail.deliver do
        to @@toaddress
        from @@fromaddress
        subject @@subject
        body @@content
        content_type 'text/html; charset=UTF-8'
      end
    end
    def to_s
      @@content
    end
  end
end