use rand::Rng;
use std::thread;
use std::time::Duration;

fn main() {
    println!("Hello, world!");

    // closure
    generate_workout(10, rand::thread_rng().gen_range(1..5));

    // iterators
    let v1: Vec<i32> = vec![1, 2, 3];
    let v2: Vec<_> = v1.iter().map(|x| x + 1).collect();
    assert_eq!(v2, vec![2, 3, 4]);
}

struct Cacher<T>
where
    T: Fn() -> i32,
{
    calculation: T,
    value: Option<i32>,
}

impl<T> Cacher<T>
where
    T: Fn() -> i32,
{
    fn new(calculation: T) -> Cacher<T> {
        Cacher {
            calculation,
            value: None,
        }
    }

    fn value(&mut self) -> i32 {
        match self.value {
            Some(v) => v,
            None => {
                let v = (self.calculation)();
                self.value = Some(v);
                v
            }
        }
    }
}

fn generate_workout(intensity: i32, random_number: i32) {
    let mut cacher = Cacher::new(|| {
        println!("calculating slowly...");
        thread::sleep(Duration::from_secs(2));
        intensity * 10
    });

    if random_number == 3 {
        println!("Take a break today! Remember to stay hydrated!");
    } else if intensity < 25 {
        println!("Today, do {} pushups!", cacher.value());
        println!("Next, do {} situps!", cacher.value());
    } else {
        println!("Today, run for {} minutes!", cacher.value());
    }
}
