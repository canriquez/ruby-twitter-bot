require 'dotenv/load'
require 'pony'
require_relative 'robo_handler.rb'

class RoboDuties
  include RoboHandler

  def initialize; end

  def send_mail(msg)
    Pony.mail(mail_init(msg))
    'email sent'
  end

  private

  def mail_init(message)
    { to: 'carlos.el.coder@gmail.com',
      subject: 'LagarBot Message Update ',
      headers: { 'Content-Type' => 'text/html' },
      body: " #{message}",
      via: :smtp, via_options: {
        address: 'smtp.gmail.com',
        port: '587',
        user_name: ENV['EMAIL_LOGIN'],
        password: ENV['EMAIL_PASS'],
        authentication: :plain,
        domain: 'gmail.com'
      } }
  end
end
