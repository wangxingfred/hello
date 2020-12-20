fn main() {
    let mut x = 5;
    let r = &mut x;

    *r = 6;
// x = 7;

    println!("r = {:#?}", r);
    println!("x = {:#?}", x);
}

// fn set(x: &mut String) {
//     // x = String::from("xx");
//     x.clear();
// }

// fn largest<T: PartialOrd>(list: &[T]) -> &T {
//     let mut largest = &list[0];
//     for item in list.iter() {
//         if item > largest {
//             largest = item
//         }
//     }
//
//     return largest
// }
//
// fn main () {
//     let list = [1,2,5,3];
//
//     println!("largest of list : {}", largest(&list));
//     println!("list = {:?}", list);
//
//     let s = 3.to_string();
// }


// use std::fs::File;
// use std::io::{Error, ErrorKind, Read};
//
// fn main() {
//     // panic!("crash an burn!")
//
//     // let v = vec![1, 2, 3];
//     // v[88];
//
//     match File::open("hello.txt") {
//         Ok(f) => println!("f = {:?}", f),
//         Err(e) => println!("e = {:?}", e)
//     }
//
//     // File::open("hello.txt").unwrap();
//
//     File::open("hello.txt").expect("Failed to open hello.txt");
//
//     let f = File::open("hello.txt").unwrap_or_else(|error| {
//         if error.kind() == ErrorKind::NotFound {
//             File::create("hello.txt").unwrap_or_else(|error| {
//                 panic!("Problem creating the file : {:?}",error);
//             })
//         } else {
//             panic!("Problem opening the file: {:?}", error)
//         }
//     });
// }
//
// fn read_username_from_file() -> Result<String, Error> {
//     let mut username = String::new();
//
//     File::open("hello.txt")?.read_to_string(&mut username)?;
//
//     Ok(username);
//
//     std::fs::read_to_string("hello.txt")
// }

// use std::collections::HashMap;
//
// fn main () {
//     let mut scores = HashMap::new();
//
//     scores.insert(String::from("Blue"), 10);
//     scores.insert(String::from("Red"), 20);
//
//     println!("scores = {:?}", scores);
//
//     let teams = vec![String::from("Blue"), String::from("Yellow")];
//     let initial_scores = vec![10, 50, 60];
//
//     let mut scores: HashMap<_, _> =
//         teams.into_iter().zip(initial_scores.into_iter()).collect();
//
//     println!("scores = {:?}", scores);
// }

// #![allow(unused)]
// fn main() {
//     for c in "नमस्ते".chars() {
//         println!("{}", c);
//     }
//
//     for b in "नमस्ते".bytes() {
//         println!("{}", b)
//     }
// }

// fn main() {
//     let mut s1 = String::from("foo");
//     let s2 = "bar";
//     s1.push_str(s2);
//     println!("s2 is {}", s2);
// }


// fn main () {
//     let mut v = vec![1,2,3];
//
//     v.push(4);
//     v.push(5);
//
//     println!("v.get(100) = {:?}", v.get(100));
//     println!("v[100] = {}", v[100]);
//
//     let first = &v[0];
//
//     v.push(6);
//
//     println!("first = {}", first);
//     // println!("v = {}", v);
// }

// enum IpAddrKind {
//     V4(String),
//     V6(String)
// }
//
// fn main() {
//     let home = IpAddrKind::V4(String::from("localhost"));
//
//     let loopback = IpAddrKind::V6(String::from("::1"));
//
// }


// struct Rect {
//     width: u32,
//     height: u32
// }
//
// impl Rect {
//     fn area(&self) -> u32 {
//         self.width * self.height
//     }
//
//     fn can_hold(&self, other: &Rect) -> bool {
//         self.width > other.width && self.height > other.height
//     }
//
//     fn square(size: u32) -> Rect {
//         Rect {
//             width: size,
//             height: size
//         }
//     }
// }
//
// fn main() {
//
// }

