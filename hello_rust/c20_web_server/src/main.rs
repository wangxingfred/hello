mod single_thread_server;
mod multi_thread_server;


fn main() {
    println!("Hello, world!");

    // single_thread_server::start();

    multi_thread_server::start();
}
