defmodule ElixirTutor.Compiler do
  def compile(filename, opts \\ [])

  # TODO always use --warning-as-erros?
  def compile(filename, opts) do
    {msg, exit_code} = System.cmd("elixirc", opts ++ [filename])
    {msg, exit_code}
  end
end
