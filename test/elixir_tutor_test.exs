defmodule ElixirTutorTest do
  use ExUnit.Case
  doctest ElixirTutor

  test "greets the world" do
    assert ElixirTutor.hello() == :world
  end
end
