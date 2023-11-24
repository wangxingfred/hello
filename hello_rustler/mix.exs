defmodule HelloRustler.MixProject do
    use Mix.Project

    def project do
        [
            app: :hello_rustler,
            version: "0.1.0",
            elixir: "~> 1.15",
            start_permanent: Mix.env() == :prod,
            deps: deps(),

            compilers: Mix.compilers(),
        ]
    end

    # Run "mix help compile.app" to learn about applications.
    def application do
        [
            extra_applications: [:logger]
        ]
    end

    # Run "mix help deps" to learn about dependencies.
    defp deps do
        [
            # {:dep_from_hexpm, "~> 0.3.0"},
            # {:dep_from_git, git: "https://github.com/elixir-lang/my_dep.git", tag: "0.1.0"}

            #            {:rustler, "~> 0.21.1"}
            #            {:benchee, "~> 1.0", only: [:dev]},
            #            {:benchee_html, "~> 1.0", only: [:dev]},

            #      {:rustler, github: "hansihe/rustler", sparse: "rustler_mix"},
            {:rustler, "~> 0.30.0"},
            {:benchee, "~> 1.1"},
            {:benchee_html, "~> 1.0"},
        ]
    end
end
