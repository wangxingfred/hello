defmodule Mage.MixProject do
    use Mix.Project
    
    def project do
        [
            app: :hello_elixir,
            version: "0.1.0",
            elixir: "~> 1.10",
            start_permanent: false, # Mix.env() == :prod,
            deps: deps(),
            
            aliases: aliases(),
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
            {:xprof, "~> 2.0.0-rc.4"}
        ]
    end
    
    defp aliases do
        [
            c: "compile"
        ]
    end
end
