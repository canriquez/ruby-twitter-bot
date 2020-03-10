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
        :subject => "Lagar Robot Message Update ", 
        :headers => { 'Content-Type' => 'text/html' },
        :body => " #{message}",
        :via => :smtp, :via_options => {
            :address => 'smtp.gmail.com',
            :port => '587',
            :user_name => 'carlos.el.coder',
            :password => '19fiance20',
            :authentication => :plain,
            :domain => "gmail.com"
            }}
    end
end