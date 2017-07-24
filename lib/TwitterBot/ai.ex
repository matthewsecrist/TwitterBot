defmodule TwitterBot.Ai do
  @headers ["Authorization": "Bearer #{Application.get_env(:twitter_bot, :wit_key)}", "Accept": "Application/json; Charset=utf-8"]
  @doc """
    fetch(user, project) to contact the github API and then handle the response.
  """
  def fetch(text) do
    text
    |> String.replace(" ", "%20")
    |> wit_url
    |> HTTPoison.get(@headers)
    |> handle_response
    |> decode_response
  end

  # Returns the Issues URL
  def wit_url(text) do
    "https://api.wit.ai/message?v=20170723&q='#{text}'"
  end

  def handle_response({:ok, %HTTPoison.Response{status_code: 200, body: body}}) do
    {:ok, Poison.decode!(body)}
  end

  def handle_response({:ok, %HTTPoison.Response{status_code: 404}}) do
   IO.puts "Not Found :("
  end

  def handle_response({:error, %HTTPoison.Error{reason: reason}}) do
    IO.inspect reason
  end

  def decode_response({:ok, body}) do
    [value] = body["entities"]["intent"]
    |> Enum.map(fn x -> x["value"] end)

    case value do
      "temperature_get" ->
        body["entities"]["location"]
        |> Enum.map(fn x -> x["value"] end)
        |> TwitterBot.Weather.for


      _ ->
        IO.puts "Don't know how to respond."
    end
  end
end
