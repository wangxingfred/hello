positive_integers = for i <- 1..1000, do: [i, i]
negative_integers = for i <- 1..1000, do: [-i, -i]
positive_floats = for i <- 1..1000, do: [i + i / 1000, i - i / 1000]

Benchee.run(
    %{
        "nif_add" => fn (args) -> apply(&RustNif.add/2, args) end,
        "beam_add" => fn (args) -> apply(&HelloRustler.add/2, args) end,
    },

    inputs: %{
        "positive integers" => [999, 2999],
        "negative integers" => [-999, -2999],
#        "positive floats" => [999.55, 2999.38],
#        "negative floats" => [-999.55, -2999.38],
    },

    time: 10,
    memory_time: 2
)