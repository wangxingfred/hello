use std::fmt::{Display, Formatter};

#[derive(Debug)]
struct Point<T, U> {
    x: T,
    y: U
}

impl<T,U> Point<T,U> {
    fn x(&self) -> &T {
        &self.x
    }
    fn y(&self) -> &U {
        &self.y
    }
}

impl Point<f32, f32> {
    fn distance(&self) -> f32 {
        (self.x.powi(2) + self.y.powi(2)).sqrt()
    }
}

pub trait Summary {
    fn summarize_author(&self) -> String;
    fn summarize(&self) -> String {
        format!("(Read more from {}...)", self.summarize_author())
    }
}

pub struct Tweet {
    pub username: String,
    pub content: String,
    pub reply: bool,
    pub retweet: bool
}

impl Summary for Tweet {
    fn summarize_author(&self) -> String {
        format!("@{}", self.username)
    }
}

impl Display for Tweet {
    fn fmt(&self, f: &mut Formatter<'_>) -> std::fmt::Result {
        Ok(())
    }
}

pub fn notify(item: &impl Summary) {
    println!("Notify news : {}", item.summarize())
}
pub fn show<T: Summary>(item: &T) {
    println!("Show news : {}", item.summarize());
}

pub fn notify_display(item: &(impl Summary+Display)) {
    println!("Notify display : {}, {}", item, item.summarize())
}
pub fn show_display<T: Summary+Display>(item: &T) {
    println!("Show display : {}, {}", item, item.summarize())
}

fn largest<T>(list: &[T]) -> T where T: std::cmp::PartialOrd+Copy {
    let mut largest = list[0];
    for &element in list {
        if element > largest {
            largest = element;
        }
    }
    largest
}

fn the_longer<'a>(a: &'a str, b: &'a str) -> &'a str {
    if a.len() > b.len() {
        a
    } else {
        b
    }
}

fn main() {
    println!("Point: {:?}", Point{x: 5, y: 5.0});
    println!("distance: {:?}", (Point{x: 3.0, y: 4.0}).distance());

    let tweet = Tweet {
        username: String::from("horse_ebooks"),
        content: String::from(
            "of course, as you probably already know, people",
        ),
        reply: false,
        retweet: false,
    };
    notify(&tweet);
    show(&tweet);

    notify_display(&tweet);
    show_display(&tweet);

    println!("largest i32 : {}", largest(&vec![1, 2, 3]));
    println!("largest char : {}", largest(&vec!['A', 'B', 'C']));

    println!("the longer: {}", the_longer(&String::from("abc"), "abcd"));
}
