# Microverse's Ruby Capstone Project - ruby-twitter-bot

> This project consists of building a twitter bot that sends daily updates of my 100 days of code progress. It should be able to help me to remember to commit updates on my 100-Days-of-code repo, and at the same time simplify my twitting actions to publish my progress.

![screenshot](./app_screenshot.png)

# This project delivers on following basic specifications
- When locally executed, the program checks a specified twitter account and repo to verify the update status.
- Reads through a specified file inside the github user's fork of 100-days-of-code: https://github.com/carlosmicro/100-days-of-code
- Checks for the '**Twitter:RXDYY' mark in the repo's record to identify a valid update.
- Checks the valid repo update agains the last update available on twitter for the specified user.
- If repo update is ahead of twitter account, it will tweet the specified update automatically. 
- If no valid message content updated is available on the repository it will compile a report message.
- At the end of execution, the bot will send a detailed report of all performed actions to a specified email account.


## Built With

- Ruby, HTML
- Rubocop, Stickler, Rspec
- VS Code

## Live Demo

[Live Demo Link](https://livedemo.com)


## Getting Started



**This is an example of how you may give instructions on setting up your project locally.**
**Modify this file to match your project, remove sections that don't apply. For example: delete the testing section if the correct project doesn't require testing.**


To get a local copy up and running follow these simple example steps.

### Prerequisites
To deploy a fully functional local copy, you must install the following gems/libraries: 
- Twitter API Gem: Managing Twitter search and Twitter updates (tweets)
- Octokit Github Api Gem: Wrapper used to interact with github.com
- Pony Gem: Used for email handling.

### Setup
- Clone this repository in your local enviroment

### Install and Configure Twitter API Gem
- Install Twitter API Gem via Rubygems
    
    ```gem install twitter```

- Configure (secret/key.rb) your own twitter development account and consumer/access key/secret/tokens.

```@microverse Code Reviewers: Temporary EnviVars are defined to simplify code functionality testing```

    ```ruby
    module EnviVars
        CONFIG_CONSUMER_KEY = 'YOUR OWN TWITTER DEV ACCOUNT DATA'.freeze
        CONFIG_CONSUMER_SECRET = 'YOUR OWN TWITTER DEV ACCOUNT DATA'.freeze
        CONFIG_ACCESS_TOKEN = 'YOUR OWN TWITTER DEV ACCOUNT DATA'.freeze
        CONFIG_ACCESS_TOCKEN_SECRET = 'YOUR OWN TWITTER DEV ACCOUNT DATA'.freeze
    ```
### Install and Configure Octokit
- Install via Rubygems
    ```gem install octokit```
- Configure (secret/key.rb) your own octokit access constants.

```@microverse Code Reviewers: Temporary EnviVars are defined to simplify code functionality testing```

    ```ruby
    # Octokit Access Constants
        GITLOG = 'YOUR OWN USER DATA'.freeze
        GITPASS = 'YOUR OWN PASS'.freeze
        GITLOGPASS = GITLOG + ':' + GITPASS
        GITREPO = 'OWN USER INFO/OWN REPO NAME INFO'.freeze
        FILEPATH = '/FILE NAME LOCATED IN REPO ROOT'.freeze
    ```
### Install and Pony email gem
- Install via Rubygems

    ```sudo gem install pony```

- Configure (secret/key.rb) your own pony email access constants.

```@microverse Code Reviewers: Temporary EnviVars are defined to simplify code functionality testing```
```For pony email, SMTP email server is configured in lib/robo_duties.rb file```

    ```ruby
    # email - gmail account data
        EMAIL_LOGIN = 'carlos.el.coder'.freeze
        EMAIL_PASS = 'microverse2020'.freeze
    ```
    ```ruby
        def mail_init(message)
        { to: 'YOUR OWN EMAIL',
        subject: '',
        headers: { 'Content-Type' => 'text/html' },
        body: " #{message}",
        via: :smtp, via_options: {
            address: 'smtp.gmail.com',
            port: '587',
            user_name: EMAIL_LOGIN,
            password: EMAIL_PASS,
            authentication: :plain,
            domain: 'gmail.com'
        } }
        end
    ```

### Usage

### Run tests

### Deployment



## Authors

👤 **Author1**

- Github: [@githubhandle](https://github.com/githubhandle)
- Twitter: [@twitterhandle](https://twitter.com/twitterhandle)
- Linkedin: [linkedin](https://linkedin.com/linkedinhandle)

👤 **Author2**

- Github: [@githubhandle](https://github.com/githubhandle)
- Twitter: [@twitterhandle](https://twitter.com/twitterhandle)
- Linkedin: [linkedin](https://linkedin.com/linkedinhandle)

## 🤝 Contributing

Contributions, issues and feature requests are welcome!

Feel free to check the [issues page](issues/).

## Show your support

Give a ⭐️ if you like this project!

## Acknowledgments

- Hat tip to anyone whose code was used
- Inspiration
- etc

## 📝 License

This project is [MIT](lic.url) licensed.
