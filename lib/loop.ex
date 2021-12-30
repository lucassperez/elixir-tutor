defmodule ElixirTutor.Loop do
  alias ElixirTutor.{FileUtils, Print}

  def call do
    FileSystem.start_link(dirs: [Path.absname("exercises/")], name: :tutor)
    FileSystem.subscribe(:tutor)

    FileUtils.first_unfinished_file()
    |> handle_file()
    |> compile_pipeline()
  end

  defp handle_file({:ok, filename}), do: filename
  defp handle_file({:error, :not_found}), do: files_finished()

  defp compile_pipeline(filename) do
    filename
    |> FileUtils.try_to_compile()
    |> handle_compilation()
  end

  defp handle_compilation({:ok, filename}) do
    Print.successfully_compiled(filename)

    # Should stay in the same place untill comment is removed
    if FileUtils.file_has_unfinished_comment?(filename) do
      Print.delete_unfinished_comment_to_proceed()
      listen({:ok, filename})
      # Should go to next exercise
    else
      FileUtils.first_unfinished_file()
      |> handle_file()
      |> compile_pipeline()
    end
  end

  defp handle_compilation({:error, {_error, filename}}) do
    Print.failed_to_compile(filename)
    listen({:ok, filename})
  end

  defp listen({:ok, filename}) do
    receive do
      {:file_event, _worker_pid, {^filename, events}} ->
        IO.puts("\e[36mDEBUG: \e[1m#{filename} with events: #{inspect(events)}\e[0m")
        IO.puts("\e[36mDEBUG: \e[1m#{inspect(Process.info(self(), :messages))}\e[0m")
        read_all_messages(self())
        compile_pipeline(filename)

      {:file_event, _worker_pid, {other_filename, _events}} ->
        read_all_messages(self())

        case FileUtils.first_unfinished_file() do
          {:ok, ^other_filename} ->
            compile_pipeline(other_filename)

          {:ok, _different_file_that_should_be_ignored} ->
            listen({:ok, filename})

          {:error, :not_found} ->
            files_finished()
        end

      x ->
        Print.unexpected_error()
        inspect(x)
    end
  end

  defp files_finished do
    Print.all_files_finished()
  end

  defp read_all_messages(pid) do
    case Process.info(pid, :messages) do
      {:messages, []} ->
        :ok

      {:messages, _} ->
        receive do
          _ -> read_all_messages(pid)
        end
    end
  end
end
