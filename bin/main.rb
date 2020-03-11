#!/usr/bin/ruby
# rubocop:disable Layout/LineLength
require 'pony'
require 'time'
require_relative '../lib/twitter_handler.rb'
require_relative '../lib/github_handler.rb'
require_relative '../lib/robo_duties.rb'

USER = '@tester_carlos'.freeze
TWEET_HASH = '#100daysofCodeTest'.freeze # using #100daysofCodeTest to avoid spamming during tests
D100_FORMAT = /[R](\d+)[D](\d+)/.freeze
D100_TWITT_MATCH = /^\*\*Twitter\:([R](\d)+[D](\d+).*\#100DaysOfCodeTest)/.freeze
# Warning: Hash is REGEXP is a TEST (#100DaysOfCodeTest) to avoid spamming on tests

robot = RoboDuties.new
d100_tweet = TwitterHandler.new(USER, TWEET_HASH, D100_FORMAT)
d100_github = GithubHandler.new

html_message = "<h2> LagarBot Activity report for #{Time.now.strftime('%d/%m/%Y %H:%M:%S')} </h2>"
html_message += '<ul>'

html_message = robot.build_mail(html_message, "checking last tweet update on #{TWEET_HASH} for handle : #{USER}")

last_on_twitter = d100_tweet.last_hash_tweet? # Test if 'last' has been twited for my user.

if !last_on_twitter[0].nil?
  html_message = robot.build_mail(html_message, "getting : R#{last_on_twitter[0]}D#{last_on_twitter[1]} - '#{last_on_twitter[2][0..40]}...' - created : #{last_on_twitter[3]}")
  html_message = robot.build_mail(html_message, "last tweet update is from #{d100_tweet.days_old?(last_on_twitter[3])} hours ago.")
else
  html_message = robot.build_mail(html_message, "failing to get a valid tweet publishd with #{TWEET_HASH} hash... for user #{USER}")
  html_message = robot.build_mail(html_message, "building into report to #{USER} ")
end

html_message = robot.build_mail(html_message, "checking github @#{d100_github.gitrepo}")

last_on_repo = d100_github.read_100dfile

if !last_on_repo.nil?
  html_message = robot.build_mail(html_message, "getting : R#{last_on_repo[0]}D#{last_on_repo[1]} - '#{last_on_repo[2][0..40]}...'")
else
  html_message = robot.build_mail(html_message, "failing to get a valid record on repo #{d100_github.gitrepo} ...")
  html_message = robot.build_mail(html_message, "building into report to #{USER}  ")
end

# Check if repo and tweet update are the same, handle different options

compare = robot.compare_updates(last_on_twitter, last_on_repo)
if compare[0] == true && compare[1] <= 24
  html_message = robot.build_mail(html_message, 'everything looks up to date. Have a good day!')
elsif compare[0] == false && (compare[2]).negative?
  html_message = robot.build_mail(html_message, "twitting available update in repo R#{last_on_repo[0]}D#{last_on_repo[1]}.")
  d100_tweet.send_100dc_tweet(last_on_repo[2]) # sending tweet
elsif compare[0] == true && compare[1] > 24
  html_message = robot.build_mail(html_message, "every update is published but last update has #{compare[2]} days old. Consider writing new update in repo")
elsif compare[0] == false && (compare[2]).positive?
  html_message = robot.build_mail(html_message, "Something is wrong. your twitter account (R#{last_on_twitter[0]}D#{last_on_twitter[1]}) is ahead of repo (R#{last_on_repo[0]}D#{last_on_repo[1]}).")
  html_message = robot.build_mail(html_message, 'consider commiting last twitter record on repo.')
end

robot.send_mail(html_message + '</ul>')
# rubocop:enable Layout/LineLength
