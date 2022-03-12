use std::fs;
use std::io::{Read, Write};
use std::net::TcpStream;

pub fn start() {
    let listener = std::net::TcpListener::bind("127.0.0.1:7878").unwrap();

    for stream in listener.incoming() {
        let stream = stream.unwrap();

        println!("Connection established!");
        handle_connection(stream)
    }
}

fn handle_connection(mut stream: TcpStream) {
    let mut buffer = [0; 1024];
    stream.read(&mut buffer).unwrap();
    println!("Request: {}", String::from_utf8_lossy(&buffer));

    let get = b"GET / HTTP/1.1\r\n";


    // let file_path;
    // let status_line;
    // if buffer.starts_with(&get[..]) {
    //     file_path = "hey.html";
    //     status_line = "HTTP/1.1 200 OK";
    // } else {
    //     file_path = "404.html";
    //     status_line = "HTTP/1.1 404 NOT FOUND";
    // }
    let (status_line, filename) = if buffer.starts_with(&get[..]) {
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