// #[derive(Debug)]
// struct User {
//     name: String,
//     email: String,
//     sign_in_count: u64,
//     active: bool
// }
//
// fn main () {
//     let user0 = build_user(
//     String::from("fred@gmail.com"),
//     String::from("fred"));
//
//     let mut user1 = User {
//         name: String::from("jack"),
//         email: String::from("jack@xx.com"),
//         sign_in_count: 0,
//         active: false
//     };
//     user1.sign_in_count = 1;
//
//     let user2 = User {
//         name: String::from("john"),
//         email: String::from("john@gmail.com"),
//         ..user0
//     };
//
//     println!("user2 = {:#?}", user2)
// }
//
// fn build_user(email: String, name: String) -> User {
//     User {
//         email,
//         name,
//         sign_in_count: 0,
//         active: false
//     }
// }

// fn main() {
//     let s1 = String::from("first string");
//     let mut s2 = String::from("second string");
//
//     let word = first_word(&s1, &s2);
//
//     s2.clear();
//
//     println!("word = {}", word)
// }
//
// fn first_word(s1: &str, s2: &str) -> &str {
//     for (i, &char) in s1.as_bytes().iter().enumerate() {
//         if char == b' ' {
//             return &s1[..i];
//         }
//     }
//     &s1
// }

// fn main() {
//     let s1 = String::from("Hello world");
//     let s2 = s1.clone();
//
//     println!("s1 = {}, s2 = {}", s1, s2);
// }

// fn main() {
//     let mut counter = 0;
//
//     let result = loop {
//         counter += 1;
//
//         if counter == 10 {
//             break counter * 2;
//         }
//     };
//
//     println!("loop result = {}", result);
//
//     while counter < 11 {
//         counter += 1;
//     };
//
//     let arr = [1,2,3];
//     for element in 1..5 {
//         println!("element : {}", element)
//     }
// }

// fn main() {
//     let num = 3;
//
//     if num == 0 {
//         println!("num = {}", num);
//     }
//
//     let x = if num > 0 { "positive" } else { false };
//
//     println!("x = {}", x);
// }

// fn main() {
//     let r = another_function();
//     println!("another return : {}", r);
// }
//
// fn another_function() -> i32 {
//     println!("Another function.");
//
//     let y = {
//         let x = 5;
//         x + 1
//     };
//
//     println!("y = {}", y);
//
//     return y
// }

// fn main() {
//     let tuple = (1, 2.2, b'a');
//
//     println!("tuple = ({}, {}, {})", tuple.0, tuple.1, tuple.2);
//
//     let array1: [u32; 5] = [1, 2, 3, 4, 5];
//     let array2: [u32; 5] = [9; 5];
//
//     let index = 6;
//
//     println!("element at {} : {}", index, array1[index]);
// }

// use std::io;
// use rand::Rng;
// use std::cmp::Ordering;
//
// fn main() {
//     println!("Guess the number");
//
//     let secret_number = rand::thread_rng().gen_range(1, 101);
//
//     loop {
//         println!("Please input your guess:");
//
//         let mut guess = String::new();
//
//         io::stdin().read_line(&mut guess).expect("Failed to read line");
//
//         let guess: u32 = match guess.trim().parse() {
//             Ok(num) => num,
//             Err(_) => continue
//         };
//
//         println!("You guessed:{0}", guess);
//
//         match guess.cmp(&secret_number) {
//             Ordering::Less => println!("Too small!"),
//             Ordering::Greater => println!("Too big!"),
//             Ordering::Equal => {
//                 println!("You win!");
//                 break;
//             }
//         }
//     }
//
// }


// use ferris_says::say;
// use std::io::{stdout, BufWriter};
//
// fn main() {
//     let stdout = stdout();
//     let message = String::from("Hello fellow Rustaceans!");
//     let width = message.chars().count();
//
//     let mut writer = BufWriter::new(stdout.lock());
//     say(message.as_bytes(), width, &mut writer).unwrap();
//
//     println!("Hello, world!");
// }


