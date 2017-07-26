defmodule TwitterBot.Say do
  @moduledoc """
  Module for working with things the bot can say.
  """
  @dadjokeapi_headers ["User-Agent": "TwitterBot (https://github.com/matthewsecrist/TwitterBot)", "Accept": "Application/json"]
  @doc """
  Hello responds with a bit of information about the bot itself.
  """
  def hello do
    "Hello, I'm a bot! You can get more info here -> https://goo.gl/43QtLY"
  end

  @doc """
  Tells a random joke from the icanhazdadjoke API.
  """
  def joke do
    response = HTTPoison.get("https://icanhazdadjoke.com/", @dadjokeapi_headers)
    |> parse_response

    case response do
      {:ok, {:ok, body}} ->
        body["joke"]
      _ ->
        "I can't think of anything."
    end
  end

  defp parse_response({:ok, %HTTPoison.Response{status_code: 200, body: body}}) do
    {:ok, Poison.decode(body)}
  end
  defp parse_response({:error, reason}), do: {:error, reason}
end
