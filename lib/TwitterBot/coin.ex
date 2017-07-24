defmodule TwitterBot.Coin do
  def flip do
    case :rand.uniform(2) do
      1 -> "I flipped a coin for you and its Heads."
      2 -> "I flipped a coin for you and its Tails"
    end
  end
end
