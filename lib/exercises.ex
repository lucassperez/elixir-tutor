defmodule ElixirTutor.Exercises do
  def all_files do
    [
      Path.absname("exercises/teoria1.exs"),
      Path.absname("exercises/teoria2.exs"),
      Path.absname("exercises/teoria3.exs")
    ]
  end
end
