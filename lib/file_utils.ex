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
  Returns a list of the first files following the order in
  ElixirTutor.Exercises.all_files/0 which does not have the string
  "# EXERCISE NOT FINISHED YET" and could compile without errors.
  It returns {:ok, list} or {:error, :not_found} when there are no such files.
  It stops looking the moment it finds a file that is not finished or is not
  compilable. That means if file 1 is finished, file 2 is not finished and file
  3 is finished, it is going to return only file 1, because the moment it found
  out file 2 is not finished, it stopped looking.
  This function kinda sucks, because when we try to compile files, they get
  executed and the IEx screen is cleared for each one of them.
  """
  def first_finished_and_compilable_files do
    Exercises.all_files()
    |> Enum.reduce_while([], fn filename, acc ->
      with false <- file_has_unfinished_comment?(filename),
           {:ok, _} <- try_to_compile(filename) do
        {:cont, [filename | acc]}
      else
        _ ->
          {:halt, acc}
      end
    end)
    |> case do
      [] -> {:error, :not_found}
      list -> {:ok, list}
    end
  end

  @doc """
  Returns true or false indicating if a given file has the string
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

  defp search_unfinished_comment(""), do: false

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
