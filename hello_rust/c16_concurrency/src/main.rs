mod mpsc_channel;
mod arc_mutex;

use std::thread;

fn main() {
    let v = vec![1,2,3];
    let handle = thread::spawn(move || {
        println!("Thread: v = {:?}", v);
    });
    handle.join().unwrap();
    println!("Main: Hello, world!");

    mpsc_channel::single_producer();
    mpsc_channel::multi_producer();

    arc_mutex::multi_threads_mutex();
}
