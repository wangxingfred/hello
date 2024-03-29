use std::io;
use rand::Rng;
use std::cmp::Ordering;

fn main() {
    println!("Hello, world!");
    println!("Guess the number!");

    let secret_number = rand::thread_rng().gen_range(1..101);
    let mut guess = String::new();

    loop {
        println!("Please input your guess:");

        guess.clear();
        io::stdin()
            .read_line(&mut guess)
            .expect("Failed to read line");

        let guess :i32 = match guess.trim().parse() {
            Ok(num) => num,
            Err(_) => continue
        };

        println!("You guessed: {}", guess);

        match guess.cmp(&secret_number) {
            Ordering::Less => println!("Too small!"),
            Ordering::Equal => {println!("You win!"); break},
            Ordering::Greater => println!("Too big!"),
        }
    }

}
