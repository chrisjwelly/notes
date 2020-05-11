Some miscellaneous notes on how I fixed certain things / learnt new things while using Rust.

## `println`: expected literal / format argument must be string literal
I had a string literal which I bound to a variable. Upon trying to call `println!` on that variable, it gave the error as per titled.
Resolved by reading this [Stack Overflow post](https://stackoverflow.com/questions/27734708/println-error-expected-a-literal-format-argument-must-be-a-string-literal)

In particular, do this:
```rust
fn main() {
    let c = "hello";
    println!("{}", c);

    // do the above instead of
    // println!(c);
}
```

## Concatenating Two Strings
I had a string representation a line and indentation, which I tried to concatenante. `format!` macro was giving me difficulties (turns out it wasn't. It was the `println` expecting literal issue). So I searched for ways I can concatenate two strings. 

I found this [Stack Overflow post](https://stackoverflow.com/questions/30154541/how-do-i-concatenate-strings). Although it didn't really help me but I think I will leave it here for easy future reference.

## Matching Strings from standard input
I had a code expecting user input, which I would like to handle for the case when user inputs "bye":
```rust
let input = ...; // some input

match input {
    "bye" => // do something for bye
    _ => // do something else for everything that is not bye
}
```

But instead this gave me an error about expecting struct `std::string::String`, found `&str`.

This [Stack Overflow post](https://stackoverflow.com/questions/31541442/how-do-i-match-on-a-string-read-from-standard-input) helped resolve it for me.

The fix is to call `input.trim()` instead. In particular:
```rust
let input = ...; // ...

match input.trim() { // add .trim() here
    "bye" => // ...
    _ => // ...
}
```

I'm actually not fully sure why yet, but I will update this if I remember to and once I figured it out
