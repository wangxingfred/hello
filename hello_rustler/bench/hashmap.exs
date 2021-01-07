
Benchee.run(
    %{
        "rust_hashmap" => fn (count) -> RustNif.hashmap(count) end,
        "dict_hashmap" => fn (count) -> HelloRustler.hashmap(count) end,
    },
    
    inputs: %{
        "hashmap:1000000" => 1000000,
    },
    
    time: 10,
    memory_time: 2,
    formatters: [
        {Benchee.Formatters.HTML, file: "bench/output/hashmap.html", auto_open: false},
        Benchee.Formatters.Console
    ]
)