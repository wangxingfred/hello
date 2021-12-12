#[derive(Debug)]
struct User {
    active: bool,
    username: String,
    email: String,
    sign_in_count: i64
}

fn build_user(email: String, username: String) -> User {
    User {
        email,
        username,
        active: false,
        sign_in_count: 0
    }
}

struct Color(i32, i32, i32);
struct Point(i32, i32);

#[derive(Debug)]
struct Rectangle {
    width: i32,
    height: i32
}
fn area(rect: &Rectangle) -> i32 {
    rect.width * rect.height
}

impl Rectangle {
    fn square(width: i32) -> Rectangle {
        Rectangle{
            width,
            height: width
        }
    }

    fn area(&self) -> i32 {
        self.width * self.height
    }

    fn can_hold(&self, other: &Rectangle) -> bool {
        self.width >= other.width && self.height >= other.height
    }
}

fn main() {
    let user1 = build_user(String::from("user1@mail.com"), String::from("user1"));
    println!("user1 : {:?}", user1);

    let user2 = User {
        username: String::from("user2"),
        ..user1
    };
    // println!("user1 : {:?}", user1); // error! user1 partially moved into user2
    println!("user2 : {:#?}", user2);

    let user3 = User {
        email: String::from("user3@mail.com"),
        username: String::from("user3"),
        ..user2
    };
    dbg!(user2);
    // println!("user2 : {:#?}", user2); //error! user2 moved by dbg!(user2)
    dbg!(&user3);

    let color = Color(1,2,3);
    let point = Point(4, 5);
    println!("color : {},{},{}", color.0, color.1, color.2);
    println!("point : {},{}", point.0, point.1);

    let rect = Rectangle{width: 10, height: 3};
    println!("area(&rect) : {}", area(&rect));
    println!("rect.area() : {}", rect.area());

    let rect2 = Rectangle{width: 9, height: 3};
    println!("'{:?}' can_hold '{:?}' -> {}", rect, rect2, rect.can_hold(&rect2));

    let square = Rectangle::square(6);
    dbg!(square);
}