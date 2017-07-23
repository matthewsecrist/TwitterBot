defmodule TwitterBot do
  @moduledoc """
  Documentation for TwitterBot.
  """

  @doc """
  Hello world.

  ## Examples

      iex> TwitterBot.hello
      :world

  """
  def hello do
    stream = ExTwitter.stream_filter(track: "@_mattsecrist")
    for message <- stream do
      case message do
        tweet = %ExTwitter.Model.Tweet{} ->
          IO.inspect tweet

        limit = %ExTwitter.Model.Limit{} ->
          IO.puts "limit = #{limit.track}"
          
        _ ->
          IO.inspect message
      end
    end
  end
end
