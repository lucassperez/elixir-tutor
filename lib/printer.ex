defmodule ElixirTutor.Print do
  def compiling(filename) do
    IO.puts("Compiling #{filename}\n")
  end

  def failed_to_compile(filename) do
    IO.puts(
      "\e[1;35m#{filename}\e[0;35m failed to compile ):\e[0m\n\n" <>
        "#{separator_bar_string()}"
    )
  end

  def successfully_compiled(filename) do
    IO.puts(
      "\e[32mCongratulations, the file\n\e[1m#{filename}\e[0;32m\n" <>
        "compiled successfully!\e[0m\n"
    )
  end

  def delete_unfinished_comment_to_proceed do
    IO.puts(
      "To go to the next exercise, delete in the file all ocurrences of " <>
        "the string\n" <>
        "\e[1m# EXERCISE NOT FINISHED YET\e[0m\n"
    )
  end

  def all_files_finished do
    IO.puts("\e[32;1mAll files finished!\e[0m")
  end

  def unexpected_error do
    IO.puts("Something weird happened 🤔")
  end

  defp separator_bar_string do
    "#{Calendar.strftime(DateTime.utc_now(), "%y/%m/%d-%H:%M:%S")} " <>
      "=============================================\n"
  end
end
