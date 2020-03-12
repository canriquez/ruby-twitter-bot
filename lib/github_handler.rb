require 'github_api'
require 'octokit'
require 'base64'
require 'pp'
require_relative '../secret/key.rb'

class GithubHandler
  include EnviVars
  attr_reader :gitrepo

  def initialize
    @githubins = github_api_init
    @file_data = ''
    @gitrepo = GITREPO
    @gitlog = GITLOG
    @filepath = FILEPATH
    #@d100_tw_match = d100twmatch
  end

  def read_100dfile(d100twmatch)
    return [false,'no-regex','no-regex'] unless d100twmatch.class == Regexp
    repos = @githubins.user(@gitlog).rels[:repos].get.data
    git_hash = @githubins.contents repos[-1].full_name, path: @filepath
    text_file = Base64.decode64(git_hash.content).match(d100twmatch)
    [text_file.nil? ? nil : text_file[2], text_file[3], text_file[1]]
  end

  private

  def github_api_init
    Octokit::Client.new(login: GITLOG, password: GITPASS)
  end
end
