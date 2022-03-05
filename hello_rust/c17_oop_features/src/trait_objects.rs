trait Draw {
    fn draw(&self);
}

struct Screen {
    pub components: Vec<Box<dyn Draw>>
}

impl Screen {
    fn new() -> Screen {
        Screen {
            components: vec![]
        }
    }

    fn add(&mut self, obj: Box<dyn Draw>) {
        self.components.push(obj);
    }

    fn run(&self) {
        println!("Screen run ...");
        for component in self.components.iter() {
            print!("\t");

            // When we use trait objects, Rust must use dynamic dispatch.
            // The compiler doesn’t know all the types that might be used with the code that is using trait objects,
            // so it doesn’t know which method implemented on which type to call.
            // Instead, at runtime, Rust uses the pointers inside the trait object to know which method to call.
            // There is a runtime cost when this lookup happens that doesn’t occur with static dispatch.
            // Dynamic dispatch also prevents the compiler from choosing to inline a method’s code, which in turn prevents some optimizations.
            component.draw();
        }
    }
}

struct Button {
    width: f32,
    height: f32
}

impl Draw for Button {
    fn draw(&self) {
        println!("Draw Button : {} x {}", self.width, self.height)
    }
}

pub fn draw_objects() {
    let mut screen = Screen::new();

    let button = Button{width: 2.2, height: 3.3};
    screen.add(Box::new(button));

    screen.run();
}