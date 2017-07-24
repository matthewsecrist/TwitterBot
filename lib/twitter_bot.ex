defmodule TwitterBot do
  @handle "SupprtBot"
  @moduledoc """
  Documentation for TwitterBot.
  """

  @doc """
  Start the twitter bot listening to the stream.

  """
  def start do
    IO.puts "Starting Bot.."
    stream = ExTwitter.stream_filter(track: @handle)
    for message <- stream do
      case message do
        tweet = %ExTwitter.Model.Tweet{} ->
          tweet
          |> parsed_tweet
          |> ExTwitter.update

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
    |> String.replace("#{@handle} ", "")
    |> TwitterBot.Ai.fetch

    "@#{tweet.user.screen_name} - #{text}"
  end
end
