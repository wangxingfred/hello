use std::rc::Rc;

#[derive(Debug)]
enum List {
    Nil,
    Cons(i32, Rc<List>)
}

use crate::pointer_rc::List::*;

pub fn reference_counted() {
    let a = Rc::new(Cons(5, Rc::new(Nil)));
    println!("strong count of a : {}", Rc::strong_count(&a));

    let b = Cons(6, Rc::clone(&a));
    println!("strong count of a : {}", Rc::strong_count(&a));

    let c = Cons(7, Rc::clone(&a));
    println!("strong count of a : {}", Rc::strong_count(&a));

    println!("a = {:?}, b = {:?}, c = {:?}", a, b, c);

    drop(b);
    println!("strong count of a : {}", Rc::strong_count(&a));
}