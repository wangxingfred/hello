use std::sync::mpsc;
use std::thread;

pub fn single_producer() {
    let (tx, rx) = mpsc::channel();

    thread::spawn(move || {
        let msg = String::from("hi");
        tx.send(msg).unwrap();
    });

    let received = rx.recv().unwrap();
    println!("single_producer: received = {}", received);
}

pub fn multi_producer() {
    let (tx, rx) = mpsc::channel();
    let tx1 = tx.clone();

    thread::spawn(move || {
        let v = vec![
            "hi", "from", "tx1"
        ];
        for msg in v {
            tx1.send(String::from(msg)).unwrap();
        }
    });

    thread::sleep(std::time::Duration::from_secs(1));

    thread::spawn(move || {
        let v = vec![
            "hi", "from", "tx"
        ];
        for msg in v {
            tx.send(String::from(msg)).unwrap();
        }
    });

    for received in rx {
        println!("multi_producer: received = {}", received);
    }
}