fn main() {
    let mut v1 : Vec<i32> = Vec::new();
    v1.push(1);
    v1.push(2);
    v1.push(3);
    println!("v1 = {:?}", v1);
    for i in &mut v1 {
        *i += 50;
    }
    println!("v1 = {:?}", v1);

    let v2 = vec![2,3,4];
    println!("v2 = {:?}", v2);

    let third = &v2[2];
    match v2.get(2) {
        Some(third) => println!("match third : {}", third),
        None => println!("match None")
    }
}
