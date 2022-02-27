//! # My Crate
//!
//! `c14_cargo_crates` is a collection of utilities to make performing certain
//! calculations more convenient.

pub mod art;

/// Adds one to the number given.
///
/// # Examples
///
/// ```
/// let arg = 5;
/// let answer = crate::c14_cargo_crates::add_one(arg);
///
/// assert_eq!(6, answer);
/// ```
pub fn add_one(x: i32) -> i32 {
    x + 1
}

// cargo doc --open
