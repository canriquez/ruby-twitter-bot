require 'twitter'
require_relative "../secret/key.rb"

class TwitterHandler
    include TwitterDev

    def initialize(user,hash,d100format)
        @user = user
        @tweet_hash = hash
        @d100format = d100format
        @client = twitter_dev_init
        @last_tweet = ''
        @d100_tweet
    end


    def last_hash_tweet?

      @client.search("from:#{USER} #{TWEET_HASH}", result_type: "recent", tweet_mode: "extended").take(1).each do |tweet|
        @last_tweet = tweet.full_text
      end
      return false if @last_tweet == ''
      @d100_tweet = @last_tweet.match(D100_FORMAT)
      return @d100_tweet
    end

    private
    def twitter_dev_init
        return Twitter::REST::Client.new do |config|
            config.consumer_key        = CONFIG_CONSUMER_KEY
            config.consumer_secret     = CONFIG_CONSUMER_SECRET
            config.access_token        = CONFIG_ACCESS_TOKEN
            config.access_token_secret = CONFI_ACCESS_TOCKEN_SECRET
          end
    end


end
