fn main() {
    println!("Hello, world!");

    // let x = let y = 6;

    let x = {
        let y = five();
        y + 1
    };

    // let z = if another_function(x) { 2 } else { "z" };

    let ret = loop_test(x, 1);
    println!("loop_test ret = {},{}", ret.0, ret.1);

    println!("while_test ret : {}", while_test(x));

    println!("for_test ret : {}", for_test());
}

fn five() -> i32 {
    5
}

// fn another_function(x: i32) -> bool {
//     println!("another_function : {}", x);
//     x > 10
// }

fn loop_test(mut x: i32, mut y: i32) -> (i32, i32) {
    'loop_outer: loop {
        x += 1;

        println!("loop_test : x = {}", x);
        loop {
            y += 1;

            println!("loop_test : y = {}", y);
            if y % 3 == 0 {
                break;
            }
            else if x % 5 == 0 {
                break 'loop_outer (x,y);
            }
            else if x % 3 == 0 {
                continue;
            }
            else if y % 4 == 0 {
                continue 'loop_outer;
            }
        }
    }
}

fn while_test(mut x: i32) -> i32 {
    while x < 10 {
        x += 1;
    }
    x
}

fn for_test() -> usize {
    let arr = [11, 22, 33];

    for element in arr {
        println!("for_test : element = {}", element);
    }
    arr.len()
}