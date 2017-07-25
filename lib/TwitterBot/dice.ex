defmodule TwitterBot.Dice do
  @moduledoc """
  Module for working with Dice.
  """

  @doc """
  Rolls a die by returning a number 1-6
  """
  def roll do
    val = :rand.uniform(6)

    "I rolled a 6-sided-die for you and its a #{val}"
  end
end
