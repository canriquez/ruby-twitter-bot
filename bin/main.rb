#!/usr/bin/env ruby
require_relative '../lib/twitter_handler.rb'

USER = '@cranriquez'
TWEET_HASH = "#100daysOfCode"
D100_FORMAT =  /[R](\d+)[D](\d+)/

d100_tweet = TwitterHandler.new(USER,TWEET_HASH,D100_FORMAT)

p d100_tweet.last_hash_tweet?
