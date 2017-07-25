defmodule TwitterBot.Say do
  def hello do
    "Hello, I'm a bot! You can get more info here -> https://goo.gl/43QtLY"
  end

  def joke do
    {:ok, %HTTPoison.Response{status_code: 200, body: body}} = HTTPoison.get("https://icanhazdadjoke.com/", "User-Agent": "My Library (https://github.com/matthewsecrist/TwitterBot)", "Accept": "Application/json")
    response = Poison.decode!(body)

    response["joke"]
  end
end
