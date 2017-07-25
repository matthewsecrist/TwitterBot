defmodule TwitterBot.Coin do
  @moduledoc """
  Module for working with coins.
  """

  @doc """
  Flips a coin by getting a random number between 1 and 2. Then based on that, returns either heads or tails.
  """
  def flip do
    case :rand.uniform(2) do
      1 -> "I flipped a coin for you and its Heads."
      2 -> "I flipped a coin for you and its Tails"
    end
  end
end
