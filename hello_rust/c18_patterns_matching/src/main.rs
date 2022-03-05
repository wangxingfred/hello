mod refutable_irrefutable;

fn if_let_expressions() {
    let favorite_color: Option<&str> = None;
    let is_tuesday = false;
    let age: Result<u8, _> = "34".parse();

    if let Some(color) = favorite_color {
        println!("Using your favorite color, {}, as the background", color);
    } else if is_tuesday {
        println!("Tuesday is green day!");
    } else if let Ok(age) = age {
        if age > 30 {
            println!("Using purple as the background color");
        } else {
            println!("Using orange as the background color");
        }
    } else {
        println!("Using blue as the background color");
    }
}

fn while_let_loops() {
    let mut stack = Vec::new();

    stack.push(1);
    stack.push(2);
    stack.push(3);

    while let Some(top) = stack.pop() {
        println!("{}", top);
    }
}

fn for_loops() {
    let v = vec!['a', 'b', 'c'];

    for (index, value) in v.iter().enumerate() {
        println!("{} is at index {}", value, index);
    }
}

fn let_statements() {
    // let PATTERN = EXPRESSION;
    let x = 5;
    let (x, y, z) = (1, 2, 3);
    // let (x, y) = (1, 2, 3);
}

fn function_parameters(&(x, y): &(i32, i32)) {
    println!("Current location: ({}, {})", x, y);
}


fn main() {
    println!("Hello, world!");

    if_let_expressions();
    while_let_loops();
    for_loops();

    let_statements();
    function_parameters(&(1,2));
}
