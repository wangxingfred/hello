defmodule HelloCowboy.MixProject do
    use Mix.Project

    def project do
        [
            app: :hello_cowboy,
            version: "0.1.0",
            elixir: "~> 1.13",
            start_permanent: Mix.env() == :prod,
            deps: deps()
        ]
    end

    # Run "mix help compile.app" to learn about applications.
    def application do
        [
            extra_applications: [:logger],
            mod: {HelloCowboy.Application, []}
        ]
    end

    # Run "mix help deps" to learn about dependencies.
    defp deps do
        [
            {:cowboy, "~> 2.9"},
            {:jason, "~> 1.3"}
            # {:dep_from_hexpm, "~> 0.3.0"},
            # {:dep_from_git, git: "https://github.com/elixir-lang/my_dep.git", tag: "0.1.0"}
        ]
    end
end
