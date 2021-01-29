

pub fn iterator() {
    let v = vec![1,2,3,4,5];
    let mut iter = v.iter();

    println!("next: {:?}", iter.next().unwrap());
    println!("next: {:?}", iter.next().unwrap());

    // let collected = iter.
    // println!("collect: {:?}", collected);
}