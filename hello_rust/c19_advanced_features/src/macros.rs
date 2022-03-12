#[macro_export] // this macro should be made available whenever the crate in which the macro is defined is brought into scope
macro_rules! vec {
    ( $( $x:expr ),* ) => {
        {
            let mut temp_vec = Vec::new();
            $(
                temp_vec.push($x);
            )*
            temp_vec
        }
    };
}



use proc_macro;

// #[some_attribute]
// pub fn some_name(input: TokenStream) -> TokenStream {
// }

// use proc_macro::TokenStream;
// use quote::quote;
// use syn;
//
// #[proc_macro_derive(HelloMacro)]
// pub fn hello_macro_derive(input: proc_macro::TokenStream) -> proc_macro::TokenStream {
//     // Construct a representation of Rust code as a syntax tree
//     // that we can manipulate
//     let ast = syn::parse(input).unwrap();
//
//     // Build the trait implementation
//     impl_hello_macro(&ast)
// }
//
// fn impl_hello_macro(ast: &syn::DeriveInput) -> proc_macro::TokenStream {
//     let name = &ast.ident;
//     let gen = quote! {
//         impl HelloMacro for #name {
//             fn hello_macro() {
//                 println!("Hello, Macro! My name is {}!", stringify!(#name));
//             }
//         }
//     };
//     gen.into()
// }