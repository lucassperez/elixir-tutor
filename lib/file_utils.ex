defmodule ElixirTutor.FileUtils do
  alias ElixirTutor.Exercises

  def first_unfinished_file do
    Exercises.all_files()
    |> Enum.reduce_while(nil, fn filename, _acc ->
      if file_has_unfinished_comment?(filename) do
        {:halt, {:ok, filename}}
      else
        {:cont, {:error, :not_found}}
      end
    end)
  end

  def all_unfinished_files do
    Exercises.all_files()
    |> Enum.filter(&file_has_unfinished_comment?/1)
    |> case do
      [] -> {:error, :not_found}
      list -> {:ok, list}
    end
  end

  def file_has_unfinished_comment?(filename) do
    filename
    |> File.read!()
    |> search_unfinished_comment()
  end

  defp search_unfinished_comment("# EXERCISE NOT FINISHED YET" <> _rest) do
    true
  end

  defp search_unfinished_comment(<<_c::binary-size(1)>> <> rest) do
    search_unfinished_comment(rest)
  end

  defp search_unfinished_comment(""), do: nil

  def try_to_compile(filename) do
    try do
      IEx.Helpers.clear()
      ElixirTutor.Print.compiling(filename)
      IEx.Helpers.c(filename)
      {:ok, filename}
    catch
      # TODO understand while compile error is always like this:
      # %CompileError{description: "compile error", file: nil, line: nil}
      :error, %CompileError{} = error -> {:error, {error, filename}}
    end
  end
end
