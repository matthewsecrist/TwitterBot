# TwitterBot
[![Build Status](https://travis-ci.org/matthewsecrist/TwitterBot.svg?branch=master)](https://travis-ci.org/matthewsecrist/TwitterBot)

TwitterBot is a bot built using Elixir. Its aim is to use Wit.ai's language processing to determine the intent of a tweet, and then respond appropriately. Currently it can tell the current temperature of a city.

Follow it at [@SupprtBot](https://twitter.com/SupprtBot).

---

Want to run your own? Clone the repository, and create a .env file like this:

```
export CONSUMER_KEY=<twitter consumer key>
export CONSUMER_SECRET=<twitter consumer secret>
export ACCESS_TOKEN=<twitter access token>
export ACCESS_SECRET=<twitter access secret>
export OPENWEATHER_API_KEY=<openweather api key>
export WIT_KEY=<wit.api key>
```

Then in lib/twitter_bot.ex modify the @handle to be your bot's name.

After that, run it: mix run -e TwitterBot.start
