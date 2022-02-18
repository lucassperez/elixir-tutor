defmodule ElixirTutor.CompileMessageParser do
  def compile_message(message) do
    ~r/\e\[[0-9;m]*Tutor> .*\n/
    |> Regex.replace(message, "")
    |> String.trim()
  end
end
