require './lib/github_handler.rb'
require 'time'

RSpec.describe GithubHandler do
  let(:github_test) { GithubHandler.new }
  let(:test_regexp) { /[R](\d+)[D](\d+)/ }

  describe '#Readout github specified account' do
    it 'passes if searching object is a regexp' do
      # time_window = Time.now - Time.parse(lot_ok[3])
      expect(github_test.read_100dfile(test_regexp)[2]).not_to eql('no-regex')
    end

    it 'passes if searching object is not a regexp' do
      # time_window = Time.now - Time.parse(lot_ok[3])
      expect(github_test.read_100dfile('bad input')[2]).to eql('no-regex')
    end
  end
end
