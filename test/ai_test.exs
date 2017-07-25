defmodule AiTest do
  use ExUnit.Case
  alias TwitterBot.Ai

  doctest TwitterBot

  test "passing 'hello' to fetch calls Say.hello" do
    assert Ai.fetch("hello") == TwitterBot.Say.hello
  end

  test "passing 'flip a coin' to fetch calls coin_flip" do
    result = Ai.fetch("flip a coin")
    assert Regex.match?(~r/flipped a coin/, result)
  end

  test "passing 'roll a dice' to fetch calls roll_dice" do
    result = Ai.fetch("roll a dice")
    assert Regex.match?(~r/rolled a 6-sided die/, result)
  end
end
