

fn irrefutable_pattern(some_value: i32) {
    // this is a irrefutable pattern
    let _x = some_value;

    // this pattern will always match, so the `if let` is useless
    // if let x = some_value {
    //     println!("{}", x);
    // };
}

fn refutable_pattern(some_option_value: Option<i32>) {
    // this is a refutable pattern
    if let Some(x) = some_option_value {
        println!("{}", x);
    }

    // ^^^^^^^ pattern `None` not covered
    // `let` bindings require an "irrefutable pattern", like a `struct` or an `enum` with only one variant
    // let Some(x) = some_option_value;
}