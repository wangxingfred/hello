use std::error::Error;
use std::env;

#[derive(Debug)]
pub struct Config {
    pattern: String,
    filename: String,
    case_sensitive: bool,
}

impl Config {
    pub fn new(mut args: env::Args) -> Result<Config, &'static str> {
        args.next();

        let pattern = match args.next() {
            Some(arg) => arg,
            None => return Err("Didn't get a 'pattern' string")
        };

        let filename = match args.next() {
            Some(arg) => arg,
            None => return Err("Didn't get a 'filename' string")
        };

        let case_sensitive = match env::var("CASE_SENSITIVE") {
            Ok(value) => !value.eq("false"),
            _ => true
        };

        Ok(Config {
            pattern,
            filename,
            case_sensitive,
        })
    }
}

/// Run search with config
///
/// # Example
///
/// ```
/// let config = hello_rust::Config::new(std::env::args())?;
/// hello_rust::run(&config)?
/// ```
pub fn run(config: &Config) -> Result<(), Box<dyn Error>> {
    let content = std::fs::read_to_string(&config.filename)?;

    let list;

    if config.case_sensitive {
        list = search_sensitive(&config.pattern, &content);
    } else {
        list = search_insensitive(&config.pattern, &content);
    }

    for line in list {
        println!("{}", line);
    }

    Ok(())
}

fn search_sensitive<'a>(pattern: &str, content: &'a str) -> Vec<&'a str> {
    // let mut list = Vec::new();
    //
    // for line in content.lines() {
    //     if line.contains(pattern) {
    //         list.push(line);
    //     }
    // }
    //
    // list

    return content.lines().filter(|line| line.contains(pattern)).collect();
}

fn search_insensitive<'a>(pattern: &str, content: &'a str) -> Vec<&'a str> {
    let mut list = Vec::new();

    let pattern = pattern.to_lowercase();

    for line in content.lines() {
        if line.to_lowercase().contains(&pattern) {
            list.push(line);
        }
    }

    list
}

#[cfg(test)]
mod tests {
    #[test]
    fn search_sensitive() {
        let pattern = "duct";
        let contents = "Rust:\nsafe, fast, productive.\nPick three.";

        assert_eq!(vec!["safe, fast, productive."], super::search_sensitive(pattern, &contents))
    }

    #[test]
    fn search_insensitive() {
        let pattern = "rUsT";
        let contents = "Rust:\nsafe, fast, productive.\nPick three.\nTrust me.";

        assert_eq!(vec!["Rust:", "Trust me."], super::search_insensitive(pattern, &contents))
    }
}

// pub mod adder {
//     pub fn add_two(a: i32) -> i32 {
//         a + 2
//     }
// }
//
//
// #[cfg(test)]
// mod tests {
//     use super::*;
//
//     #[test]
//     fn add_two_and_two() {
//         assert_eq!(4, adder::add_two(2));
//     }
//
//     #[test]
//     fn add_three_and_two() {
//         assert_eq!(5, adder::add_two(3));
//     }
//
//     #[test]
//     fn one_hundred() {
//         assert_eq!(102, adder::add_two(100));
//     }
// }

// pub fn greeting(name: &str) -> String {
//     // format!("Hello {}!", name)
//     String::from("Hello!")
// }
//
// #[cfg(test)]
// mod tests {
//     use super::*;
//
//     #[test]
//     fn greeting_contains_name() {
//         let result = greeting("Carol");
//         assert!(result.contains("Carol"),
//         "Greeting did not contain name, value was `{}`", result);
//     }
// }


// #[cfg(test)]
// mod tests {
//     #[test]
//     fn exploration() {
//         assert_eq!(2 + 2, 4);
//     }
//
//     #[test]
//     fn another() {
//         panic!("Make this test fail!");
//     }
// }


// mod front_of_house;
//
// mod back_of_house {
//     pub struct Breakfast {
//         pub appetizer: Appetizer,
//         pub toast: String,
//         seasonal_fruit: String
//     }
//
//     impl Breakfast {
//         pub fn summer(toast: &str) -> Breakfast {
//             Breakfast {
//                 appetizer: Appetizer::Soup,
//                 toast: String::from(toast),
//                 seasonal_fruit: String::from("banana")
//             }
//         }
//
//         pub fn take(&self) {
//             println!("take breakfast : appetizer = {:?}, toast = {}, fruit = {}",
//                      self.appetizer, self.toast, self.seasonal_fruit)
//         }
//     }
//
//     #[derive(Debug)]
//     pub enum Appetizer {
//         Soup,
//         Salad,
//     }
// }
//
// use front_of_house::hosting;
// use back_of_house::{Breakfast, Appetizer};
//
// // use std::collections::LinkedList;
//
// // use std::fmt::Result;
// // use std::io::Result as IoResult;
//
// pub fn eat_at_restaurant() {
//     hosting::seat_at_table();
//
//     let mut meal = Breakfast::summer("Rye");
//
//     meal.appetizer = Appetizer::Salad;
//     meal.toast = String::from("white");
//
//     meal.take()
// }