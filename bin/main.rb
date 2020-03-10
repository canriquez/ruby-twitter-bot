#!/usr/bin/env ruby
require_relative '../lib/twitter_handler.rb'
require_relative '../lib/github_handler.rb'

USER = '@cranriquez'
TWEET_HASH = "#100daysofCode"
D100_FORMAT =  /[R](\d+)[D](\d+)/
D100_TWITT_MATCH = /^\*\*Twitter\:([R](\d)+[D](\d+).*\#100DaysOfCode)/

last_on_twitter = []
last_on_repo = []

d100_tweet = TwitterHandler.new(USER,TWEET_HASH,D100_FORMAT)

puts "...checking last 100DofCode for #{USER}"
last_on_twitter = d100_tweet.last_hash_tweet?   # Test if 'last' has been twited for my user.

if !last_on_twitter.nil? 
    puts "getting : R#{last_on_twitter[0]}D#{last_on_twitter[1]} - '#{last_on_twitter[2][0..40]}...' - created : #{last_on_twitter[3]}" 
    tweet_time = Time.parse(last_on_twitter[3])
    puts "...last tweet update is from #{(Time.now-tweet_time)/60/60.to_i} hours ago."
else
    puts "... failing to get a valid tweet publishd with #{TWEET_HASH} hash..."
    puts "... building into report to #{USER} "
end


d100_github = GithubHandler.new
puts "...checking github @#{d100_github.gitrepo}"

last_on_repo = d100_github.read_100dfile

if !last_on_repo.nil? 
    puts "getting : R#{last_on_repo[0]}D#{last_on_repo[1]} - '#{last_on_repo[2][0..40]}...'" 
else
    puts "... failing to get a valid record on repo h #{d100_github.gitrepo} ..."
    puts "... building into report to #{USER}  "
end

#if !last_on_repo.nil? && !last_on_twitter.nil?



#Main program should be able to detect if tweet has same id and react if it as been sent already.
#p d100_tweet.send_100DC_tweet('hello world!, live from Salta, T2 Argentina')

