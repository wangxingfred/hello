
#[derive(Debug)]
struct CustomPointer {
    data: String
}

impl Drop for CustomPointer {
    fn drop(&mut self) {
        println!("Dropping CustomPointer with data : {}", self.data)
    }
}


pub fn custom_drop() {
    let c = CustomPointer{
        data: String::from("ccc")
    };
    println!("Create : {:?}", c);

    drop(c);

    let d = CustomPointer{
        data: String::from("ddd")
    };
    println!("Create : {:?}", d)
}
