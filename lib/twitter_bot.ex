defmodule TwitterBot do
  @moduledoc """
  Documentation for TwitterBot.
  """

  @doc """
  Start the twitter bot listening to the stream.

  """
  def start do
    IO.puts "Starting Bot.."
    stream = ExTwitter.stream_filter(track: "@_mattsecrist")
    for message <- stream do
      case message do
        tweet = %ExTwitter.Model.Tweet{} ->
          tweet
          |> parsed_tweet
          |> IO.inspect

          IO.puts "Responded to tweet!"

        limit = %ExTwitter.Model.Limit{} ->
          IO.puts "limit = #{limit.track}"

        _ ->
          IO.inspect message
      end
    end
  end

  def parsed_tweet(tweet) do
    text = tweet.text
    |> String.replace("@_mattsecrist ", "")
    |> TwitterBot.Ai.fetch

    "@#{tweet.user.screen_name} - #{text}"
  end
end
