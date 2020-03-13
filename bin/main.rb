#!/usr/bin/ruby
# rubocop:disable Layout/LineLength, Style/IdenticalConditionalBranches
require 'dotenv/load'
require 'pony'
require 'time'
require_relative '../lib/twitter_handler.rb'
require_relative '../lib/github_handler.rb'
require_relative '../lib/robo_duties.rb'

D100_FORMAT = /[R](\d+)[D](\d+)/.freeze
D100_TWITT_MATCH = /^\*\*Twitter\:.*([R](\d)+[D](\d+).*\#100DaysOfCodeTest)/.freeze

robot = RoboDuties.new
d100_tweet = TwitterHandler.new(ENV["CONFIG_USER"], ENV["TWEET_HASH"], D100_FORMAT)
d100_github = GithubHandler.new

html_message = "<h2> LagarBot Activity report for #{Time.now.strftime('%d/%m/%Y %H:%M:%S')} </h2>"
html_message += '<ul>'

html_message, prompt = robot.build_mail(html_message, "checking last tweet update on #{ENV["TWEET_HASH"]} for handle : #{ENV["CONFIG_USER"]}")
puts prompt

last_on_twitter = d100_tweet.last_hash_tweet? # Test if 'last' has been twited for my user.

if !last_on_twitter[0].nil?
  html_message, prompt = robot.build_mail(html_message, "getting : R#{last_on_twitter[0]}D#{last_on_twitter[1]} - '#{last_on_twitter[2][0..40]}...' - created : #{last_on_twitter[3]}")
  puts prompt
  html_message, prompt = robot.build_mail(html_message, "last tweet update is from #{d100_tweet.days_old?(last_on_twitter[3])} hours ago.")
  puts prompt
else
  html_message, prompt = robot.build_mail(html_message, "failing to get a valid tweet publishd with #{ENV["TWEET_HASH"]} hash... for user #{ENV["CONFIG_USER"]}")
  puts prompt
  html_message, prompt = robot.build_mail(html_message, "building into report to #{ENV["CONFIG_USER"]} ")
  puts prompt
end

html_message, prompt = robot.build_mail(html_message, "checking github @#{d100_github.gitrepo}")
puts prompt

last_on_repo = d100_github.read_100dfile(D100_TWITT_MATCH)

if !last_on_repo.nil?
  html_message, prompt = robot.build_mail(html_message, "getting : R#{last_on_repo[0]}D#{last_on_repo[1]} - '#{last_on_repo[2][0..40]}...'")
  puts prompt
else
  html_message, prompt = robot.build_mail(html_message, "failing to get a valid record on repo #{d100_github.gitrepo} ...")
  puts prompt
  html_message, prompt = robot.build_mail(html_message, "building into report to #{ENV["CONFIG_USER"]}  ")
  puts prompt
end

# Check if repo and tweet update are the same, handle different options

compare = robot.compare_updates(last_on_twitter, last_on_repo)
if compare[0] == true && compare[1] <= 24
  html_message, prompt = robot.build_mail(html_message, 'everything looks up to date. Have a good day!')
  puts prompt
elsif compare[0] == false && (compare[2]).negative?
  html_message, prompt = robot.build_mail(html_message, "twitting available update in repo R#{last_on_repo[0]}D#{last_on_repo[1]}.")
  puts prompt
  puts "#{last_on_repo[2]} : results : #{d100_tweet.send_100dc_tweet(last_on_repo[2])}" # sending tweet
elsif compare[0] == true && compare[1] > 24
  html_message, prompt = robot.build_mail(html_message, "every update is published but last update has #{compare[1]/24} days old. Consider writing new update in repo")
  puts prompt
elsif compare[0] == false && (compare[2]).positive?
  html_message, prompt = robot.build_mail(html_message, "Something is wrong. your twitter account (R#{last_on_twitter[0]}D#{last_on_twitter[1]}) is ahead of repo (R#{last_on_repo[0]}D#{last_on_repo[1]}).")
  puts prompt
  html_message, prompt = robot.build_mail(html_message, 'consider commiting last twitter record on repo.')
  puts prompt
end

puts robot.send_mail(html_message + '</ul>')
# rubocop:enable Layout/LineLength, Style/IdenticalConditionalBranches
