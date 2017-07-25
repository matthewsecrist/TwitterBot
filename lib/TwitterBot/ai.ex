defmodule TwitterBot.Ai do
  @moduledoc """
  The main AI for TwitterBot
  """
  @headers ["Authorization": "Bearer #{Application.get_env(:twitter_bot, :wit_key)}", "Accept": "Application/json; Charset=utf-8"]

  @doc """
  fetch takes in a string of text from the tweet. After that it replaces all spaces with %20
  and then produces a URL to query the Wit API and then passes it to Poision to handle, then
  off to decode_response which decides what to run.
  """
  def fetch(text) do
    text
    |> String.replace(" ", "%20")
    |> wit_url
    |> HTTPoison.get(@headers)
    |> handle_response
    |> decode_response
  end

  defp wit_url(text) do
    "https://api.wit.ai/message?v=20170723&q=#{text}"
  end

  defp handle_response({:ok, %HTTPoison.Response{status_code: 200, body: body}}) do
    Poison.decode!(body)
  end

#
#  Takes the response from Poison and grabs the intent value.
#  Once the intent is determined, it decides what to do with it.
#
  defp decode_response(body) do
# Wit returns a response something like:
#
# {:ok,
# %{"_text" => "'What is the weather like in Chicago?'",
#  "entities" => %{
#     "intent" => [%{"confidence" => 0.99563384734789, "value" => "temperature_get"}],
#     "location" => [%{"confidence" => 0.99706676119462, "suggested" => true, "type" => "value", "value" => "Chicago"}]},
#  "msg_id" => "0gX6xw1GNHnRToALG"}}
#
# So this grabs the intent from Entities > Intent > value.
# Once it determines the intent, it decides what to do with it.
# In the example above, it would find the intent is "temperature_get"
# and then based on that it would grab "Chicago" from
# location > value and pass it off to TwitterBot.Weather.for("Chicago")
#
# If no intent is found, it responds with "I don't know how to respond to that."
#
    intent = body["entities"]["intent"]
    |> determine_intent

    case intent do
      # Intent is to get the weather or temperature in a city.
      ["temperature_get"] ->
        [location] = body["entities"]["location"]
        |> Enum.map(fn x -> x["value"] end)

        TwitterBot.Weather.for(location)
      # Intent is to flip a coin.
      ["coin_flip"] ->
        TwitterBot.Coin.flip
      # Intent is to roll a die.
      ["roll_dice"] ->
        TwitterBot.Dice.roll
      # Intent is to say hello.
      ["say_hello"] ->
        TwitterBot.Say.hello
      # Intent is undefined.
      _ ->
        intent
    end
  end

  defp determine_intent(intent) when is_list(intent) do
    Enum.map(intent, fn x -> x["value"] end)
  end

  defp determine_intent(_intent) do
    "I don't know how to respond to that."
  end
end
