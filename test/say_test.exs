defmodule SayTest do
  use ExUnit.Case
  alias TwitterBot.Say

  test "say hello gives an introduction" do
    assert Say.hello == "Hello, I'm a bot! You can get more info here -> https://goo.gl/43QtLY"
  end
end
