defmodule TwitterBot.Weather do
  @moduledoc """
  Documentation for TwitterBot.Weather
  """

  @apikey Application.get_env(:twitter_bot, :openweathermap_key)

  @doc """
  Gets the weather for a location by creating a url, querying the openweathermap api
  and then transforming it to Fahrenheit. It then responds with a string for TwitterBot
  to tweet.
  """
  def for(location) do
    result = url_for(location)
    |> HTTPoison.get
    |> parse_response

    case result do
      {:ok, temp} ->
        "In #{location} it is currently #{temp} F"
      {:error, _} ->
        "#{location} not found"
    end
  end

  defp url_for(location) do
    "http://api.openweathermap.org/data/2.5/weather?q=#{location}&appid=#{@apikey}"
  end

  defp parse_response({:ok, %HTTPoison.Response{body: body}}) do
    body
    |> Poison.decode!
    |> compute_temperature
  end
  defp parse_response(_), do: {:error, "Error"}

  defp compute_temperature(json) do
    temp = ((json["main"]["temp"] - 273.15) * 9/5 + 32) |> Float.round(1)
    {:ok, temp}
  end
end
