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

  def sanity_check
    missing = []
    sanity = {CONFIG_USER: ENV['CONFIG_USER'],
    CONFIG_TWEET_HASH: ENV['CONFIG_TWEET_HASH'],
    CONFIG_CONSUMER_KEY: ENV['CONFIG_CONSUMER_KEY'],
    CONFIG_CONSUMER_SECRET: ENV['CONFIG_CONSUMER_SECRET'],
    CONFIG_ACCESS_TOKEN: ENV['CONFIG_ACCESS_TOKEN'],
    CONFIG_ACCESS_TOCKEN_SECRET: ENV['CONFIG_ACCESS_TOCKEN_SECRET'],
    GITLOG: ENV['GITLOG'],
    GITPASS: ENV['GITPASS'],
    GITREPO: ENV['GITREPO'],
    FILEPATH: ENV['FILEPATH'],
    EMAIL_LOGIN: ENV['EMAIL_LOGIN'],
    EMAIL_PASS: ENV['EMAIL_PASS']}
    sanity.each {|key, value| value=='' ? missing << key : false}
    if missing.length > 0
      return "Sanity Check Error: Some variables withouth configuration at .env file: \n #{missing}"
    else
      return "Sanity Check Ok"
    end
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
