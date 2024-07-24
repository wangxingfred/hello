defmodule Mage.MixProject do
  use Mix.Project

  def project do
    [
      app: :hello_elixir,
      version: "0.1.0",
      elixir: "~> 1.10",
      # Mix.env() == :prod,
      start_permanent: false,
      deps: deps(),
      aliases: aliases()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger],
      mod: {Hello.Application, []}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      # {:dep_from_hexpm, "~> 0.3.0"},
      # {:dep_from_git, git: "https://github.com/elixir-lang/my_dep.git", tag: "0.1.0"}
      #            {:bson, "~> 0.4.3"}
      #            {:xprof, "~> 2.0.0-rc.4"},
      {:benchee, "~> 1.1"},
      {:benchee_html, "~> 1.0"},
      {:beam_file, git: "https://github.com/hrzndhrn/beam_file"}
      #      {:maxo_decompile, git: "https://github.com/maxohq/maxo_decompile"}
      #      {:decompile, git: "https://github.com/michalmuskala/decompile"}
    ]
  end

  defp aliases do
    [
      c: "compile"
    ]
  end
end
