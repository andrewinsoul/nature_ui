defmodule NatureUITest do
  use ExUnit.Case
  doctest NatureUI

  test "greets the world" do
    assert NatureUI.hello() == :world
  end
end
