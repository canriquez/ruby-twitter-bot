#!/usr/bin/env ruby
require_relative '../lib/twitter_handler.rb'
require_relative '../lib/github_handler.rb'

USER = '@cranriquez'
TWEET_HASH = "#100daysofCode"
D100_FORMAT =  /[R](\d+)[D](\d+)/
D100_TWITT_MATCH = /^\*\*Twitter\:([R](\d)+[D](\d+).*\#100DaysOfCode)/

d100_tweet = TwitterHandler.new(USER,TWEET_HASH,D100_FORMAT)

p d100_tweet.last_hash_tweet?   # Test if 'last' has been twited for my user.

d100_github = GithubHandler.new

p d100_github.read_100dfile


#Main program should be able to detect if tweet has same id and react if it as been sent already.
#p d100_tweet.send_100DC_tweet('hello world!, live from Salta, T2 Argentina')

