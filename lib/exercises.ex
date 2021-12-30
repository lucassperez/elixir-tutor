defmodule ElixirTutor.Exercises do
  def all_files do
    [
      Path.absname("exercises/pattern-matching/pattern-matching1.exs"),
      Path.absname("exercises/pattern-matching/pattern-matching2.exs"),
      Path.absname("exercises/pattern-matching/pattern-matching3.exs")
    ]
  end
end
