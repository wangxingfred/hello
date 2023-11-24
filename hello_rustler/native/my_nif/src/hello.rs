#[rustler::nif]
fn hello() -> String {
    return String::from("world");
}

rustler::init!("Elixir.HelloRustler", [hello]);
