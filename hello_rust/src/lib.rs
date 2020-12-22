pub mod adder {
    pub fn add_two(a: i32) -> i32 {
        a + 2
    }
}


#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn add_two_and_two() {
        assert_eq!(4, adder::add_two(2));
    }

    #[test]
    fn add_three_and_two() {
        assert_eq!(5, adder::add_two(3));
    }

    #[test]
    fn one_hundred() {
        assert_eq!(102, adder::add_two(100));
    }
}

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