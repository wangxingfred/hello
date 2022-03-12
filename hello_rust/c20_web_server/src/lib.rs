use std::sync::{Arc, mpsc, Mutex};
use std::sync::mpsc::{Receiver, Sender};
use std::thread;
use std::thread::JoinHandle;
use crate::Message::NewJob;

type Job = Box<dyn FnOnce() + Send + 'static>;

enum Message {
    NewJob(Job),
    Terminate
}

struct Worker {
    id: usize,
    thread: Option<JoinHandle<()>>,
}

impl Worker {
    fn new(id: usize, rx: Arc<Mutex<Receiver<Message>>>) -> Worker {
        let thread = thread::spawn(move || loop {
            let job = rx.lock().unwrap().recv().unwrap();

            if let NewJob(job) = job {
                println!("Worker {} got a job; executing.", id);
                job();
            } else {
                println!("Worker {} was told to terminate.", id);
                break;
            }
        });
        Worker { id, thread: Some(thread) }
    }
}

pub struct ThreadPool {
    size: usize,
    sender: Sender<Message>,
    workers: Vec<Worker>,
}

impl ThreadPool {
    pub fn new(size: usize) -> ThreadPool {
        assert!(size > 0);

        let (sx, rx) = mpsc::channel();

        let receiver = Arc::new(Mutex::new(rx));

        let mut workers = Vec::with_capacity(size);
        for i in 0..size {
            workers.push(Worker::new(i, Arc::clone(&receiver)));
        }

        ThreadPool { size, sender: sx, workers }
    }

    pub fn execute<F>(&self, f: F)
        where F: FnOnce() + Send + 'static {
        let job = Message::NewJob(Box::new(f));
        self.sender.send(job).unwrap();
    }
}

impl Drop for ThreadPool {
    fn drop(&mut self) {
        println!("Sending terminate message to all workers.");
        for _ in 0..self.workers.len() {
            self.sender.send(Message::Terminate);
        }

        println!("Shutting down all workers.");
        for worker in &mut self.workers {
            if let Some(thread) = worker.thread.take() {
                thread.join().unwrap();
            }
        }
    }
}

