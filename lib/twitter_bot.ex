defmodule TwitterBot do
  @handle "@SupprtBot"
  @moduledoc """
  Documentation for TwitterBot.
  """

  @doc """
  Start the twitter bot listening to the stream.
  """
  def start do
    IO.puts "Starting Bot.."

    # Only track mentions
    stream = ExTwitter.stream_filter(track: @handle)
    for message <- stream do
      case message do
        # Check to see if the message is a tweet
        tweet = %ExTwitter.Model.Tweet{} ->

          text = tweet
          |> parsed_tweet
          |> TwitterBot.Ai.fetch

          ExTwitter.update("@#{tweet.user.screen_name} - #{text}")

          IO.puts "Responded to tweet!"

        limit = %ExTwitter.Model.Limit{} ->
          IO.puts "limit = #{limit.track}"

        _ ->
          IO.inspect message
      end
    end
  end

  @doc """
  Takes the tweet and removes the mention and trailing space.
  """
  def parsed_tweet(tweet) do
    tweet.text
    |> String.replace("#{@handle} ", "")
  end
end
