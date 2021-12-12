fn main() {
    let s1 = String::from("Hello, world!");
    let s2 = s1.clone();
    println!("s1 = {}, s2 = {}", s1, s2);
    take_ownership(s1);
    let s3 = takes_and_gives_back(s2);
    let _len = calculate_length(&s3);
    let first_word = first_word(&s3);
    // s3.clear(); // error!
    println!("first word : {}", first_word);

    let x = 1;
    let y = x;
    println!("x = {}, y = {}", x, y);
    copy_nodrop_value(x);

    let array = [0, 1, 2, 3, 4, 5];
    let array_slice = &array[1..3];
    println!("array_slice = {:?}", array_slice);
    assert_eq!(array_slice, &[1, 2]);
}

fn take_ownership(s: String) {
    println!("take ownership : {}", s);
}

fn takes_and_gives_back(s: String) -> String {
    s
}

fn copy_nodrop_value(i: i32) {
    println!("copy no drop value : {}", i)
}

fn calculate_length(s: &String) -> usize {
    s.len()
}

fn first_word(s: &str) -> &str {
    let bytes = s.as_bytes();

    for (i, &item) in bytes.iter().enumerate() {
        if item == b' ' {
            return &s[..i];
        }
    }

    &s[..] //equals to : &s
}
