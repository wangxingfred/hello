struct Post {
    content: String,
    state: Box<dyn State>,
}

impl Post {
    fn new() -> Post {
        Post {
            content: String::new(),
            state: Box::new(StateDraft {}),
        }
    }
    fn add_text(&mut self, text: &str) {
        self.content.push_str(text);
    }

    fn request_review(&mut self) {
        match self.state.request_review() {
            None => {}
            Some(state) => self.state = state
        }
    }

    fn approve(&mut self) {
        match self.state.approve() {
            None => {}
            Some(state) => self.state = state
        }
    }

    fn content(&self) -> &str {
        self.state.content(self)
    }

    fn show_state(&self) {
        self.state.show();
    }
}

trait State {
    fn request_review(&self) -> Option<Box<dyn State>> { Option::None }

    fn approve(&self) -> Option<Box<dyn State>> { Option::None }

    fn content<'a>(&self, _post: &'a Post) -> &'a str {
        ""
    }

    fn description(&self) -> &str;

    fn show(&self) {
        println!("current state : {}", self.description())
    }
}

struct StateDraft {}

impl State for StateDraft {
    fn request_review(&self) -> Option<Box<dyn State>> {
        Some(Box::new(StatePending {}))
    }

    fn description(&self) -> &str {
        "Draft"
    }
}

struct StatePending {}

impl State for StatePending {
    fn approve(&self) -> Option<Box<dyn State>> {
        Some(Box::new(StateApproved {}))
    }

    fn description(&self) -> &str {
        "Pending"
    }
}

struct StateApproved {}

impl State for StateApproved {
    fn content<'a>(&self, post: &'a Post) -> &'a str {
        &post.content
    }

    fn description(&self) -> &str {
        "Approved"
    }
}


pub fn post_with_states() {
    let mut post = Post::new();

    post.add_text("test");
    post.show_state();

    post.request_review();
    post.show_state();
    assert_eq!("", post.content());

    post.approve();
    post.show_state();
    assert_eq!("test", post.content());
}