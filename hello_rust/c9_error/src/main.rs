
// PowerShell > $Env:RUST_BACKTRACE = 1
// PowerShell > cargo run --bin c9_error

use std::fs::File;
use std::io::{ErrorKind, Read};

fn main() {
    // let v = vec![1,2,3];
    // v[99];

    let f = File::open("c9_error.txt");

    let f = match f {
        Ok(file) => file,
        Err(error) => match error.kind() {
            ErrorKind::NotFound => match File::create("c9_error.txt") {
                Ok(file) => file,
                Err(error) => panic!("Failed to create file : {}", error)
            },
            _ => panic!("Failed to open file : {}", error)
        }
    };
    println!("f = {:?}", f);


    println!("read_from_file : {:?}", read_from_file());
    println!("read_to_string : {:?}", read_to_string());
}

fn read_from_file() -> Result<String, std::io::Error> {
    let mut f = File::open("c9_error.txt")?;
    let mut s = String::new();
    f.read_to_string(&mut s)?;
    Ok(s)
}

fn read_to_string() -> Result<String, std::io::Error> {
    std::fs::read_to_string("c9_error.txt")
}
