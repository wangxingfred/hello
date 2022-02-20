use std::env;
use std::fs;
use std::process;
use std::error::Error;

use c12_minigrep::Config;

fn main() {
    let args: Vec<String> = env::args().collect();

    let config = Config::new(&args).unwrap_or_else(|err| {
        eprintln!("Problem parsing arguments: {}", err);
        process::exit(1);
    });

    println!("Config: Searching for {}", config.query);
    println!("Config: In file {}", config.filename);
    println!("Config: CASE_INSENSITIVE = {}", config.case_sensitive);

    if let Err(e) = c12_minigrep::run(config) {
        eprintln!("Application error: {}", e);

        process::exit(1);
    }
}

// PowerShell > $Env:CASE_INSENSITIVE=1
// PowerShell > Remove-Item Env:CASE_INSENSITIVE
// PowerShell > Get-Item Env:CASE_INSENSITIVE

// cargo run --bin c12_minigrep to poem.txt > output.txt