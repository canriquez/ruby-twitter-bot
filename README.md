# Microverse's Ruby Capstone Project - ruby-twitter-bot

> This project consists of building a twitter bot that sends daily updates of my 100 days of code progress. It should be able to help me remember to commit updates on my 100-Days-of-code Github repository while simplifying my twitting workflow to publish my progress.

![screenshot](./img/git_ruby-twitter-bot.gif)


## Project's Video Presentation

[Lagarbot - ruby-twitter-bot ](https://www.loom.com/share/99420eb2648c423bb910aff5bde6e0b2)


# This project delivers on the following basic specifications
- When locally executed, the program checks a specified twitter account and repo to verify the update status.
- Reads through a detailed file inside the GitHub user's fork of 100-days-of-code: https://github.com/carlosmicro/100-days-of-code
- Checks for the '**Twitter:RXDYY' mark in the repo's record to identify a valid update.
- For the specified user, It checks the correct repo update against the last update available on twitter. 
- If the repo update is ahead of the twitter account, it will tweet the specified update automatically. 
- If no valid message content updated is available on the repository, it will compile a report message.
- In the rare case that twitter is ahead of the GitHub repository file, the bot gives a console message. Next release feature: Bot updates the GitHub repository to match the updates.
- At the end of execution, the bot will send a detailed report of all performed actions to a specified email account.


## Built With

- Ruby, HTML
- Rubocop, Stickler, Rspec
- VS Code

## Getting Started

To get a local copy up and running, follow these simple example steps.

### Prerequisites
To deploy a fully functional local copy, you must install the following dependencies/libraries: 
- [Twitter API Gem:](https://github.com/sferik/twitter) Managing Twitter search and Twitter updates (tweets)
- [Octokit Github Api Gem:](https://github.com/octokit/octokit.rb) Wrapper used to interact with github.com
- [Pony Gem:](https://github.com/benprew/pony) Used for email handling.

### Setup
- Clone this repository in your local environment
- Located on the root of repository execute 

 ```bundle install``` 
 
 This action will install all the required dependencies. 

 See the details below to modify and include all your access keys and values in the root file  .env 
 
 
## Configure main variables 

- Configure at the ```.env``` file your twitter handler and searching hash (Ideally this should be your user and 100-Days-of-code hash)

```ruby
# Main variables - Change this to adjust the searching handler and searching hash

export CONFIG_USER=<@your-own-user-handler>
export CONFIG_TWEET_HASH=#100daysofCode
```

### Configure Twitter API Gem

- Configure at the ```.env``` file your twitter development account and consumer/access key/secret/tokens.

```For Twitter: Crete a developer's account and generate the following keys```

[Link for Twitter development account creation](https://developer.twitter.com/en/apply-for-access)

```ruby
    # Twitter access values for tester_carlos account
    export CONFIG_CONSUMER_KEY=<your own keys>
    export CONFIG_CONSUMER_SECRET=<your own keys>
    export CONFIG_ACCESS_TOKEN=<your own keys>
    export CONFIG_ACCESS_TOCKEN_SECRET =<your own keys>
```

### Configure Octokit

- Configure at the ```.env``` file your octokit access constants for your GitHub account


```ruby
# Octokit Access Constants
export GITLOG=<github_user>
export GITPASS=<account password
export GITREPO=<github_user>/<repo name>
export FILEPATH=/<file_name_at_root>
```
### Install and Pony email gem

- Configure at the ```.env``` file your pony email access constants.

```For pony email, SMTP email server is configured in lib/robo_duties.rb file```

```ruby
# email - Gmail account data
export EMAIL_LOGIN=<your own login>
export EMAIL_PASS=<your own pass>
```
```ruby
# Current SMTP email parameters are defined for GMAIL. Change them to your requirement.
    def mail_init(message)
    { to: '<your own email address>',
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
- To start the program, run ```bin/./main.rb``` at the root of your repositories local copy

### Run tests
- Assuming EnviVars are correctly defined, login into the update file https://github.com/carlosmicro/100-days-of-code/blob/master/r1-log.md
- Login into the twitter test account and erase all the tweets.
- Execute the bot ```bin/./main.rb```
- The local prompt should show the following response:

```carlos@Carloss-MBP ruby-twitter-bot % bin/./main.rb 
checking last tweet update on #100daysofCodeTest for handle: @tester_carlos
failing to get a valid tweet published with #100daysofCodeTest hash... for user @tester_carlos
building into report to @tester_carlos 
checking github @carlosmicro/100-days-of-code
getting : R1D14 - 'R1D14.Worked in final details of LagarBot...'
twitting available update in repo R1D14.
email sent
```
- Soon after this prompt is received, the twitter account should update to:

![screenshot](./img/tweet-success.png)

### Deployment

For further testing purposes, this bot could be deployed in a small server like raspberry pi 3. 

In this server, a cronjob could be defined to execute the ```lagarbot``` program every 24 hs, to ensure a daily check of progress updates to the #100-days-of-code community. 


## Authors

👤 Carlos Anriquez

- Github: [@canriquez](https://github.com/canriquez)
- Twitter: [@cranriquez](https://twitter.com/cranriquez)
- Linkedin: [linkedin](https://www.linkedin.com/in/carlosanriquez/)


## 🤝 Contributing

Contributions, issues, and feature requests are welcome!

Feel free to check the [issues page](issues/).

## Show your support

Give a ⭐️ if you like this project!

## Acknowledgments

- [Twitter API Gem](https://github.com/sferik/twitter) 
- [Octokit Github Api Gem](https://github.com/octokit/octokit.rb) 
- [Pony Gem](https://github.com/benprew/pony)
- @microverse / The Corgis
- My Family!

## 📝 License

This project is [MIT](./LICENSE) licensed.
