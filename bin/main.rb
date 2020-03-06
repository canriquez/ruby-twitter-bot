require 'twitter'

USER = '@cranriquez'
TWEET_HASH = "#100DaysOfCode"
D100_FORMAT =  /[R](\d+)[D](\d+)/
d100_twitt = []

client = Twitter::REST::Client.new do |config|
  config.consumer_key        = "auRK87I4xef1N1BcfRIb5E57E"
  config.consumer_secret     = "oN0IdmZZqrZ70E4hsSwN9ZrZ0qQSMnPBEDWaT9cLBAn4UPmf2b"
  config.access_token        = "3008434995-wX7wx9qD1Z3YpmoYgXfyKZltYDW0sVkMn57Uh1f"
  config.access_token_secret = "PmxF7C6Pl7reRvlDXTjBpw8laDTrl7zL3JCO0jyL2PxdS"
end


last_tweet= ''

#tweets = client.user_timeline('#ES_F', count: 1)
#tweets.each { |tweet| puts tweet.full_text }

client.search("from:#{USER} #{TWEET_HASH}", result_type: "recent", tweet_mode: "extended").take(1).each do |tweet|
    last_tweet = tweet.full_text
  end

d100_twitt = last_tweet.match(D100_FORMAT)
puts " #{d100_twitt[0]}"
puts " #{d100_twitt[1]}"
puts " #{d100_twitt[2]}"
puts " #{d100_twitt[3]}"


#client.update("Hey this is my first tweet using Twitter gem! - really fun stuff")
