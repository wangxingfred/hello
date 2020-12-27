use std::rc::Rc;

enum List {
    Cons(i32, Rc<List>),
    Nil
}

fn main () {
    let a = Rc::new(List::Cons(5, Rc::new(List::Cons(6, Rc::new(List::Nil)))));
    println!("strong count : {}", Rc::strong_count(&a));

    let b = List::Cons(3, Rc::clone(&a));
    println!("strong count : {}", Rc::strong_count(&a));

    {
        let c = List::Cons(4, Rc::clone(&a));
        println!("strong count : {}", Rc::strong_count(&a));
    }

    println!("strong count : {}", Rc::strong_count(&a));
}


// struct MySmartPointer {
//     data: String
// }
//
// impl Drop for MySmartPointer {
//     fn drop(&mut self) {
//         println!("Dropping by MySmartPointer, data = {}", self.data)
//     }
// }
//
// fn main() {
//     println!("Hello, world!");
//
//     let pointer = MySmartPointer {
//         data: String::from("hi")
//     };
//     println!("MySmartPointer created.");
//
//     drop(pointer);
//
//     println!("MySmartPointer dropped.");
//
//     // println!("pointer.data = {}", pointer.data)
// }
