use std::net::{TcpListener, TcpStream};
use std::io::{Read, Write};
use std::fs;

fn handle_connection(mut stream: TcpStream) {
    let mut buffer = [0; 1024];
    stream.read(&mut buffer).unwrap();

    let get = String::from_utf8_lossy(&buffer);

    println!("get : {}", get);

    let (status, filename) = if get.starts_with("GET / HTTP/1.1") {
        ("HTTP/1.1 200 OK", "hey.html")
    } else {
        ("HTTP/1.1 404 NOT FOUND", "404.html")
    };

    let content = fs::read_to_string(filename).unwrap();
    let response = format!("{}\r\nContent-Length: {}\r\n\r\n{}", status, content.len(), content);

    println!("response : {}", response);

    stream.write(response.as_bytes()).unwrap();
    stream.flush().unwrap();
}

fn main() {
    let listener = TcpListener::bind("127.0.0.1:7878").unwrap();
    for stream in listener.incoming()  {
        let stream = stream.unwrap();

        handle_connection(stream)
    }
}
