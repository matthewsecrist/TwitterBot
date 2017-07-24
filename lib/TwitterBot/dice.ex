defmodule TwitterBot.Dice do
  def roll do
    val = :rand.uniform(6)

    "I rolled a 6-sided-die for you and its a #{val}"
  end
end
