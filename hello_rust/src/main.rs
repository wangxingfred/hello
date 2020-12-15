fn main() {
    let mut counter = 0;

    let result = loop {
        counter += 1;

        if counter == 10 {
            break counter * 2;
        }
    };

    println!("loop result = {}", result);

    while counter < 11 {
        counter += 1;
    };

    let arr = [1,2,3];
    for element in 1..5 {
        println!("element : {}", element)
    }
}

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


