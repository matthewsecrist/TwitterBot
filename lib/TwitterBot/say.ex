defmodule TwitterBot.Say do
  @moduledoc """
  Module for working with things the bot can say.
  """

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
    {:ok, %HTTPoison.Response{status_code: 200, body: body}} = HTTPoison.get("https://icanhazdadjoke.com/", "User-Agent": "My Library (https://github.com/matthewsecrist/TwitterBot)", "Accept": "Application/json")
    response = Poison.decode!(body)

    response["joke"]
  end
end
