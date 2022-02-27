
trait Messenger {
    fn send(&self, msg: &str);
}

struct LimitedTracker<'a, T: Messenger> {
    messenger: &'a T,
    value: usize,
    max: usize
}

impl<'a, T: Messenger> LimitedTracker<'a, T> {
    fn new(messenger: &T, max: usize) -> LimitedTracker<T> {
        LimitedTracker{
            messenger,
            value: 0,
            max,
        }
    }

    fn set_value(&mut self, value: usize) {
        self.value = value;

        let percent = value as f64 / self.max as f64;
        if percent > 1.0 {
            self.messenger.send("Error: max reached!")
        } else if percent >= 0.9 {
            self.messenger.send("Warning: 90% of max!")
        }
    }
}


struct MockMessenger {
    message_queue: std::cell::RefCell<Vec<String>>
}

impl MockMessenger {
    fn new() -> MockMessenger {
        MockMessenger {
            message_queue: std::cell::RefCell::new(vec![])
        }
    }
}

impl Messenger for MockMessenger {
    fn send(&self, msg: &str) {
        {
            let mut mut_queue = self.message_queue.borrow_mut();
            // let mut mut_queue2 = self.message_queue.borrow_mut();

            mut_queue.push(String::from(msg));
            // mut_queue2.push(String::from(msg));
        }

        println!("MockMessenger: msg => {}, queue_len={}",
                 msg, self.message_queue.borrow().len())
    }
}


pub fn borrow_reference() {
    let messenger = MockMessenger::new();
    let mut tracker = LimitedTracker::new(&messenger, 100);

    tracker.set_value(50);
    tracker.set_value(90);
    tracker.set_value(101);
}