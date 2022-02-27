mod trait_deref;
mod trait_drop;
mod pointer_rc;
mod pointer_rf_cell;
mod pointer_week;

#[derive(Debug)]
enum List{
    Cons(i32, Box<List>),
    Nil
}

use crate::List::*;

fn main() {
   let list = Cons(1, Box::new(Cons(2, Box::new(Nil))));

    println!("Hello, world! list = {:?}", list);

    trait_deref::deref_pointer();

    trait_drop::custom_drop();

    pointer_rc::reference_counted();

    pointer_rf_cell::borrow_reference();

    pointer_week::main();
}
