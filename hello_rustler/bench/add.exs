positive_integers = for i <- 1..100000, do: [i, i]
negative_integers = for i <- 1..100000, do: [-i, -i]
#positive_floats = for i <- 1..100000, do: [i + i / 1000, i - i / 1000]

batch_add = fn (fn_add, inputs) ->
    for args <- inputs, do: apply(fn_add, args)
    :no_return
end

Benchee.run(
    %{
        "nif_add" => fn (inputs) -> batch_add.(&RustNif.add/2, inputs) end,
        "beam_add" => fn (inputs) -> batch_add.(&HelloRustler.add/2, inputs) end,
    },

    inputs: %{
        "positive integers" => positive_integers,
        "negative integers" => negative_integers,
#        "positive floats" => [999.55, 2999.38],
#        "negative floats" => [-999.55, -2999.38],
    },

    time: 10,
    memory_time: 2,
    formatters: [
        {Benchee.Formatters.HTML, file: "bench/output/add.html", auto_open: false},
        Benchee.Formatters.Console
    ]
)