defmodule ElixirTutor.FileUtils do
  alias ElixirTutor.Exercises

  @doc """
  Returns the first file, following ElixirTutor.Exercises.all_files/0's order,
  that does not contain the string "# EXERCISE NOT FINISHED YET".
  It returns {:ok, filename} if there is such a file,
  and {:error, :not_found} otherwise.
  """
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

  @doc """
  Returns a list with all the files without the string
  "# EXERCISE NOT FINISHED YET", following the order defined in
  ElixirTutor.Exercises.all_files/0.
  It returns {:ok, list} or {:error, :not_found} when there are no such files.
  """
  def all_unfinished_files do
    Exercises.all_files()
    |> Enum.filter(&file_has_unfinished_comment?/1)
    |> case do
      [] -> {:error, :not_found}
      list -> {:ok, list}
    end
  end

  @doc """
  Returns a true or false indicating if a given file has the string
  "# EXERCISE NOT FINISHED YET"
  """
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

  @doc """
  Tries to compile a given file.
  If successful, returns {:ok, filename}.
  If not, returns {:error, {%CompileError{}, filename}}
  """
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
