mod unsafe_rust;
mod advanced_traits;
mod advanced_types;
mod advanced_functions_closures;
mod macros;

fn main() {
    println!("Hello, world!");

    unsafe_rust::unsafe_rust();

    advanced_traits::advanced_traits();

    advanced_types::advanced_types();

    advanced_functions_closures::advanced_functions_closures();
}
