use std::ops::{Add, Deref};

#[derive(Debug, Clone, Copy)]
struct Point {
    x: i32,
    y: i32
}

impl Add for Point {
    type Output = Self;

    fn add(self, rhs: Self) -> Self::Output {
        Point {
            x: self.x + rhs.x,
            y: self.y + rhs.y
        }
    }
}

impl Add<i32> for Point {
    type Output = Self;

    fn add(self, rhs: i32) -> Self::Output {
        Point {
            x: self.x + rhs,
            y: self.y + rhs
        }
    }
}

pub fn advanced_traits() {
    let p1 = Point{x: 1, y: 2};
    let p2 = Point{x: 3, y: 4};

    let p3 = p1 + p2;
    println!("p1 + p2 -> {}", p3);

    let p4 = p1 + 10;
    println!("p1 + 10 -> {}", p4);

    p4.outline_print();


    let w = Wrapper(vec![String::from("hello"), String::from("world")]);
    println!("w = {}", w);
    println!("w.get(0) = {:?}, w.get(1) = {:?}, w.get(2) = {:?}",
             w.get(0), w.get(1), w.get(2));
}


use std::fmt;
use std::fmt::Formatter;

// trait bound
trait OutlinePrint: fmt::Display {
    fn outline_print(&self) {
        let output = self.to_string();
        let len = output.len();
        println!("{}", "*".repeat(len + 4));
        println!("*{}*", " ".repeat(len + 2));
        println!("* {} *", output);
        println!("*{}*", " ".repeat(len + 2));
        println!("{}", "*".repeat(len + 4));
    }
}

impl fmt::Display for Point {
    fn fmt(&self, f: &mut Formatter<'_>) -> fmt::Result {
        write!(f, "({}, {})", self.x, self.y)
    }
}
impl OutlinePrint for Point {}


// Newtype pattern
struct Wrapper(Vec<String>);

impl fmt::Display for Wrapper {
    fn fmt(&self, f: &mut fmt::Formatter) -> fmt::Result {
        write!(f, "[{}]", self.0.join(", "))
    }
}

impl Deref for Wrapper {
    type Target = Vec<String>;

    fn deref(&self) -> &Self::Target {
        &self.0
    }
}