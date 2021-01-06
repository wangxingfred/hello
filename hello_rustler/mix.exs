defmodule HelloRustler.MixProject do
    use Mix.Project
    
    def project do
        [
            app: :hello_rustler,
            version: "0.1.0",
            elixir: "~> 1.10",
            start_permanent: Mix.env() == :prod,
            deps: deps(),
            
            compilers: [:rustler] ++ Mix.compilers(),
            rustler_crates: rustler_crates(),
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

            {:rustler, github: "hansihe/rustler", sparse: "rustler_mix"},
            {:benchee, "~> 1.0"},
            {:benchee_html, "~> 1.0"},
        ]
    end
    
    defp rustler_crates do
        [
            rust_nif: [
                path: "native/rust_nif",
                mode: rustc_mode(Mix.env(), System.get_env("OPTIMIZE_NIF") == "true")
            ]
        ]
    end

    defp rustc_mode(_, true), do: :release
    defp rustc_mode(:prod, _), do: :release
    defp rustc_mode(_, _), do: :debug
end
