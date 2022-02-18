defmodule Mix.Tasks.Tutor do
  use Mix.Task

  def run(_) do
    ElixirTutor.Loop.call()
  end
end
