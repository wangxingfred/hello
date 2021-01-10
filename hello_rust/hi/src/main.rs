use std::ops::Add;

#[derive(Debug, PartialEq)]
struct Point {
    x: i32,
    y: i32
}

impl Clone for Point {
    fn clone(&self) -> Self {
        println!("Point cloned : {:?}", self);
        Point {
            x: self.x,
            y: self.y,
        }
    }
}

impl Copy for Point {

}

impl Add for Point {
    type Output = Point;

    fn add(self, rhs: Self) -> Self::Output {
        Point {
            x: self.x + rhs.x,
            y: self.y + rhs.y
        }
    }
}

impl Add<i32> for Point {
    type Output = Point;

    fn add(self, rhs: i32) -> Self::Output {
        return Point {
            x: self.x + rhs,
            y: self.y + rhs
        };
    }
}

fn create_point(x: i32, y: i32) -> Point {
    Point {
        x,
        y,
    }
}

fn main () {
    // let a = Point {x: 1, y: 0};
    // let b = Point {x: 2, y: 1};
    //
    // println!("{}", stringify!(assert_eq!(a.clone() + b.clone(), Point {x: 3, y: 1})));
    // assert_eq!(a.clone() + b.clone(), Point {x: 3, y: 1});
    //
    // println!("a = {:?}", a);
    // println!("b = {:?}", b);
    //
    // println!("a + 3 = {:?}", a + 3);
    let point = create_point(1,2);

    println!("point = {:?}", point)
}

// use std::thread;
// use std::time::Duration;
// use std::sync::mpsc;
// use std::thread::JoinHandle;
//
// fn main () {
//     let v = vec![1,2,3];
//     let v2 = vec![4,5,6];
//
//     let (tx, rx) = mpsc::channel();
//
//     let mut handle= Option::None;
//     // for _i in 1..2 {
//     //     handle = Option::Some(thread::spawn(move || {
//     //         println!("spawned thread, v : {:?}", v);
//     //         for i in 1..10 {
//     //             tx.send(i).unwrap();
//     //             // println!("spawned thread, hi number {}", i);
//     //             thread::sleep(Duration::from_millis(1));
//     //         }
//     //     }));
//     // }
//
//     handle = Option::Some(thread::spawn(move || {
//         println!("spawned thread, v : {:?}", v);
//         for i in 1..10 {
//             tx.send(i).unwrap();
//             // println!("spawned thread, hi number {}", i);
//             thread::sleep(Duration::from_millis(1));
//         }
//     }));
//
//     println!("main thread, v2 : {:?}", v2);
//     for val in rx {
//         println!("main thread, received : {}", val);
//     }
//     // for i in 1..5 {
//     //     println!("main thread, hi number {}", i);
//     //     thread::sleep(Duration::from_millis(1));
//     // }
//
//     handle.unwrap().join().unwrap();
// }

// use std::rc::Rc;
//
// enum List {
//     Cons(i32, Rc<List>),
//     Nil
// }
//
// fn main () {
//     let a = Rc::new(List::Cons(5, Rc::new(List::Cons(6, Rc::new(List::Nil)))));
//     println!("strong count : {}", Rc::strong_count(&a));
//
//     let b = List::Cons(3, Rc::clone(&a));
//     println!("strong count : {}", Rc::strong_count(&a));
//
//     {
//         let c = List::Cons(4, Rc::clone(&a));
//         println!("strong count : {}", Rc::strong_count(&a));
//     }
//
//     println!("strong count : {}", Rc::strong_count(&a));
// }


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
