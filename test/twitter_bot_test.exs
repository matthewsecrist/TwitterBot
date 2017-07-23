defmodule TwitterBotTest do
  use ExUnit.Case
  doctest TwitterBot

  test "parsed_tweet returns a tweet without the mention" do
    tweet = %{text: "@_mattsecrist hello world", user: %{screen_name: "testuser"}}
    assert TwitterBot.parsed_tweet(tweet) == "@testuser said hello world"
  end
end
