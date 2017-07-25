# TwitterBot
[![Build Status](https://travis-ci.org/matthewsecrist/TwitterBot.svg?branch=master)](https://travis-ci.org/matthewsecrist/TwitterBot)

TwitterBot is a bot built using Elixir. Its aim is to use Wit.ai's language processing to determine the intent of a tweet, and then respond appropriately.

Follow it at [@SupprtBot](https://twitter.com/SupprtBot).

---

Examples of questions you can ask at the moment:
```
@SupprtBot what is the weather in Chicago?
```
SupprtBot will respond with the current temperature in Chicago.

```
@SupprtBot roll a die
```
SupportBot will roll one 6 sided die for you.

```
@SupprtBot flip a coin
```
SupprtBot will flip a coin.


```
@SupprtBot hello
```
SupprtBot will say hello back and provide a link to this repository.

```
@SupprtBot tell me a joke
```
SupprtBot will respond with a joke from the [icanhazdadjoke api](https://icanhazdadjoke.com/api).

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
