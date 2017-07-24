defmodule TwitterBot.Weather do
  @apikey Application.get_env(:twitter_bot, :openweathermap_key)

  def for([location]) do
    result = url_for(location)
    |> HTTPoison.get
    |> parse_response

    case result do
      {:ok, temp} ->
        "In #{location} it is currently #{temp} F"
      :error ->
        "#{location} not found"
    end
  end

  defp url_for(location) do
    location = URI.encode(location)
    "http://api.openweathermap.org/data/2.5/weather?q=#{location}&appid=#{@apikey}"
  end

  defp parse_response({:ok, %HTTPoison.Response{body: body}}) do
    body |> Poison.decode! |> compute_temperature
  end

  defp parse_response(_), do: :error

  defp compute_temperature(json) do
    try do
      temp = ((json["main"]["temp"] - 273.15) * 9/5 + 32) |> Float.round(1)
      {:ok, temp}
    rescue
      _ -> :error
    end
  end
end
