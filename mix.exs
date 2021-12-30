defmodule ElixirTutor.MixProject do
  use Mix.Project

  def project do
    [
      app: :elixir_tutor,
      version: "0.1.0",
      elixir: "~> 1.12",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger, :fs]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:fs, github: "synrc/fs"},
      {:file_system, "~> 0.2"}
    ]
  end
end