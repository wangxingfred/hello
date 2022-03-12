use std::{fs, thread};
use std::io::{Read, Write};
use std::net::TcpStream;
use std::time::Duration;

use c20_web_server::ThreadPool;

pub fn start() {
    let listener = std::net::TcpListener::bind("127.0.0.1:8888").unwrap();
    let pool = ThreadPool::new(4);

    for stream in listener.incoming().take(2) {
        let stream = stream.unwrap();

        println!("Connection established!");

        pool.execute(|| handle_connection(stream));
    }

    println!("Shutting down.");
}

fn handle_connection(mut stream: TcpStream) {
    let mut buffer = [0; 1024];
    stream.read(&mut buffer).unwrap();

    let request = String::from_utf8_lossy(&buffer);
    let request_head = request.split("\r\n").next();
    println!("Request: {:?}", request_head);

    let get = b"GET / HTTP/1.1\r\n";
    let sleep = b"GET /sleep HTTP/1.1\r\n";

    let (status_line, filename) = if buffer.starts_with(&get[..]) {
        ("HTTP/1.1 200 OK", "hey.html")
    } else if buffer.starts_with(&sleep[..]) {
        thread::sleep(Duration::from_secs(3));
        ("HTTP/1.1 200 OK", "hey.html")
    } else {
        ("HTTP/1.1 404 NOT FOUND", "404.html")
    };

    let contents = fs::read_to_string(filename).unwrap();
    let response = format!(
        "{}\r\nContent-Length: {}\r\n\r\n{}",
        status_line,
        contents.len(),
        contents
    );

    stream.write(response.as_bytes()).unwrap();
    stream.flush().unwrap();
}