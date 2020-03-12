require './lib/twitter_handler.rb'
require 'time'

RSpec.describe TwitterHandler do
  let(:regex) {/[R](\d+)[D](\d+)/}
  let(:tweet_test_ok) { TwitterHandler.new('@tester_carlos', '#100daysofCodeTest', regex) }
  let(:tweet_test_bad) { TwitterHandler.new('@tester_carlos', '#non-existing-hash-for-user', regex) }
  

  describe '#Testing last_hash_tweet? method to search for tweets' do
    it 'Passes if a positive search (#100daysofCodeTest) returns not a nil array: [nil, nil, nil, []]' do
      expect(tweet_test_ok.last_hash_tweet?).not_to eql([nil, nil, nil, []])
    end
    it 'Passes if a negative search (#non-existing-hash-for-user) returns nil array: [nil, nil, nil, []]' do
      expect(tweet_test_bad.last_hash_tweet?).to eql([nil, nil, nil, []])
    end
  end

  describe '#Testing send_100dc_tweet method - Sending Tweets' do
    it 'Passes if valid raw text is passed to the method' do
      expect(tweet_test_ok.send_100dc_tweet('valid text - test @text account only')).to eql(true)
    end
    it 'Passes if nil text is passed to the method' do
      expect(tweet_test_ok.send_100dc_tweet(nil)).to eql(false)
    end
  end

end

