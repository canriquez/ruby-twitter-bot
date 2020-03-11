require 'pony'
require_relative "../secret/key.rb"


class PonyHandler
    include EnviVars

    def initialize
    end

    def SendMail(msg)
        Pony.mail(mail_init(msg))
        puts "email sent"
    end

    private
    def mail_init(message)
        return {:to => 'carlos.el.coder@gmail.com', 
        :subject => "LagarBot Message Update ", 
        :headers => { 'Content-Type' => 'text/html' },
        :body => " #{message}",
        :via => :smtp, :via_options => {
            :address => 'smtp.gmail.com',
            :port => '587',
            :user_name => EMAIL_LOGIN,
            :password => EMAIL_PASS,
            :authentication => :plain,
            :domain => "gmail.com"
            }}
    end
end