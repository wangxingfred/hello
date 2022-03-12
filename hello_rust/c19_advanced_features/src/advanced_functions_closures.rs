pub fn advanced_functions_closures() {
    println!("function_pointer_do_twice(add_one, 5) -> {}",
             function_pointer_do_twice(add_one, 5));

    println!("closure_trait_do_twice(add_one, 6) -> {}",
             closure_trait_do_twice(add_one, 6));

    println!("closure_trait_obj_do_twice(add_one, 7) -> {}",
             closure_trait_obj_do_twice(&add_one, 7));


    // use either a closure defined inline or a named function
    let list_of_numbers = vec![11, 222, 3333];

    println!("list_of_numbers.iter().map(|i| i.to_string()).collect() -> {:?}",
             list_of_numbers.iter().map(|i| i.to_string()).collect::<String>());

    println!("list_of_numbers.iter().map(ToString::to_string).collect() -> {:?}",
             list_of_numbers.iter().map(ToString::to_string).collect::<String>());


    tuple_struct_initializer();

    returns_closure();
}

fn add_one(x: i32) -> i32 {
    x + 1
}

fn function_pointer_do_twice(f: fn(i32) -> i32, arg: i32) -> i32 {
    f(arg) + f(arg)
}

// generic trait
fn closure_trait_do_twice<F>(f: F, arg: i32) -> i32
    where F: Fn(i32) -> i32 {
    f(arg) + f(arg)
}

// trait obj
fn closure_trait_obj_do_twice(f: &dyn Fn(i32) -> i32, arg: i32) -> i32 {
    f(arg) + f(arg)
}


#[derive(Debug)]
enum Status {
    Value(u32),
    Stop,
}

fn tuple_struct_initializer() {
    let list_of_statuses: Vec<Status> = (0u32..3).map(Status::Value).collect();

    println!("tuple_struct_initializer : {:?}", list_of_statuses);
}


fn returns_closure() -> Box<dyn Fn(i32) -> i32> {
    Box::new(|x| x + 1)
}