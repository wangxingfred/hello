#[rustler::nif]
fn add(a: i64, b: i64) -> i64 {
    a + b
}

#[rustler::nif]
fn panic() {
    panic!("Boom!")
}

#[rustler::nif]
fn crash() {
    // create a null pointer
    let p: *const i32 = std::ptr::null();
    // https://doc.rust-lang.org/book/ch19-01-unsafe-rust.html
    unsafe {
        // dereferencing a raw pointer can only be done in an unsafe block
        // but dereferencing a NULL pointer is undefined behavior!
        // and likely to cause a segmentation fault and program crash
        println!("{:?}", *p);
    }
}

rustler::init!("Elixir.HelloRustler.MyNif", [add, panic, crash]);
