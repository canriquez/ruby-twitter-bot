require 'twitter'

class TwitterHandler

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
            config.consumer_key        = "auRK87I4xef1N1BcfRIb5E57E"
            config.consumer_secret     = "oN0IdmZZqrZ70E4hsSwN9ZrZ0qQSMnPBEDWaT9cLBAn4UPmf2b"
            config.access_token        = "3008434995-wX7wx9qD1Z3YpmoYgXfyKZltYDW0sVkMn57Uh1f"
            config.access_token_secret = "PmxF7C6Pl7reRvlDXTjBpw8laDTrl7zL3JCO0jyL2PxdS"
          end
    end


end
