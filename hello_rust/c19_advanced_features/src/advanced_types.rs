

pub fn advanced_types() {
    type_alias();

    // never_return_type();
}

fn type_alias() {
    type Kilometers = i32;

    let x: i32 = 1;
    let y: Kilometers = 4;

    println!("type_alias: x = {:?}, y = {:?}", x, y);
}

fn never_return_type() {
    bang()
}

fn bang() -> ! {
    panic!("bang")
}