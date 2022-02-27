use std::ops::{Deref, DerefMut};

pub fn deref_pointer() {
    let x = 5;
    let y = &x;
    let z = Box::new(x);

    assert_eq!(x, 5);
    assert_eq!(*y, 5);
    assert_eq!(*z, 5);

    deref_my_box();

    deref_coercion();
}

struct MyBox<T>(T);

impl<T> MyBox<T> {
    fn new(x: T) -> MyBox<T> {
        MyBox(x)
    }
}

impl<T> Deref for MyBox<T> {
    type Target = T;

    fn deref(&self) -> &Self::Target {
        &self.0
    }
}

impl<T> DerefMut for MyBox<T> {
    fn deref_mut(&mut self) -> &mut Self::Target {
        &mut self.0
    }
}

fn deref_my_box() {
    let x = 5;
    let y = MyBox::new(x);

    assert_eq!(x, 5);
    assert_eq!(*y, 5);
}

fn deref_coercion() {
    let mut my_box_string = MyBox::new(String::from("deref"));

    // &mut MyBox<String> -> deref_mut: &mut String
    append(&mut my_box_string, " coercion");

    // &MyBox<String> -> deref: &String -> deref: &str
    hello(&my_box_string)
}

fn hello(s: &str) {
    println!("hello {}", s)
}
fn append(s: &mut String, tail: &str) {
    s.push_str(tail);
}