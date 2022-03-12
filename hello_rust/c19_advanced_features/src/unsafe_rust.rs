use std::slice;


pub fn unsafe_rust() {
    // five unsafe superpowers

    // 1.Dereference a raw pointer
    dereference_raw_pointer();

    // 2.Call an unsafe function or method
    call_unsafe_function();
    create_safe_abstraction();
    call_extern_function();

    // 3.Access or modify a mutable static variable
    visit_mutable_static_variable();

    // 4.Implement an unsafe trait
    implement_unsafe_trait();

    // 5.Access fields of unions
}


pub fn dereference_raw_pointer() {
    let mut x = 5;

    let r1 = &x as *const i32;
    let r2 = &mut x as *mut i32;

    unsafe {
        println!("r2 = {}", *r2);
        *r2 += 1;

        println!("r1 = {}", *r1);
    }
}

pub fn call_unsafe_function() {
    unsafe {
        dangerous();
    }
}

unsafe fn dangerous() {
    println!("unsafe is dangerous!!")
}

pub fn create_safe_abstraction() {
    let mut v = vec![1, 2, 3, 4, 5];
    let (a, b) = split_at_mut(&mut v, 3);

    println!("a = {:?}, b = {:?}", a, b);

    if let Some(x) = a.get_mut(2) {
        *x = (*x) * 100;
    }

    println!("a = {:?}, b = {:?}", a, b);
}

fn split_at_mut(slice: &mut [i32], mid: usize) -> (&mut [i32], &mut [i32]) {
    let len = slice.len();
    let ptr = slice.as_mut_ptr();

    assert!(mid <= len);

    unsafe {
        (
            slice::from_raw_parts_mut(ptr, mid),
            slice::from_raw_parts_mut(ptr.add(mid), len - mid),
        )
    }
}

pub fn call_extern_function() {
    unsafe {
        println!("Absolute value of -3 according to C: {}", abs(-3));
    }
}

// call c function
extern "C" {
    fn abs(input: i32) -> i32;
}

// export a function to c
#[no_mangle]
pub extern "C" fn call_from_c() {
    println!("Just called a Rust function from C!");
}


static mut COUNTER: u32 = 0;

fn add_static_counter(inc: u32) {
    unsafe {
        COUNTER += inc;
    }
}

pub fn visit_mutable_static_variable() {
    add_static_counter(6);
    unsafe {
        println!("static counter is: {}", COUNTER);
    }
}



unsafe trait Foo {
    // methods go here
}

unsafe impl Foo for i32 {
    // method implementations go here
}

pub fn implement_unsafe_trait() {

}