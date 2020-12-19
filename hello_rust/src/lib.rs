mod front_of_house;

mod back_of_house {
    pub struct Breakfast {
        pub toast: String,
        seasonal_fruit: String
    }

    impl Breakfast {
        pub fn summer(toast: &str) -> Breakfast {
            Breakfast {
                toast: String::from(toast),
                seasonal_fruit: String::from("banana")
            }
        }
    }

    pub enum Appetizer {
        Soup,
        Salad,
    }
}

use front_of_house::hosting;
use back_of_house::Breakfast;

use std::collections::LinkedList;

use std::fmt::Result;
use std::io::Result as IoResult;

pub fn eat_at_restaurant() {
    hosting::seat_at_table();

    let mut meal = Breakfast::summer("Rye");

    meal.toast = String::from("white");
}