require 'github_api'
require 'octokit'
require 'base64'
require 'pp'
require_relative "../secret/key.rb"


class GithubHandler
    include EnviVars

    def initialize
        @githubins = github_api_init
        @file_data = ''

    end

    def read_100dfile
        #user =  @githubins.user(GITLOG)
        repos = @githubins.user(GITLOG).rels[:repos].get.data
        git_hash =  @githubins.contents repos[-1].full_name, path:FILEPATH
        text_file =  Base64.decode64(git_hash.content).match(D100_TWITT_MATCH)
        return text_file.nil? ? false : text_file[2],text_file[3],text_file[1]
    end

private
    def github_api_init
        return Octokit::Client.new(:login => GITLOG, :password => GITPASS)
    end
end


