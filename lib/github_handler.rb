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
        user =  @githubins.user(GITLOG)
        repos = user.rels[:repos].get.data
        git_hash =  @githubins.contents repos[-1].full_name, path:FILEPATH
        puts Base64.decode64(git_hash.content)
        #pp repos
    end

private
    def github_api_init
        return Octokit::Client.new(:login => GITLOG, :password => GITPASS)
    end
end


