#[derive(Debug)]
enum UsState {
    Alabama,
    Alaska
}

#[derive(Debug)]
enum Coin {
    Penny,
    Nickel,
    Dime,
    Quarter(UsState)
}

impl Coin {
    fn value(&self) -> i32 {
        match self {
            Coin::Penny => {
                println!("lucky penny!");
                1
            },
            Coin::Nickel => 5,
            Coin::Dime => 10,
            Coin::Quarter(state) => {
                println!("state : {:?}", state);
                25
            }
        }
    }
}

fn plus_one(x: Option<i32>) -> Option<i32> {
    match x {
        None => None,
        Some(value) => Some(value + 1)
    }
}

fn main() {
    println!("---------------------------------------");

    let coin = Coin::Penny;
    println!("{:?}.value() -> {}", coin, coin.value());

    let coin = Coin::Dime;
    println!("{:?}.value() -> {}", coin, coin.value());

    let coin = Coin::Quarter(UsState::Alaska);
    println!("{:?}.value() -> {}", coin, coin.value());

    println!("---------------------------------------");

    let o = Option::None;
    println!("{:?} plus_one -> {:?}", o, plus_one(o));

    let o = Option::Some(5);
    println!("{:?} plus_one -> {:?}", o, plus_one(o));

    println!("---------------------------------------");

    let integer = 9;
    match integer {
        1 => println!("match 1"),
        2 => println!("match 2"),
        other => println!("dismatch other : {}", other)
    }

    println!("---------------------------------------");

    match o {
        Some(5) => println!("match 5!"),
        _ => ()
    }

    if let Some(5) = o {
        println!("if let match 5");
    } else {
        println!("if let match miss!")
    }
}
