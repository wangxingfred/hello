use hello_rust::c11_test;

mod common;

#[test]
fn it_adds_two() {
    common::setup();

    assert_eq!(c11_test::add_two(2), 4);
}


// cargo test --test integration_test