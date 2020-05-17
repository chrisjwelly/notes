With reference to the [Rust book](https://doc.rust-lang.org/book/). Just going to put some summary notes here.

# 1. Getting Started
## 1.1. Installation
I use WSL when learning Rust so I followed the command [here](https://www.rust-lang.org/tools/install).

## 1.2. Hello, World!

```rust
fn main() { 

}
```

### Anatomy of a Rust Program
This defines a function in Rust and the `main` function is the entry point.
```rust
fn main() {
    println!("hello, world!");
}
```

The following does the work in the program:
```rust
    println!("hello, world!");
```
Some things to note:
* Rust style is to indent with four spaces, NOT a tab
* `println!` calls a Rust macro. Function would be without the `!`. More details in chapter 19.
* "Hello, world!" string is an argument
* We end line with semicolon `;`.

### Compiling and running are different steps
Compiling uses:
`rustc main.rs`

To run the executable:
`./main` on Linux

Rust is _ahead-of-time compiled_ language so you can just compile, pass the executable to someone else, and they can run it __without__ having Rust installed.

## 1.3. Hello, Cargo!
Cargo is Rust's build system and package manager. Check if Cargo is installed: `cargo --version`.

### Creating a Project with Cargo
Creating a new project from cargo:
```
$ cargo new hello_cargo
$ cd hello_cargo
```
First command creates a new directory called *hello_cargo* and names it as such. Going into directory you will see a *Cargo.toml* and a *src* directory with *main.rs* file.

It initialises Git repository also.

Cargo.toml should tell several things like name, version, authors, and Rust edition of the project.

Everything should be *src* directory with *Cargo.toml* configuration file in the top directory. An expectation: all source files should be in *src* directory while top-level should be for stuff not related to the code (e.g. README).

### Building and Running Cargo project
`$ cargo build`
The above command will create executable in *target/debug/hello_cargo*

`$ cargo run`
The above will compile and run executable all in one command

`$ cargo check`
The above will check if code compiles but doesn't produce executable.

Recap:
* Can build project using `cargo build` or `cargo check`
* Can build and run project in one step using `cargo run`
* The build is stored in *target/debut* instead of being the same directory/

Advantage: Cargo commands are the same regardless which OS.

### Building for Release
Use `cargo build --release` to compile for optimizations, with executable in *target/release* instead of *target/debug*.

### Cargo as Convention
To work on any existing projects:
```
$ git clone someurl.com/someproject
$ cd someproject
$ cargo build
```

# 2. Programming a Guessing Game
Some summary:
```rust
match xxx {
    arm1 => do1, 
    arm2 => do2,
    arm3 => {
        do3;
        doMoreFancyThings;
    }
};
```

When parsing, need to specify explicitly which number type is desired:
```rust
let guess: u32 = match guess.trim().parse() {
    Ok(num) => num,
    Err(_) => continue,
}
```
Here, we desire u32, which `parse()` recognises.

# 3. Common Programming Concepts

## 3.1. Variables and Mutability

Suppose we have the following code snippet:
```rust
fn main() {
    let x = 5;
    println("{}", x);
    x = 6;
    println("{}", x);
}
```
The above will *give an error*. This is because the variable `x` is an immutable variable.

### Variables and Constants
Declare with `const` keyword instead of `let`. Constants must be always immutable. Can be declared in any scope, including global.

Constants may be set only to a constant expression. Not anything that happens during runtime. Example (Rust's naming convention for constants is to use all uppercase with underscores between words, and underscores can be inserted in numeric literals too):
```rust
const MAX_POINTS: u32 = 100_000;
```

### Shadowing
This is different from assigning things to variables! We can shadow by using the same variable's name and repeating the use of the `let` keyword as follows:
```rust
fn main() {
    let x = 5;
    let x = x + 1;
    let x = x * 2;

    println!("The value of x is {}", x);

}
```
This will output, using value of `x` that is `12`. Again it's different from marking variable as `mut`, because we'll get compile-time error if we accidentally reassign. By using `let`, we can re-use a variable name while keeping the old variable as immutable.

Nifty trick: Create new variable and use `let` keyword again, we can change the type of the value. For example:
```rust
let spaces = "    ";
let spaces = spaces.len();
```
The above is valid even though the first `spaces` is string type and the second is int.

Compare this to:
```rust
let mut spaces = "     "
spaces = spaces.len();
```
Which will give us a compile error.

## 3.2. Data Types
Rust has two data types: Scalar and Compound types.
### Scalar
Four primary scalar types: integers, floating-point numbers, Booleans, and characters.

#### Integer Types
Number without fractional component. It comes in many different forms like `i8`, `i16`, `u32`, `u128`. Where integers prefixed with `i` is a signed integer while integers prefixed with `u` is an unsigned integer. Rust defaults to `i32`.

Integer overflow can also occur. When *compiling in debug mode* it can cause your program to *panic*. Whereas when compiling in release mode we just perform *two's complement wrapping*.

#### Floating-Point Types
Numbers with decimal points and can come with `f32` or `f64`. The default is `f64`.

```rust
fn main() {
    let x = 2.0; // f64
    let y: f32 = 3.0; // f32
}
```

#### Boolean Type
Same as normal, `true` or `false`, and Boolean type is specified using `bool`.
```rust
fn main() {
    let t = true;

    let f: bool = false; // with explicit type annotation
}
```

#### Character Type
Rust supports letters too, Rust's `char` is the language's most primitive alphabetic type. (Note `char` uses single quotes compared to double quotes for string literals)

```rust
fn main() {
    let c = 'z';
    let z = 'Z';
}
```

Rust's `char` is four bytes in size, and represents a Unicode Scalar Value, and can represent more than just ASCII.

### Compound Types
Groups multiple values into one type. Rust has two: tuples and arrays.

#### The Tuple Type
Tuples have fixed length: once declared, cannot grow or shrink in size. Write a comma-separated list in parenthesis. Each position has a type and *they can be different*.
E.g.
```rust
fn main() {
    let tup: (i32, f64, u8) = (500, 6.4, 1);
}
```
`tup` will bind the entire tuple, as a single compound element. You can destructure like this:
```rust
fn main() {
    let tup = (500, 6.4, 1);

    let (x, y, z) = tup;

    println!("y is {}", y);
}
```
The above snippet first binds `tup`, then it uses the pattern with `let` to take `tup` and turn it into separate variables `x`, `y`, `z`.

We can also access element directly using period (`.`), followed by the index of the value we want to access:
```rust
fn main() {
    let tup = (500, 6.4, 1);

    let five_hundred = x.0;

    let six_point_four = x.1;

    let one  = x.2;
}
```

#### Array Type
Unlike Tuple, Array must have same type. Arrays in Rust have a fixed length, written as a comma-separated list inside square brackets:

```rust
fn main() {
    let a = [1, 2, 3, 4, 5];
}
```
Useful when you want data on stack than heap. Consult `vector` if you want resizeable array.

To write an array type in square brackets:
* Include type of each elem
* Semicolon
* Number of elements in the array

```rust
let a: [i32; 5] = [1, 2, 3, 4, 5];
```

Here, `i32` is the type of each element and we have 5 elements.

Alternative syntax for initializing an array: if you want to create an array that contains *same value* for each element, can specify initial value instead of the type in the way to do it above:
```rust
let a = [3; 5]; // shorthand for let a = [3, 3, 3, 3, 3]
```

#### Accessing Array Elements
Using array indexing like normal:
```rust
fn main() {
    let a = [1, 2, 3, 4, 5];

    let first = a[0];
    let second = a[1];
}
```

#### Invalid Array Element Access
When you access an element that is past the end of array?
```rust
// This code panics!
fn main() {
    let a = [1, 2, 3, 4, 5];
    let index = 10;

    let element = a[index];
}
```
The compilation didn't produce any errors, but it resulted in a *runtime* error and didn't exit successfully.

## 3.3. Functions
Rust uses `snake_case` as the style for function and variable names. Example of function definitions:
```rust
fn main() {
    println!("Hello world!");

    another_function();
}

fn another_function() {
    println!("Another function.");
}
```

### Function Parameters
Examples of using parameters and passing an argument:
```rust
fn main() {
    another_function(5); // passing an argument 5
}

fn another_function(x: i32) {
    println!("The value of x is: {}", x);
}
```
In function signatures you **must** declare the type of each parameter. When you want to have multi parameters, separate with commas:
```rust
fn main() {
    another_function(5); // passing an argument 5
}

fn another_function(x: i32, y: i32) {
    println!("The value of x is: {}", x);
    println!("The value of y is: {}", y);
}
```

### Function Bodies Constain Statements and Expressions
Function bodies made up of:
* Series of statements
* Optionally ends in expression

Rust is expression-based, so it's important to understand the distinction:
* *Statements* are instructions that perform some action and do not return a value.
* *Expressions* evaluate to a resulting value

```rust
fn main() {
    let y = 6; // this is a statement
}
```

Since assignment is a statement, you can't assign `let` to another variable:
```rust
fn main() {
    let x = (let y = 6); // error!
}
```
This is different from languages such as C and Ruby where assignment returns value of assignment.

Expressions on the other hand evaluate to something that make up most of the rest of the code. Math operations such as `5 + 9` are expressions, and they can be part of statements. For example, the `6` in `let y = 6` is an expression that evaluates to the value `6`.

Some expressions:
* Calling a function
* Calling a macro
* Block that we use to create new scopes, `{}`

Example:
```rust
fn main() {
    let x = 5;

    let y = {
        let x = 3;
        x + 1
    };

    println!("The value of y is: {}", y);
}
```
This expression:
```rust
{
    let x = 3;
    x + 1
}
```
is a block that in this case evaluates to `4`. **IMPORTANT**: the `x + 1` is *without* a semicolon. Expressions do not end with a semicolon. If you add a semicolon to the end of expression, you turn it into a statement.

### Functions with Return Values
We don't name return values, but declare type after an arrow (`->`). In Rust, the return value is value of the final expression in the block of the body of a function. Can return early using `return` but most functions return implicitly.

Example:
```rust
fn five() -> i32 {
    5
}

fn main() {
    let x = five();

    println!("x is {}", x);
}
```
The `five()` function is perfectly valid! And because `five()` returns, the line `let x = five()` is the same as `let x = 5;`.

Another example:
```rust
fn main() {
    let x = plus_one(5);

    println!("x is {}", x);
}

fn plus_one(x: i32) -> i32 {
    x + 1 // no semicolon
}
```
Running above will get you `x is 6`. But we will get an error if we put a semicolon, turning `x + 1` into a statement.

## 3.4. Comments
Comments use `//`. Need to include `//` on each line if it extends beyond a single line. The book doesn't say anything about other options of multi-line comments such as `/* */` though..

## 3.5. Control Flow
### `if` expressions
Example:
```rust
fn main() {
    let number = 3;

    if number < 5 {
        println!("cond was true");
    } else {
        println!("cond was false");
    }
}
```
Blocks of code associated with the conditions in `if` expressions are sometimes called *arms* just like the arms in `match` expressions.

Optionally, we include an `else` expression, which we choose to do just in case condition is false. If you don't provide `else` expression, and condition is false, then the program will just skip the `if` block and move on to the next bit of code.

Note: the condition **must** be a `bool`. If it's a `bool`, we will get an error. Rust will not automatically try to convert non-Boolean types to a Boolean. You must be explicit and provide `if` with a Boolean as its condition

### Multiple conditions with `else if`
Example:
```rust
fn main() {
    let number = 6;

    if number % 4 == 0 {
        println!("number is divisible by 4");
    } else if number % 3 == 0 {
        println!("number is divisible by 3");
    } else if number % 2 == 0 {
        println!("number is divisible by 2");
    } else {
        println!("number is not divisible by 4, 3, or 2");
    }
}
```

### Using `if` in a `let` statement
Because `if` is an expression, we can use it on the right side of `let`:
```rust
fn main() {
    let condition = true;
    let number = if condition { 5 } else { 6 };

    println!("The value of number is {}", number);
}
```

The `number` variable will be bound to value based on the outcome of `if` expression.

Recall: blocks evaluate to last expression, and numbers by themselves are also expressions.

Values that have the potential to be results must be of the same type. If types are mismatched like the following example, we can get an error:
```rust
fn main() {
    let condition = true;

    let number = if condition { 5 } else { "six" };

    println!("The value of number is {}", number);
}
```
When we try to compile, we get an error, because they have incompatible values (`if` evaluates to integer and `else` block evaluates to a string).

### Repetition with Loops
Rust has three kinds of loops: `loop`, `while`, `for`

#### Usage of `loop`
The `loop` keyword executes a block of code over and over again forever.
```rust
fn main() {
    loop {
        println!("again");
    }
}
```

Rust provides a reliable way to break out a loop using the `break` keyword.

#### Returning Values from Loops
One use of `loop` is to retry operation you know might fail, such as checking whether a thread has completed its job. But you might need to pass the result to the rest of the code. To do this, you can add value you want returned after the `break` expression you use to stop the loop. That value will be returned, as shown:
```rust
fn main() {
    let mut counter = 0;

    let result = loop {
        counter += 1;

        if counter == 10 {
            break counter * 2;
        }
    };
    
    println!("Result: {}", result);
}
```

Before loop, we declared `counter`, initialising it to `0`. We loop and use the `break` keyword with the value `counter * 2`. After the loop, we use a semicolon to end the statement that assigns the value to `result`. Finally we print value in `result`.

### Conditional Loops with `while`
Example:
```rust
fn main() {
    let mut number = 3;
    while number != 0 {
        println!("{}!", number);

        number -= 1;
    }

    println!("LIFTOFF!!!");
}
```

### Looping Through a Collection with `for`
You could use the `while` construct to loop over the elements of a collection, such as an array.

```rust
fn main() {
    let a = [10, 20, 30, 40, 50];
    let mut index = 0;

    while index < 5 {
        println!{"the value is: {}", a[index]}

        index += 1;
    }
}
```

But this approach is error prone, because it can cause programs to panic if the index length is incorrect. We can use a `for` loop and execute some code for each item in a collection. Example:
```rust
fn main() {
    let a = [10, 20, 30, 40, 50];

    for element in a.iter() {
        println!("the value is {}", element);
    }
}
```

Most Rustacenas would use a `for` loop as well. To do that we use `Range` which is a type provided by the standard library that generates all numbers in sequence starting from one number and ending before another number.

Countdwn would look like this using a `for` loop and another method `rev` which reverses the range:

```rust
fn main() {
    for number in (1..4).rev() {
        println!("{}!", number);
    }

    println!("Liftoff!!");
}
```

# 4. Understanding Ownership
Ownership is Rust's most unique feature, and it enables Rust to make memory safety guarantees without needing a garabge collector. An important feature to understand! Related features: borrowing, slices, and how Rust lays data out in memory.

## 4.1. What Is Ownership?
All programs have to manage the way they use a computer's memory while running. Some languages have garbage collection, and some languages need to make it explicit. Rust uses thid approach: memory is managed through a system of ownership with a set of rules that compiler checks at compile time. None of ownership features slow down your program while it's running.

### Stack and Heap
Both stack and heap are parts of memory that are avaialble to your code to use at runtime, but they are structured in different ways. Stack follows LIFO.

All data stored on stack must have a known fixed size. Data with unknown size at compile time or a size that might change must be stored on the heap instead. Heap less organised, and the operating system finds an empty spot in the heap that is being enough, marking it as being in use and returning a *pointer* which is the address of that location.

Accessing data in heap is slower than stack, because you have to follow a pointer to get there. Allocating large amount of space on heap also take time.

When your code calls a function, the values passed onto the function and the function's local variables get pushed onto the stack and when function is over those values get popped off the stack.

Keeping track of what parts of code are using what data on heap, minimizing amount of duplicate data on heap, and cleaning up unused data on heap so you don't run out of space is something ownership addresses.

### Ownership Rules
These are the main rules:
* Each value in Rust has a variable that's called its owner
* There can only be one owner at a time
* When owner goes out of scope, the value will be dropped

### Variable Scope
First example of ownership, we'll look at the *scope* of some variables. Variable looks like this:
```rust
let s = "hello";
```
Variable `s` refers to a string literal. The variable is valid from the point at which it's delared until the end of the current *scope*. More comments:
```rust
{   // s is not valid here, it's not yet been declared
    let s = "hello"; // s is valid from this point forward

    // do stuff with s
}   // scope now over and s is no longer valid
```

There are two important points in time here:
* When `s` comes *into* scope, it is valid
* It remains valid until it goes *out of scope*

Now let's build on top of this understanding by introducing `String` type

### The `String` Type
`String` is different from string literals (where a string value is hardcoded into our program). Not every string value can be known when we write our code: for example, what if we want to take user input and store it? Rust has a second string type `String`. This type is allocated on the heap and as such is able to storea na amount of text unknown to us at compile time. You can create a `String` from a string literal using the `from` function:

```rust
let s = String::from("hello");
```

The double colon (`::`) is an operator that allows us to namespace this particular `from` function under the `String` type rather than using some sort of name like `string_from`.

This kind of string *can* be mutated:
```rust
let mut s = String::from("hello");

s.push_str(", world!"); // push_str() appends a literal to a String

println!("{}", s); // this will print "hello, world!"
```
Why can `String` be mutated but literals cannot? The difference is how these two types deal with memory

### Memory and Allocation
For string literal, we know contents at compile time, so text is hardcoded. But we won't know each text whose size is unknown at compile time.

With `String` type, in order to support mutable text we need to:
* Request memory from OS at runtime
* A way to return memory to OS when we are done

First part is done when we call `String::from`.
Second part is different. With garbage collector, this is easy. With manual memory management this is tough.

Rust takes a different path: the memory is automatically returned once the variable that owns it goes out of scope. 

```rust
{
    let s = String::from("hello"); // s is valid from this point on

    // do stuff with s
}   // this scope is now over and no longer valid
```
There is a natural point at which we can return the memory our `String` needs to the OS: when `s` goes out of scope. When variable goes out of scope, Rust calls a special function for us called `drop`. This is where author of `String` can put code to return to memory and Rust calls `drop` automatically at closing curly bracket.

This may be simple right now, but behavior of code can be unexpected in more complicated situations when we want to have multi variables use data we've allocated on the heap.

#### Ways Variables and Data Interact: Move
Multiple vars can interact with the same data in different ways in Rust.
```rust
let x = 5;
let y = x;
```
We can uess what's this doing: "bind value of `5` to `x`, then *make a copy* of the value in `x` and bint it to `y`". We now have two variables, `x` and `y`, and both equal `5`.

`String` version:
```rust
let s1 = String::from("hello");
let s2 = s1;
```
Okay there are some diagrams in the website here which I cannot reproduce so I will just describe them. `String` is made up of three parts: a pointer to memory, a length, and capacity. This group of data is stored on stack. On the right is memory on the heap that holds the contents.

The length is how much memory, in bytes, the contents of the `String` is currently using. The capacity is total amount `String` has received from the operating system. The difference between length and capacity matters, but not in this context, so for now, it's fine to ignore the capacity.

When we assign `s1` to `s2`, the `String` data is copied, meaning we copy the pointer, the length and capacity that are *on the stack*. We **do not copy** the data on the heap that the pointer refers to.

Earlier: variable goes out of scope, Rust calls `drop` automatically to clean up. But this is a problem: when `s2` and `s1` go out of scope, they will both try to free the same memory. This is known as *double free* error and is one of the memory safety bugs we mentioned previously. Freeing memory twice can lead to memory corruption, which can potentially lead to security vulnerabilities.

To ensure memory safety, there's on more detail. Instead of trying to copy allocated memory, Rust considers `s1` to no longer be valid and, therefore Rust doesn't need to free anything when `s1` goes out of scope. Check out what happens when you try to use `s1` after `s2` is created:
```rust
let s1 = String::from("hello");
let s2 = s1;

println!("{}, world!", s1);
```
You'll get an error because Rust prevents you from using invalidated reference

The act of making a *shallow copy* is the most similar here, but instead of being called such, we call it a *move*. This solves our problem as `s2` is valid, when it goes out of scope, it alone will free the memory and we're done.

Implication: Rust will never automatically create "deep" copies of data. Any *automatic* copying can be assumed to be inexpensive in terms of urntime performance.

#### Ways Variables and Data Interact: Clone
If we do want to deeply copy the heap data of `String`, we can use a common method called `clone`. Example:
```rust
let s1 = String::from("hello");
let s2 = s1.clone();

println!("s1 = {}, s2 = {}", s1, s2);
```
Works just fine and create a copy of the heap data. When you call `clone`, you know that some arbitrary code is being executed and code may be expensive. It's a visual indicator that something different is going on.

#### Stack-Only Data: Copy
This code is valid:
```rust
let x = 5;
let y = x;

println!("x = {}, y = {}". x. y);
```
This is not a contradiction to not calling `clone`. `x` is still valid and wasn't moved to `y`. Types such as integers that have a known size at compile time are stored entirely on the stack, so copies of the actual copies are quick to make. So we do a shallow copy of it and no need to invalidate `x`.

Rust has special annotation called `Copy` trait that we can place on types like integers that are stored on the stack. To my understanding, those with `Copy` trait cannot be used anymore if the type related to it has implemented the `Drop` trait. (this might be wrong)

General rule of thumb: group of simple scalar values can be `Copy`. Examples:
* All integer types such as `u32`
* The Boolean type `bool`
* All floating point types such as `f64`
* The character type, `char`
* Tuples if they only types that are `Copy`. E.g. `(i32, i32)` is `Copy`, but `(i32, String)` is not.

### Ownership and Functions
The semantics for passing a value to a function are similar to those for assigning value to variable. Passing variable to function will move or copy just like assignment. Examples:
```rust
fn main() {
    let s = String::from("hello"); // s comes into scope

    takes_ownership(s); // s's values moves into function...
                        // .. so it's not longer valid here

    let x = 5; // x comes into cope

    makes_copy(x); // x would move into the function, but i32 is Copy, so it's okay to
    // use x afterward
} // Here, x goes out of scope then s. But because s's value was moved, nothing special happens

fn takes_ownership(some_string: String) { // some_string comes into scope
    println!("{}", some_string);
} // here, some_string goes out of scope and `drop` is called. The backing memory is freed

fn makes_copy(some_integer: i32) { // some_integer comes into scope
    println!("{}", some_integer);
} // here, some_integer goes out of scope. Nothing special happens
```

If we tried to use `s` after the call to `takes_ownership`, Rust would throw compile-time error. These check protects us.

### Return Values and Scope
Returning values can also transfer ownership. Example:
```rust
fn main() {
    let s1 = gives_ownership(); // gives ownership moves its return value into s1

    let s2 = String::from("hello"); // s2 comes into scope

    let s3 = takes_and_gives_back(s2); // s2 is moved into takes_and_gives_back, which also
                                       // moves its return value into s3
} // Here, s3 goes out of scope and is dropped. s2 goes out of scope but was moved
// so nothing happens. s1 goes out of scope and is dropped

fn gives_ownership() -> String { // gives ownership will move its return value into the function
                                // that calls it

    let some_string = String::from("hello"); // some_string comes into scope

    some_string // some_string is returned and moves out to the calling function
}

// takes_and_gives-back will take a String and return one
fn takes_and_gives_back(a_string: String) -> String { // a_string comes into scope
    a_string // a_string is returned and moves out to the calling function
}
```

The ownership of a varaible follows the same pattern every time: assigning a value to another variable moves it. When a variable that includes data on the heap goes out of scope, the value will be cleand up by `drop` unless the data has been moved to be owned by another variable.

Taking ownership and then returning for function can be tedious. It's possible to return multiple values using tuple, as shown here:
```rust
fn main() {
    let s1 = String::from("hello");

    let (s2, len) = calculate_length(s1);

    println!("The length of '{}' is {}.", s2, len);
}

fn calculate_length(s: String) -> (String, usize) {
    let length = s.len(); // len() returns the length of a String

    (s, length)
}
```
BUT, this is too much work for a concept that should be common. So luckily, Rust has *references*.

## 4.2. References and Borrowing
How you define and use a `calculate_length` function that has a reference to an object as a parameter *instead of taking ownership of the value*:
```rust
fn main() {
    let s1 = String::from("hello");

    let len = calculate_length(&s1);

    pritnln!("The length of '{}' is {}.", s1, len);
}

fn calculate_length(s: &String) -> usize {
    s.len()
}
```
All tuple code is gone, and we pass `&s1` into `calculate_length` and it its definition we take `&String` rather than `String`. These ampersands are *references*, and allow you to refer to some value *without taking ownership* of it.

Note: The opposite of referencing is dereferencing, acoomplished with the dereference operator `*`.

Taking a closer look, the `&s1` syntax lets us create a reference that *refers* to the *value* of `s1` but does not own it. Because it dows not own it, the value it points to will not be dropped when the *reference* goes out of scope.

Likewise, the signature of the function uses `&` to indicate that the type of the parameter `s` is a reference. Adding some annotations:
```rust
fn calculate_length(s: &String) -> usize { // s is a reference to a String
    s.len()
} // Here, s goes out of scope. But because it does not have ownership of what it refers to,
// nothing happens.
```

The scope of `s` is valid, but when it goes out of scope, we don't need to drop what `s` reference points to because we don't have ownership. We call having references as function parameters *borrowing*.

Attempt to try to modify something we're borrowing:
```rust
fn main() {
    let s = String::from("hello");

    change(&s);
}

fn change(some_string: &String) {
    some_string.push_str(", world"); // this is gonna give an error!
}
```
Just as variables are immutables by default, references too.

### Mutable References
We can fix it with small tweak (basically add `mut` to everything):
```rust
fn main() {
    let mut s = String::from("hello");

    change(&mut s);
}

fn change(some_string: &mut String) {
    some_string.push_str(", world"); // this is gonna give an error!
}
```

One big restriction: you can have *only one mutable reference* to a particular piece of data in a particular scope. This will fail:
```rust
let mut s = String::from("hello");

let r1 = &mut s;
let r2 = &mut s; // second mutable reference

println!("{}, {}", r1, r2);
```
You can mutate, but it's much more controlled.

Benefit: prevent data races. A *data race* is similar to a race condition and happens when these tree behaviors occur:
* Two or more pointer access the same data at the same time
* At least one of the pointers is being used to write the data
* There's no mechanism being used to synchronize access to the data

Data races cause undefined behavior and can be difficult to diagnose and fix when trying to track them down at runtime. 

As always, we can use curly brackets to create a new scope, allowing for multiple mutable references, just not *simultaneous* ones:
```rust
let mut s = String::from("hello");
{
    let r1 = &mut s;
} // r1 goes out of scope here, so we can make a new reference with no problems.

let r2 = &mut s;
```
Similar rule for mix and match of mutable and immutable references:
```rust
let mut s = String::from("hello");

let r1 = &s; // no problem
let r2 = &s; // no problem
let r3 = &mut s; // BIG PROBLEM

println!("{}, {}, and {}", r1, r2, r3);
```
We *also* cannot have mutable reference while we have immutable ones. Users of immutable reference don't expect values to suddenly change out from under them. Multiple immutable ok though because they are read-only.

Note that a reference's scope starts from where it is introduced and continues through the last time that reference is used. This is ok:
```rust
let mut 1
let mut s = String::from("hello");

let r1 = &s; // no problem
let r2 = &s; // no problem
println!("{} and {}", r1, r2);
// r1 and r2 are no longer used after this point

let r3 = &mut s; // no problem
println!("{}", r3);
```
The scopes of immutable references end after the first `println!`, which is before mutable refi s created. Scopes don't overlap, so this code is allowed.

### Dangling References
*Dangling pointer* is a pointer that references a location in memory that may have been given to someone else, by freeing some memory while preserving a pointer to that memory. In Rust, compiler guarantees that reference will never be dangling. If you have reference to some data, the compiler will ensure that data will not go out of scope before the reference does.

Example which will give compile error:
```rust
fn main() {
    let reference_to_nothing = dangle();
}

fn dangle() -> &String {
    let s = String::from("hello");

    &s
}
```
This gives some error related to lifetimes which is to be covered in Chapter 10. But the msg of this error is clear: "this function's return type contains a borrowed value, but there is no value for it to be borrowed from"

Taking a closer look...
```rust
fn dangle() -> &String { // dangle returns a reference to a String
    let s = String::from("hello"); // s is a new String

    &s // we return a reference to String s
} // Here s goes out of scope, and is dropped. Its memory goes away. Danger!!
```
Because `s` is created inside `dangle`, when the code of `dangle` is finished, `s` will be deallocated but we tried to return a reference of it! That means this reference would be pointing to an invalid `String`!

The solution is to return directly:
```rust
fn no_dangle() -> String {
    let s = String::from("hello");

    s
}
```
This works without any problems. Ownership is moved out, and nothing is deallocated.

### Rules of References:
Let's recap:
* At any given time, *either* one mutable reference *or* any number of immutable references.
* References must always be valid.

## 4.3. The Slice Type
Another type that does not have ownership is *slice*. It lets you reference a contiguous sequence of elements in a collection rather than the whole collection.

Motivating problem: write a function that takes a string and returns the first word it finds in that string. If no space, return the whole word.

Function signature?
```rust
fn first_word(s: &String) -> ?
```
The function has a `&String` as parameter. Since we don't want ownership, this is fine. But what should we return? We don't really have a way to talk about *part* of string. But we could return the index of the end of the word. For example:
```rust
fn first_word(s: &String) -> usize {
    let bytes = s.as_bytes(); // convert to array of bytes

    for (i, &item) in bytes.iter().enumerate() {
        if item == b' ' {
            return 1;
        }
    }

    s.len()
}
```
Because we need to go through `String`, we'll convert it to array of bytes first.

Next, we create iterator over the array of bytes with `iter` method:
```rust
for (i, &item) in bytes.iter().enumerate() 
```
`iter` is a method that returns each element in a collection, `enumerate` wraps the result of `iter` and returns each element as part of a tuple instead. First elem there is the index, and second element is a reference to the element. This is more convenient that calculating the index ourselves.

Because `enumerate` returns a tuple, we can destructure it. In the `for` loop, we specify a pattern that has `i` for index, and `&item` for the single byte in the tuple. Because we get a reference to element when using `enumerate()`, we use `&`.

Inside the `for` loop, we search byte that represents space using byte literal. If we find a space, we return that position. Otherwise, return length of string using `s.len()`.

New problem: we're returning a `usize` on its own, but it's meaningful only in the context of `&String`. Because it's a separate value from `String`, there's no guarantee that it will still be valid in the future. Consider this:
```rust
fn main() {
    let mut s = String::from("hello world");

    let word = first_word(&s); // word will get the value 5

    s.clear(); // emties the String, making it equal to ""

    // word still has the value 5 here, but there's no more string that
    // we could meaningfully use the value 5 with. Word is now totally invalid!
}
```
This compiles without error, but would also work if we used `word` after calling `s.clear()` becaue there is no connection to state of `s` at all. We could use the value `5` with variable `s` to try to extract the word, but this would be a bug because contents of `s` have changed since we saved `5` in `word`.

It's even more problematic if we have a new problem: we want to track starting *and* ending index. We have even more values, but not tied to the state. We would have three unrelated variables floating around that need to be kept in sync.

Solution: string slices.

### String Slices
A *string slice* is reference to part of a `String`, looking like this:
```rust
let s = String::from("hello world");

let hello = &s[0..5];
let world = &s[6..11];
```
Similar to referencing whole `String` but with extra `[0..5]` bit. It references a *portion* of the `String`.

We can create slices using a range within brackets by specifying `[starting_index..ending_index]` where we reference starting from `starting_index` inclusive to `ending_index` exclusive. Internally the slice stores: starting position, and length of slice. 

Some syntactic sugar:
```rust
let s = String::from("hello");

// the 2 below are equivalent
let slice = &s[0..2];
let slice = &s[..2];

let len = s.len();

// the 2 below are also equivalent
let slice = &s[3..len];
let slice = &s[3..];

// again, the 2 below are also equivalent
let slice = &s[0..len];
let slice = &s[..];
```

Rewriting the `first_word` function:
```rust
fn first_word(s: &String): &str {
    let bytes = s.as_bytes();

    for (i, &item) in bytes.iter().enumerate() {
        if item == b' ' {
            return &s[0..i];
        }
    }

    &s[..]
}
```
Now, we get back a single value that is tied to the underlying data. The value is made up of a reference to the starting point of the lsice and number of elements in the slice.

We will get compile-time errors for the previous problem we faced when we try to clear a `String` when we have its slice:
```rust
fn main() {
    let mut s = String::from("hello world");

    let word = first_word(&s);

    s.clear(); // error!

    println!("the first word is: {}", word);
}
```

#### String Literals Are Slices
Consider this:
```rust
let s = "Hello, world!";
```
The type of `s` here is `&str`: it's a slice pointing to that specific point of the binary. This is also why string literals are immutable; `&str` is an immutable reference

#### String Slices as Parameters
We can make an improvement on the `first_word` from:
```rust
fn first_word(s: &String) -> &str 
```
to:
```rust
fn first_word(s: &str) -> &str
```

If we have string slice, we can pass that directly and if we have `String`, we can pass a slice of the entire `String`. It makes our API more general and useful.

### Other Slices
There's a more general slice type than string:
```rust
let a [1, 2, 3, 4, 5];

let slice = &a[1..3];
```
The slice has type `&[i32]`. It works the same way as string slices.

# 5. Using Structs to Structure Related Data
A *struct* or *structure*, is a custom data type that lets you name and package together multiple related values that make up a meaningful group. In OOP terms, a *struct* is like an object's data attributes. We'll compare and contrast tuples with structs. Structs and enums are the building blocks for creating new types in your program's domain to take full advantage of Rust's compile time type checking.

## 5.1. Defining and Instantiating Structs
Structs are similar to tuples, but unlike tuples, you'll name each piece of data so it's clear what the values mean. As a result, structs are more flexible than tuples: you don't have to rely on order to specify or access.

To define a struct, use the keyword `struct` and name the entire struct. Example:
```rust
struct User {
    username: String,
    email: String,
    sign_in_count: u64,
    active: bool,
}
```

To use a struct after we've defined it, we create an *instance* of that struct by specifying concrete values for each of the fields. We create instance by stating the name of the struct and then add curly brackets containing `key: value` pairs. We don't have to specify fields in same order. For example:

```rust
let user1 = User {
    email: String::from("someone@example.com"),
    username: String::from("someusername123"),
    active: true,
    sign_in_count: 1,
};
```

To get specific value, we use dot notation. If weanted email, we could use `user1.email`. If the instance is mutable, we can also change with dot notation and assign into a particular field:
```rust
user1.email = String::from("anotheremail@example.com"); // assuming you did `let mut user1`
```

Note that *entire* instance must be mutable. Rust doesn't allow to mark only certain fields as mutable. As per any expression, can just construct new instance as the last expression to implicitly return. Example:
```rust
fn build_user(email: String, username: String) -> User {
    User {
        email: email,
        username: username,
        active: true,
        sign_in_count: 1,
    }
}
```
Notice for `email` and `username`, we are repating ourselves. There is a shorthand!
### Using the Field Init Shorthand when Variables and Fields Have the Same Name
We can rewrite `build_user` to behave exactly the same, but no repetition:
```rust
fn build_user(email: String, username: String) -> User {
    User {
        email,
        username,
        active: true,
        sign_in_count: 1,
    }
}
```

### Creating Instances From Other Instances With Struct Update Syntax
We can create new instance that uses most of an old instance's values using *struct update syntax*. The following shows it without:
```rust
let user2 = User {
    email: String::from("another@example.com"),
    username: String::from("anotherusername567"),
    active: user1.active,
    sign_in_count: user1.sign_in_count,
};
```
The following shows the syntax:
```rust
let user2 = User {
    email: String::from("another@example.com"),
    username: String::from("anotherusername567"),
    ..user1
};
```

### Using Tuple Structs without Named Fields to Create Different Types
You can also define structs that look similar to tuples called *tuple structs*. They have the added meaning the struct name provides but don't have names associated with fields.

Defining it uses `struct` keyword, name, followed by types. Example:
```rust
struct Color(i32, i32, i32);
struct Point(i32, i32, i32);

let black = Color(0, 0, 0);
let origin = Point(0, 0, 0);
```
`black` and `origin` are different types. Each struct is its own type.

### Unit-Like Structs Without Any Fields
Can define structs without fields called *unit-like structs*, because they behave similarly to `()`, the unit type. It can be useful when you need to implement a trait on some type but don't have any data that you want to store in the type itself.

### Ownership of Struct Data
We used `String` type rather than `&str` string slice type in the `User` struct defined above and this is a deliberate decision. It's possible for structs

## 5.2. An Example Program Using Structs
To understand when to use structs, let's write a program to calculate area of rectangle. Say we want to define a function to compute area. We have several options:

```rust
fn area(width: u32, height: u32) -> u32 {
    width * height
}
```
The problem with above is that the two parameters aren't explictly inter-related.

Another option with tuple:
```rust
fn area(dimensions: (u32, u32)) -> u32 {
    dimensions.0 * dimensions.1
}
```
This is somewhat better as we are passing in one argument. However, we may not communicate our intent clearly with this. What does index `0` hold? It could be the height, or could be the width. If we mix this up we can cause errors.

### Refactoring with Structs: Adding More Meaning:
We use structs to add meaning by labelling the data. We can have:
```rust
fn area(rectaangle: &Rectangle) -> u32 {
    rectangle.width * rectangle.height
}
```
This is much more clearer in terms of intent. The parameter is an immutable borrow of a struct `Rectangle` instance. This is so that whichever function which calls `area` can retain ownership of it. 

### Adding Useful Functionality with Deried Traits
If we can print instance of `Rectangle`, that'd be nice. For example:
```rust
// ...
// struct declaration for Rectangle
// ...

fn main() {
    let rect1 = Rectangle {
        width: 30,
        height: 50,
    };

    println!("rect is {}", rect1);
}
```
We get an error saying that `Rectangle` doesn't implement `std::fmt::Display`. We might find a helpful note to use `{:?}` for string formatting instead. Doing that will instead say that you didn't implement `std::fmt::Debug`.

Rust *does* include functionality to print out debugging information, but we have to explicitly opt in to make that functionality available for our struct. We add annotation `#[derive(Debug)]` before struct definition:
```rust
#[derive(Debug)]
struct Rectangle {
    width: u32,
    height: u32,
}

// ...
// the main function
// ...
```

It will work, not the prettiest, but will work. `{:#?}` will give you something prettier though.

## 5.3. Method Syntax
*Methods* are similar to functions, but methods are defined from the context of a struct (or an an enum, or a trait object covered later). Their first parameter is **always** `self`, which represents the instance of the struct the method is being called on.

### Defining Methods
We can change `area` function that has a `Rectangle` instance to make it an `area` method:
```rust
#[derive(Debug)]
struct Rectangle {
    width: u32,
    height: u32,
}

impl Rectangle {
    fn area(&self) -> u32 {
        self.width * self.height
    }
}

fn main() {
    let rect1 = Rectangle {
        width: 30,
        height: 50,
    };

    println!("Area is {}", rect1.area());
}
```

We start with `impl` (implementation) block. Then we move `area` function within `impl`, and change first parameter to be `self`. In `main`, we called `area` method on our `Rectangle` instance.

Signature for `area`: we use `&self` because Rust knows the type of `self` is `Rectangle` as it is inside the `impl Rectangle` context. Note that we still need to use the `&` before `self`. Methods can take ownership of `self`, borrow `self` immutably, or borrow `self` mutably.

Here, the method is read-only, but if you wanted to write into it we can use `&mut self` as the first parameter.

### Methods with More Paramaters
Now let's define a method to see whether a `Rectangle` can fit completely within `self`. We define a `can_hold` method:
```rust
impl Rectangle {
    fn area(&self) -> u32 {
        self.width * self.height
    }

    fn can_hold(&self, other: &Rectangle) -> bool {
        self.width > other.width && self.height > other.height
    }
}
```
Since `can_hold` is a method, we define it inside the `impl Rectangle` block. The method will take an immutable borrow of another `Rectangle` as a parameter and return a boolean.

### Associated Functions
Another useful feature of `impl` blocks is that we're allowed to define functions within `impl` blocks that *don't* take `self` as a parameter. For example: `String::from` associated function.

Associated functions are often used for constructors that will return a new instance of the struct. For example, we could provide an associated function that would have one dimension parameter to create a square:
```rust
impl Rectangle {
    fn square(size: u32) -> Rectangle {
        Rectangle {
            width: size,
            height: size,
        }
    }
}
```

We can call this as such: `let sq = Rectangle::square(3);`.

### Multiple `impl` Blocks
Although this is valid, there might be no reason to do these separations here:
```rust
impl Rectangle {
    fn area(&self) -> u32 {
        self.width * self.height
    }
}

impl Rectangle {
    fn can_hold(&self, other: &Rectangle) -> bool {
        self.width > other.width && self.height > other.height
    }
}
```
However, multiple `impl` blocks can be useful when we discuss generic types and traits.

# 6. Enums and Pattern Matching
*Enumerations*, also referred to as *enums*. It allows you to define a type by enumerating its possible *variants*.

## 6.1. Defining an Enum
Motivating example: working with IP addresses, which currently has two major variants: version four and version six. We can *enumerate* all possible variants.

IP Address can be either v4 or v6 but not both at the same time. Enum is appropriate as an enum can only be one of its variants. We can express it like this:

```rust
enum IpAddrKind {
    V4,
    V6
}
```
`IpAddrKind` is now a custom data type that we can use elsewhere in our code. 

### Enum Values
Creating instances:
```rust
let four = IpAddrKind::V4;
let six = IpAddrKind::V6;
```
Variants of enum are namespaced under its indentifier. We can use double colon to separate the two. This is useful because they are both the same type: `IpAddrKind` and can define a funciton that takes any `IpAddrKind`:
```rust
fn route(ip_kind: IpAddrKind) {}
```
and thus can call either variant:
```rust
route(IpAddrKind::V4);
route(IpAddrKind::V6);
```

Some potential useful thing about enum:
```rust
enum IpAddrKind {
    V4,
    V6,
}

struct IpAddr {
    kind: IpAddrKind,
    address: String,
}

let home = IpAddr {
    kind: IpAddrKind::V4,
    address: String::from("127.0.0.1"),
};

let loopback = IpAddr {
    kind: IpAddrKind::V6,
    address: String::from("::1"),
};
```
Above we defined a struct with two fields. We also gave two instances of this struct. We've used struct to bundle the `kind` and `address` values together. So now the variant is associated with the value.

But we can use enum to be **more concise**. We can put data directly int oeach enum variant:
```rust
enum IpAddr {
    V4(String),
    V6(String),
}

let home = IpAddr::V4(String::from("127.0.0.1"));

let loopback = IpADdr::V6(String::from("::1"));
```

Another possible advantage: each variant can have different types and amounts of associated data:
```rust
enum IpAddr {
    V4(u8, u8, u8, u8),
    V6(String),
}

let home = IpAddr::V4(127, 0, 0, 1);

let loopback = IpAddr::V6(String::from("::1"));
```
Note: the standard library has a definition we can use!

Another example, with a wide variety of types embedded:
```rust
enum Message {
    Quit,
    Move { x: i32, y: i32},
    Write(String),
    ChangeColor(i32, i32, i32),
}
```
Four variants in there:
* `Quit` has no data associated with it at all.
* `Move` includes anonymous struct.
* `Write` includes a single `String`.
* `ChangeColor` includes three `i32`

Here we see a version using struct instead of enum:
```rust
struct QuitMesage; // unit struct
struct MoveMessage {
    x: i32,
    y: i32,
}
struct WriteMessage(String); // tuple struct
struct ChangeColorMessage(i32, i32, i32); // tuple struct
```
However a drawback of using many structs is that each of them have their own type and we can't easily define a function to take any of these kinds of messages as we could with `Message` enum.

Similarity between enums and structs: we can define methods on enums:
```rust
impl Message {
    fn call(&self) {
        // method body
    }
}

let m = Message::Write(String::from("hello"));
m.call();
```
Should be pretty self explanatory! The method call will make use of the immutable borrow `self` and do something with it.

### The `Option` Enum and its Advantages Over Null Values
Used to encode whether a value is something or it could be nothing. Expressing this concept in terms of the type system means the compiler can check wheter you've handled all cases you should be handling.

Rust doesn't have the null feature that many other languages have. Problem with null is that if you try to use a null value as a not-null value, you'll get an error of some kind. But the concept is still useful.

While Rust does not have nulls, it has an enum `Option<T>` that is defined like this:
```rust
enum Option<T> {
    Some(T),
    None,
}
```
This is so useful that it's even included in the prelude. Its variants: `Some` and `None` can be used directly without the `Option::` prefix.

`<T>` is a generic. It can hold one piece of data of any type. Examples:
```rust
let some_number = Some(5);
let some_string = Some("a string");

let absent_number: Option<i32> = None;
```
If we use `None` rather than `Some`, we need to tell rust what type of `Option<T>` we have because compiler cannot infer things.

Despite `None` being a similar concept as null, `Option<T>` is a better option than null because `Option<T>` and `T` are different types. The compiler won't let us use an `Option<T>` value as if it were definitely a valid value. For example:
```rust
let x: i8 = 5;
let y: Option<i8> = Some(5);

let sum = x + y;
```
The error we get is that Rust doesn't understand how to add an `i8` and an `Option<i8>`, because the're different. Only when we have `Option<i8>` do we have to worry about possibly not having a value, and the compiler will make sure we handle that before using the value.

i.e. need to convert `Option<T>` to a `T`. It helps catch one of the most common issues with null: assuming something isn't null when it actually is.

Everywhere that a value has a type that isn't `Option<T>`, you *can* safely assume that the value isn't null. If something is possibly null, you ned to wrap it, and when you do you need to deliberately handle the case explicitly when it is null.

In general, in order to use an `Option<T>`, you want to have code that handles each variant `Some(T)` and `None`. The `match` expression is a control flow construct that does just this: will run different code depending on which variant of the enum it has.

## 6.2. The `match` Control Flow Operator
`match` is like a coin-sorting machine. It keeps finding for the first track that "fits". Example:

```rust
enum Coin {
    Penny,
    Nickel,
    Dime,
    Quarter,
}

fn value_in_cents(coin: Coin) -> u8 {
    match coin {
        Coin::Penny => 1,
        Coin::Nickel => 5,
        Coin::Dime => 10,
        Coin::Quarter => 25,
    }
}
```
This is similar to an `if`, but note that here it can be any type!

The `match` arms has two parts: a pattern and some code. The first arm here has a pattern that is the value of `Coin::Penny` and then the `=>` operator separates the pattern and code to run. Here code is just `1`. Each arm is separated from the next with a comma.

Code associated with each arm is an expresison, and the resulting value of the expression in the matching arm is the value that gets returned for the entire `match` expression.

If short, no need curly braces for the code in an arm. Run multiple lines you can use curly braces though:
```rust
fn value_in_cents(coin: Coin) -> u8 {
    match coin {
        Coin::Penny => {
            println!("Lucky!");
            1
        } // christian's note: apparently you don't need a comma
        Coin::Nickel => 5,
        Coin::Dime => 10,
        Coin::Quarter => 25,
    }
}
```

### Patterns that Bind to Values
Match arms are useful because they can bind to the parts of the values that match the pattern. This is extracting values out of enum variants.

Let's have for example:
```rust
#[derive(Debug)] // so we can inspect the state in a minute
enum UsState {
    Alabama,
    Alaska,
    // --snip--
}

enum Coin {
    Penny,
    Nickel,
    Dime,
    Quarter(UsState),
}
```
Let's imagine that we are trying to collect all 50 state quarters. But we will call out the name of the state associated with each quarter. In the match expression, we add a variable called `state`. When a `Coin::Quarter` matches, the `state` variable will bind to the value of that quarter's state:
```rust
fn value_in_cents(coin: Coin) -> u8 {
    match coin {
        Coin::Penny => 1,
        Coin::Nickel => 5,
        Coin::Dime => 10,
        Coin::Quarter(state) => {
            println!("State quarter from {:?}!", state);
            25
        }
    }
}
```
If we were to call `value_in_cents(Coin::Quarter(UsState::Alaska))`, `coin` would be `Coin::Quarter(UsState::Alaska)`. When we found the matching arm, we bind the `state` to the value `UsState::Alaska`.

### Matching with `Option<T>`
We wanted to get inner `T` out of `Some` when using `Option<T>`. We can ue `match` here:
```rust
fn plus_one(x: Option<i32>) -> Option<i32> {
    match x {
        None => None,
        Some(i) => Some(i + 1),
    }
}

let five = Some(5);
let six = plus_one(five);
let none = plus_one(None);
```
Combining `match` and enums is useful in many situations. This pattern is very common in Rust code: `match` against an enum, bind a variable to the data inside, and then execute code based on it.

### Matches Are Exhaustive
This won't compile:
```rust
fn plus_one(x: Option<i32>) -> Option<i32> {
    match x {
        Some(i) => Some(i + 1),
    }
}
```
Because we didn't handle the `None` case and this code will cause a bug.

Matches in Rust are *exhaustive*: must exhaust every last possibility in order for the code to be valid.

### The `_` Placeholder
Well, just in case we don't want to list all possible values, Rust provides us with a way also:
```rust
let some_u8_value = 0u8;
match some_u8_value {
    1 => println!("one"),
    3 => println!("three"),
    5 => println!("five"),
    7 => println!("seven"),
    _ => (),
}
```
The `_` pattern will match any value, and by putting it after our other arms, it will match all the possible cases not specified before it. The `()` is just unit value, and nothing will happen in the `_` case. As a result we can say that we want to do nothing using the unit value.

### 6.3. Concise Control flow with `if let`
It combines `if` and `let` into a less verbose way to handle values that match one pattern while ignoring the rest. Consider this:
```rust
let some_u8_value = Some(0u8);
match some_u8_value {
    Some(3) => println!("three"),
    _ => (),
}
```
This is fine, but we can consider doing this instead:
```rust
if let Some(3) = some_u8_value {
    println!("three");
}
```
The syntax for `if let` takes a pattern and an expression separated by an equal sign. It works the same way as a `match`, where the expression is given to the `match` and the pattern is its first arm.

Choosing between `match` and `if let` depends on what you're doing: whether gaining conciseness is an appropriate trade-off for losing exhaustive checking.

We can include `else` with an `if let`. It's the same as the block of code that would go with the `_` case. Consider the normal version:
```rust
let mut count = 0;
match coin {
    Coin::Quarter(state) => println!("State quarter from {:?}!", state),
    _ => count += 1,
}
```
or we could use `if let` with `else`:
```rust
let mut count = 0;
if let Coin::Quarter(state) = coin {
    println!("State quarter form {:?}!", state);
} else {
    count += 1;
}
```
# 7. Managing Growing Projects with Packages, Crates, and Modules
As programs get large, organizing your code will be important. You should group related functionality and separate code with distinct feeatures.

Programs so far are one module in one file. A package can contain multiple binary crates and optionally one library crate. As a package grows, you can extract parts into separate crates that become external dependencies. 

You can also reuse code at higher level: other code can call that code via the code's public internface without knowing how the implementation works.

Related concept is scope: the nested context in which code is written has a set of names that are defined as "in scope." You can create scopes and change which names are in or out of scope. You can't have two items with the same name in the same scope; tools are available to resolve name conflicts.

Rust features to organise called the *module system*:
* **Packages**: A Cargo feature that lets you build, test, and share crates
* **Crates**: A tree of modules that produces a library or executable
* **Modules** and **use**: Let you control the organization, scope and privacy of paths
* **Paths**: A way of naming an item, such as a struct, function, or module

## 7.1. Packages and Crates
A crate is a binary or library. The *crate root* is a source file that the Rust compiler starts from and makes up the root module of the crate.

A *package* is one or more crates that provide a set of functionality. A package contains a *Cargo.toml* file that describes how to build those crates.

Several rules determine what a package can contain:
* A package *must* contain zero or one library crates, and no more. 
* It contain as many binary crates as you'd like, but it must contain at least one crate (either library or binary)

When we enter `cargo new` command:
```
$ cargo new my-project
     Created binary (application) `my-project` package
$ ls my-project
Cargo.toml
src
$ ls my-project/src
main.rs
```

Cargo created a *Cargo.toml* file, giving us a **package**. There is no mention of *src/main.rs* in the *Cargo.toml*, because of the convention that the src/main.rs is the crate root of a binary crate with the same name as the package. Likewise, Cargo knows that if the package directory contains src/lib.rs, this is the root of library crate. Cargo passes the crate root files to `rustc`.

Our package only contains *src/main.rs* -- only a binary crate named `my-project`. If it contains both main.rs and lib.rs, then we have two crates: library and binary, both with same name as package. A package can have multiple binary crates by putting it in the *src/bin* irectory.

A crate groups related functionality together in a scope so the functionality is easy to share between multiple projects.

Keeping a crate's functionality in its own scope clarifies whether particular functionality is defined in our crate or the `rand` crate and prevents potential conflicts. Example: we could have defined a `struct` named `Rng` in our own crate, but compiler won't be confused with the `rand::Rng` because crate's functionality is namespaced in its own scope.

## 7.2. Defining Modules to Control Scope and Privacy
We'll talk about:
* *paths* which allows you to name items
* the *use* keyword that brings a path into scope
* the *pub* keyword to make items public
* Discuss *as* keywrod, external packages, and glob operator.

*Modules* let us organize code within crate. Modules also control the *privacy* of items, which is wheter it is public or privates.

Example here we will create library crate for restaurant functionality. We'll define signatures but leave empty bodies.

In restaurant industry, some parts are referred to as *front of house* and others as *back of house*. Front is where customers are. Back is where chefs work.

To structure, we can organise the functions into nested modules. Create a new library named `restaurant` by running `cargo new --lib restaurant`. Then we put the following signatures in *src/lib.rs* :
```rust
mod front_of_house {
    mod hosting {
        fn add_to_waitlist() {}

        fn seat_at_table() {}
    }

    mod serving {
        fn take_order() {}

        fn serve_order() {}

        fn take_payment() {}
    }
}
```

We define a module by starting with the `mod` keyword, and specifying the name of module (in this case, `front_of_house`). We can have modules inside modules, as seen and we have `hosting` and `serving`. Modules can also hold definitions for things such as structs, enums, constants, etc

In modules, we group related definitions together and say why they're related.

Earlier, there is a mention that *src/main.rs* and *src/lib.rs* are called crate roots. The reason for their name is that the contents of either of these two files form a module named *crate* at the root of the crate's module structure, known as *module tree*

Module tree for our package:
```
crate
 └── front_of_house
     ├── hosting
     │   ├── add_to_waitlist
     │   └── seat_at_table
     └── serving
         ├── take_order
         ├── serve_order
         └── take_payment
```

This tree shows:
* how some of modules nest inside one another (`hosting` inside `front_of_house`). 
* some modules are *siblings* to each other (`hosting` and `serving` are defined within `front_of_house`)

If module A is contained is inside B, we say A is *child* of B. B is *parent* of A. The entire module tree is rooted under the implicit module named *crate*

## 7.3. Paths for Referring to an Item in the Module Tree
To show Rust where to find an item in a module tree, it's the same as filesystem. If we want to call a function, we need to know its path.

Path has two forms:
* An *absolute path* starts from a crate root by using crate name or a literal *crate*
* A *relative path* starts from the current module and uses *self*, *super*, or an identifier in the current module

Both types are followed by one or more identifiers, separated by double colons (`::`).

How to call `add_to_waitlist` function? Same as asking: what's the path of the `add_to_waitlist` function? We'll show two ways. This is the first:

```rust
// NOTE: this won't compile
mod front_of_house {
    mod hosting {
        fn add_to_waitlist() {}
    }
}

pub fn eat_at_reastaurant() {
    // Absolute path
    crate::front_of_house::hosting::add_to_waitlist();

    // Relative path
    front_of_house::hosting::add_to_waitlist();
}
```

For absolute path: after `crate`, we include each of successive modules until we make our way to `add_to_waitlist`. 

For relative path: we start with `front_of_house`, which is the name of the module defined at the same level of the module tree as `eat_at_restaurant`

Choosing between either depends on your project. Depends on whether you're more likely to move item definition code separately from or together with the code that uses the item. 

E.g. if we move `front_of_house` module and the `eat_at_restaurant` function into another module, we'd need to update the absolute path to `add_to_waitlist`, but relative still valid. But if we only moved the function, the absolute path is valid, but relative path isn't. Rust's preference is to specify absolute paths.

However, above will give compile error saying that module `hosting` is private. We have the correct paths, but Rust won't let us use them because it doesn't have access to the private sections.

Module also define Rust's *privacy boundary*: the line that encapsulates the implementation details external code isn't allowed to know about. So anything private, put it in a module.

Everything is private by default in Rust. Items in a parent module can't use the private items inside child modules, but items in child modules can use the items in their ancestor modules. This is because child wrap and hide their implementation details, but it can see the context in which they're defined.

Rust chose to have the module system function this way so that hiding inned implementation details is the default. That way you know which parts of inner code you can change without breaking outer code. But you can expose inner parts of child modules code to outer ancestor modules by using `pub` keyword.

### Exposing Paths with the `pub` Keyword
Since previously privacy is the issue, let's try this instead:
```rust
mod front_of_house {
    pub mod hosting {
        fn add_to_waitlist() {}
    }
}

pub fn eat_at_restaurant() {
    // Absolute path
    crate::front_of_house::hosting::add_to_waitlist();

    // Relative path
    front_of_house::hosting::add_to_waitlist();
}
```
BUT still error! What happened is that `mod hosting` makes the module public, but *contents* of `hosting` are still private. Module public != ocontents public. 

So to fix this, we make the function public as well:
```rust
mod front_of_house {
    pub mod hosting {
        fn add_to_waitlist() {}
    }
}
```
Now the code will compile! Let's study the privacy rules and how adding `pub` will make things differ.

Absolute: we start with `crate` then `front_of_house`. Even tho `foh` is not public, but because this function is in the same module (they are siblings), we can refer to `foh` from inside function. Next is the `hosting` which is marked with `pub`. We can access the parent module of `hosting`, so we can access `hosting`. Finally, the `add_to_waitlist` function is public and we can access `hosting` (parent).

Relative: Pretty much the same thing and the only difference is that we are calling starting from `front_of_house` defined in the same module.

### Starting Relative Paths with `super`
We can construct relative paths that begin in parent module by using `super` at the start of the path and this is analogous to `..` in filesystem path.

We may want to do this in this scenario:
```rust
fn serve_order() {}

mod back_of_house {
    fn fix_incorrect_order() {
        cook_order();
        super::serve_order();
    }

    fn cook_order() {}
}
```
We think of `back_of_house` module and the `serve_order` function as being likely to stay in the same relationship, so they will be moved together if we ever do that. 

### Making Structs and Enumbs Public
We can also use `pub` to designate structs and enums as public. Details: if we use `pub` for struct definition, we make struct public but its fields will still be private. Field can be publicised on a case-by-case basis. Example:

```rust
mod back_of_house {
    pub struct Breakfast {
        pub toast: String,
        seasonal_fruit: String,
    }

    impl Breakfast {
        pub fn summer(toast: &str) -> Breakfast {
            Breakfast {
                toast: String::from(toast),
                seasonal_fruitL String::from("peaches"),
            }
        }
    }
}

pub fn eat_at_restaurant() {
    // Order a breakfast in the summer with Rye toast
    let mut meal = back back_of_house::Breakfast::summer("Rye");

    // Change our mind about the bread
    meal.toast = String::from("Wheat");
    println!("I'd like {} toast please", meal.toast);

    // The next line won't compile if we uncomment it
    // seasonal fruit is private
    // meal.seasonal_fruit = String::from("blueberries");
}
```

Major difference: if we make an enum public, all of its variants are then public. We only need the `pub` before the `enum` keyword:
```rust
mod back_of_house {
    pub enum Appetizer {
        Soup,
        Salad,
    }
}

pub fn eat_at_restaurant() {
    let order1 = back_of_house::Appetizer::Soup;
    let order2 = back_of_house::Appetizer::Salad;
}
```
Enums are useful only if their variants are public. Pretty annoying to annote all variants `pub` every time. Structs are often useful without fields being public.

## 7.4. Bringing Paths into Scope with the `use` Keyword
Paths are often inconveniently long and repetitive. We can simplify this process by bringing a path into scope once, and then call the items in that path as if they're local with the `use` keyword.

Example:
```rust
mod front_of_house {
    pub mod hosting {
        pub fn add_to_waitlist() {}
    }
}

use crate::front_of_house::hosting;

pub fn eat_at_restaurant() {
    hosting::add_to_waitlist();
    hosting::add_to_waitlist();
    hosting::add_to_waitlist();
}
```
Adding `use` and a path in a scope is similar to creating a symbolic link. By adding the `use ....` in our code snippet, `hosting` is now valid name in that scope. Privacy will also be checked so don't have to worry about that.

We can also use a relative path with `use`:
```rust
mod front_of_house {
    pub mod hosting {
        pub fn add_to_waitlist() {}
    }
}

use self::front_of_house_hosting;

pub fn eat_at_restaurant() {
    hosting::add_to_waitlist();
    hosting::add_to_waitlist();
    hosting::add_to_waitlist();
}
```

### Creating Idiomatic `use` Paths
You may wonder why we don't do this instead: `use crate::front_of_house::hosting::add_to_waitlist;` and start using `add_to_waitlist()` immediately. What was previously suggested is the idiomatic way to bring function into scope with `use`. It makes it clear that the function isn't locally defined. 

On the other hand, when bringing in structs, neums and other items, it is idiomatic to use full path:
```rust
use std::collections::HashMap;

fn main() {
    let mut map = HashMap::new();
    map.insert(1, 2);
}
```
This is just a convention. An exception though is when we're bringing two items with same name in scope:

```rust
use std::fmt;
use std::io;

fn function1() -> fmt::Result {
    // -- snip --
}

fn function2() -> io::Result<()> {
    // -- snip --
}
```
In the code above, the two `Result`s are distinguished by the module which they came from.

### Providing New Names with the `as` Keyword
Another solution for above:
```rust
use std::fmt::Result;
use std::io::Result as IoResult;

fn function1() -> Result {
    // -- snip --
}

fn function2() -> IoResult<()> {
    // -- snip --
}
```
The name `IoResult` won't conflict with the `Result` from `std::fmt` that we've brought into scope.

### Re-exporting Names with `pub use`
When we bring a name into scope with `use`, the name available in the new scope is private. To enable the code that calls our code to refer to it, use `pub` and `use`. This is called *re-exporting* because we're bringing an item into scope but also making that item available for others to bring into their scoep.

```rust
mod front_of_house {
    pub mod hosting {
        pub fn add_to_waitlist() {}
    }
}

pub use crate::front_of_house::hosting;

pub fn eat_at_restaurant() {
    hosting::add_to_waitlist();
}
```

By using `pub use`, external code can call the `add_to_waitlist` function using `hosting::add_to_waitlist`. `eat_at_restaurant` doesn't really get affected, but external code cannot take avantage of the new path.

Re-exporting is useful when the internal structure of your code is different from how programmers calling code would think about the domain.

### Using External Packages
To use `rand` in our project, we did this to *Cargo.toml*:
```rust
[dependencies]
rand = "0.5.5"
```
It tells us to download the `rand` package and any dependencies from crates.io and make `rand` available to our project.

We bring `Rng` trait into scope like this:

```rust
use rand::Rng;

fn main() {
    let secret_number = rand::thread_rng().gen_range(1, 101);
}
```
There are many packages avialable at crates.io. Standard library `std` is a crate that's external to our package. It is shipped with Rust language, we don't need to change *Cargo.toml*, but we need to refer to it using `use` to bring items in.

### Using Nested Paths to Clean Up Large `use` Lists
We can turn this:
```rust
use std::cmp::Ordering;
use std::io;
```
into this:
```rust
use std::{cmp::Ordering, io};
```

In bigger programs, bringing many items into scope from the same package or module using nested paths can reduce the number of separate `use` statements.

We can transform from this:
```rust
use std::io;
use std::io::Write;
```
to this too:
```rust
use std::io::{self, Write};
```

### The Glob Operator
If we want to bring in *all public items*, we can use the glob operator `*`:
```rust
use std::collections::*;
```
Can be useful when testing to bring everything under test into `tests` module.

## 7.5. Separating Modules into Different Files
When modules get large, definitions may want to be separated for easy navigation. Example:
File: src/lib.rs
```rust
mod front_of_house;

pub use crate::front_of_house::hosting;

pub fn eat_at_restaurant() {
    hosting::add_to_waitlist();
    hosting::add_to_waitlist();
}
```

And *src/front_of_house.rs* gets the definitions from the body of the `front_of_house` module.

File: src/front_of_house.rs
```rust
pub mod hosting {
    pub fn add_to_waitlist() {}
}
```

Using a semicolon after `mod front_of_house` rather than block tells Rust to load the contents of the module from another file with *the same name as the module*. To continue with our example, and extract the `hosting`, we can do this:

File: src/front_of_house.rs
```rust
pub mod hosting;
```
File: src/front_of_house/hosting.rs
```rust
pub fn add_to_waitlist() {}
```

The module tree remains the same, and all the function calls will work without any modification. The `mod` keyword declares modules, and Rust looks in a file with the same name as the module for the code that goes into that module.

# 8. Common Collections
*Collections* can contain multiple values. Unlike built-in array and tuple types, the data these collections point to is stored on the heap, which means it can grow and shrink.

We'll discuss three collections: *vector*, *string* and *hash map*.

## 8.1. Storing Lists of Values with Vectors
`Vec<T>` is also known as *vector*, more than one value in a single data structure and puts values next to each other in memory. Only one value of the same type.

### Creating a New Vector
To create a new, empty vector, we can call the `Vec::new` function:
```rust
let v: Vec<i32> = Vec::new();
```
We added a type annotation, because we aren't inserting any values into this vector and Rust doesn't know what kind of elements we are storing.

If we are being more realistic, Rust can often infer the type of value you want to store once you insert values. It's more common to create a `Vec<T>` that has initial values and Rust provides `vec!` macro. It will create a new vector that holds the values you give it. This example stores values `1`, `2`, `3`, and Rust infers the `i32` type:
```rust
let v = vec![1, 2, 3];
```

### Updating a Vector
Use `push` method:
```rust
let mut v = Vec::new();
v.push(5);
v.push(6);
```
As with variable, if we want to change its value, we need to use `mut`.

### Dropping a Vector Drops Its Elements
Like any other `struct`, a vector is freed when it goes out of scope:
```rust
{
    let v = vec![1, 2, 3, 4];
}
```
When vector gets dropped, all of its contents are dropped. Those integers are cleaned up. Useful when you introduce reference to elements of vector.

### Reading Elements of Vectors
There are two ways to reference a value stored in vector. We annotate the types of values returned for extra clarity.
```rust
let v = vec![1, 2, 3, 4, 5];

let third: &i32 = &v[2];
println!("The third element is {}", third);

match v.get(2) {
    Some(third) => println!("The third element is {}", third),
    None => printlnt!("There is no third element."),
}
```
First we use the index value of `2` to get third element. Two ways to get third element are by using `&` and `[]` which gives us a reference, OR by using `get` method with the index passed as argument, giving us an `Option<&T>`.

You can choose how the program behaves when you try to use an index value that vector doesn't have element for. Let's try this:
```rust
// This code panics!
let v = vec![1, 2, 3, 4, 5];

let does_not_exist = &v[100];
let does_not_exist = v.get(100);
```
The first `[]` method will cause program to panic. When `get` method is passed an index outside of vector, it returns `None` without panicking. You can use this with a `match` expression to handle either cases.

When the program has a valid reference, the borrow checker enforces the ownership and borrowing rules to ensure this reference and any other references remain valid. Recall: you can't have mutable and immutable references in the same scope.

```rust
// Won't compile
let mut v = vec![1, 2, 3, 4, 5];

let first = &v[0]; // immutable borrow occurs

v.push(6); // mutable borrow

println!("The first element is: {}", first); // immutable borrow used here
```
This error is because adding new element onto end of vector might require allocating new memory and copying the old elements to the new space. Borrowing rules prevent programs from ending up in situation of reference to first element pointing to deallocated memory.

### Iterating over the Values in a Vector
We can iterate through elements rather than use indices to access one at a time. We get immutable references here.
```rust
let v = vec![100, 32, 57];
for i in &v {
    printlnt!("{}", i);
}
```
Mutable reference version:
```rust
let mut v = vec![100, 32, 57];
for i in &mut v {
    *i += 50;
}
```
We have to use the dereference operator (`*`) to get to the value in `i` before we can use `+=` operator.

### Using an Enum to Store Multiple Types
Variants of an enum are defined under the same enum type, so we when we need to store elements of a different type in vector, we can define and use an enum.

For example we can do this:
```rust
enum SpreadsheetCell {
    Int(i32),
    Float(f64),
    Text(String),
}

let row = vec![
    SpreadsheetCell:Int(3),
    SpreadsheetCell::Text(String::from("blue")),
    SpreadsheetCell::Float(10.12),
];
```
Rust needs to know what types will be in the vector at compile time to properly allocate memory on the heap. Using an enum plus a `match` expression means that Rust will ensure at compile time that every possible case is handled.

## 8.2. Storing UTF-8 Encoded Text with Strings
Common problems:
* Rust's propensity for exposing possible errors
* Strings being a more complicated data structure that many programmers give them credit for
* UTF-8

String is a collection of bytes, plus some methods to provide useful functionality when those bytes are interpreted as text. 

### What Is a String?
Rust has only one string type in the core language, which is the string slice `str` that is usually in its borrowed form `&str`. *String slices* are references to some UTF-8 encoded string data stored elsewhere.

The `String` type, is a growable, mutable, owned, UTF-8 encoded String type.

Rust's std also include other string types: `OsString`, `OsStr`, `CString`, and `CStr`. These can store text in different encodings.

### Creating a new String
Ez example:
```rust
let mut s = String::new();
```
Sometimes we already have some initial data. We use `to_string` which is available on any type that implements the `Display` trait, as string literals do

```rust
let data = "initial contents";

let s = data.to_string();

// the method also works on a literal directly:
let s = "initial contents".to_string();
```
We can also use `String::from`:
```rust
let s = String::from("initial contents");
```

Recall that strings are UTF-8 encoded, so we can include any properly encoded data in them. See the book for examples.

### Updating a String
You can push data into string, or conveniently use `+` operator or the `format!` macro to concatenate.

#### Appending to a String with `push_str` and `push`
We can grow a `String` by using `push_str` method to append a string slice:
```rust
let mut s = String::from("foo");
s.push_str("bar");
```
`push_str` takes a string slice, because we don't want ownership of parameter. Take a look:
```rust
let mut s1 = String::from("foo");
let s2 = "bar";
s1.push_str(s2);
println!("s2 is {}", s2);
```
This code works as we'd expect because `push_str` doesn't take ownership!

`push` on the other hand only takes a single character:
```rust
let mut s = String::from("lo");
s.push('l');
```

#### Concatenation with the `+` Operator or the `format!` Macro
You often want to combine two existing strings. One way is to use `+` operator:
```rust
let s1 = String::from("Hello, ");
let s2 = String::from("world!");
let s3 = s1 + &s2; // note s1 has been moved here and can no longer be used
```
The reason `s1` is no longer valid and why we reference `s2` is because of the signature of the method called when using `+`:
```rust
fn add(self, s: &str) -> String {
```
`add` is defined with generics, but in this case we study `String`.

First, `s2` has an `&` meaning that wer're referencing the second string to the first string. But wakit -- the type ofo `&s2` is `&String`, not `&str`:

The reason why code compiles is because compiler can *coerce* the `&String` argument into a `&str`. Rust will use *reref coercion*, which here turns `&s2` into `&s2[..]` during `add` method calls.

Second, `add` takes ownership of `self`. So that's why `let s3 = s1 + &s2;` will take ownership of `s1`. 

If we need to concat multiple string, it gets weirder:
```rust
let s1 = String::from("tic");
let s2 = String::from("tac");
let s3 = String::from("toe");

let s = s1 + "-" + &s2 + "-" + &s3;
```
It gets difficult to see what's going on, so we can use a macro and do this instead:
```rust
let s = format!("{}-{}-{}", s1, s2, s3);
```
`format!` doesn't take ownership of any of its parameters.

### Indexing into Strings
Accessing individual caharacters in a string by referencing index is valid. BUT in Rust, it will give you error:
```rust
// Compile error!
let s1 = String::from("hello");
let h = s1[0];
```

#### Internal Representation
A `String` is a wrapper over `Vec<u8>`:
```rust
let hello = String::from("hola");
```
In this case, `len` will be 4, which means that vector storing string "Hola" is 4 bytes long and each of these letters take 1 byte.

But we have here:
```rust
let hello = String::from("Здравствуйте");
```
Which has `len` 24! Not 12. This is because the encoding in UTF-8, each Unicode scalar value in that string takes 2 bytes of storage. Therefore an index into string's bytes will not always correlate to a valid Unicode scalar value. This is why indexing isn't valid because it will be confusing to decide which value to return.

#### Bytes and Scalar Values and Grapheme Clusters
UTF-8 another point: three relevant ways to look at strings from Rust's perspective: as bytes, scalar values and grapheme clusters.

The book has an example in Hindi, which I will not copy here.

Another reason not to index into a `String`: it is expected to be constant time operation, but not possible to guarantee with a `String`, because Rust would have to walk through the contents from beginning to index to determine how many valid characters there were.

### Slicing Strings
Rust asks you to be more specific, so we slice strings instead of indexing. Example:
```rust
let hello = "Здравствуйте";
let s = &hello[0..4];
```
Here `s` will be ` &str` that contains the first 4 bytes of that String. Which means `s` will be `Зд`. Since each "character" here in this example is 2 bytes.

`&hello[0..1]` would cause Rust to panic at runtime. Use slies with caution!

### Methods for Iterating Over Strings
If you need to perform operations on individual Unicode scalar values, use the `chars()` method:
```rust
for c in "Зд".chars() { ... }
```

The `bytes` method returns raw byte:
```rust
for b in "Зд".bytes() { ... } // this returns numbers representing bytes
```
Remember: valid Unicode scalar values may be made up of more than 1 byte.

Grapheme cluster access is complex and not provided in std. Find things in crates.io instead.

### Strings are not simple
Programmers have to put more thought into handling UTF-8 data upfront. This trade-off exposes more of the complexity of strings than is apparent in other programming languages, but it prevents you from having to handle errors involving non-ASCII characters later in your developement life cycle.

## 7.3. Storing Keys with Associated Values in Hash Maps
The type `HashMap<K, V>` sotres a mapping of keys of type `K` to values of type `V`. It does this via a *hash function*.

### Creating a New Hash Map
You can create a new empty hash map with `new` and add elements with `insert`. 

```rust
use std::colelctions::HashMap;

let mut scores = HashMap::new();

scores.insert(String::from("Blue"), 10);
scores.insert(String::from("Yellow"), 50);
```
We keep track scores of two teams Blue and Yellow. Among the three we covered, we need to use the `use` keyword. This one is the least often used, so it's not included in the features brought into scope automatically in the prelude. There's no built-in macro to construct them.

Hash maps store data on the heap. Like vectors, hash maps are homogeneous: all of the keys must have the same type, and all of the values must have the same type.

To construct a hashmap, we can use iterators and the `collect `method on a vector of tuples. Example:
```rust
use std::collections::HashMap;

let teams = vec![String::from("Blue"), String::from("Yellow")];
let initial_scores = vec![10, 50];

let mut scores: HashMap<_, _> =
    teams.into_iter().zip(initial_scores.into_iter()).collect();
```
We use the `zip` method to create a vector of tuples where "Blue" is paired with 10 and so on.

The type annotation `HashMap<_, _>` is needed here because it's possible to collect many different structures, and Rust doesn't know which you want unless you specify.

### Hash Maps and Ownership
For types implementing `Copy` trait, like `i32`, the values are copied into hashmap. For values like `String`, the values will be moved and the hash map will own those values:
```rust
use std::collections::HashMap;

let field_name = String::from("Favorite color");
let field_value = String::from("Blue");

let mut map = HashMap::new();
map.insert(field_name, field_value);
// field_name and field_value are invalid at this point, try using them
// and see compiler error you get
```
We can't use variables `field_xxx` after they've been moved into the hash map with the call to `insert`. If we insert references to values into hash map, the values that the references point to must be valid for at least as long the hash map is valid.

### Accessing Values in a Hash Map
We provide the key to the `get` method:
```rust
use std::collections::HashMap;

let mut scores = HashMap::new();

scores.insert(String::from("Blue"), 10);
scores.insert(String::from("Yellow"), 50);

let team_name = String::from("Blue");
let score = scores.get(&team_name);
```
Here, `score` will have the value that's associated with the Blue team, and the result will be `Some(&10)`. If there is no such value, you will get `None`.

We can iterate over each k/v pair in a hash map in a similar manner as vector, using a `for` loop:
```rust
for (key, value) in &scores {
    println!("{}: {}", key, value);
}
```
bBut this will print in an arbitrary order.

### Updating a Hash Map
#### Overwriting a Value
If we insert a key and value, and then insert the same key with a different value, the value associated with that key will be replaced:
```rust
scores.insert(String::from("Blue"), 10);
scores.insert(String::from("Blue"), 50);

println!("{:?}", scores);
```

#### Only Inserting a Value If the Key has no value
It's common to check whether a particular key has a value, and if it doesn't, insert value for it. Hash Maps have this API called `entry` that takes the key you want to check as a param, and return the value of `entry` method with an enum called `Entry` (for whether it might or might not exist).

```rust
scores.insert(String::from("Blue"), 10);

scores.entry(String::from("Yellow")).or_insert(50);
scores.entry(String::from("Blue")).or_insert(50);
```
The `or_insert` method on `Entry` is defined to return a mutable reference to the value of the corresponding `Entry` key if it exists. If it doesn't, it will insert the parameter as the new value for this key, returning a mutable reference to that neew value.

#### Updating a Value Based on the Old Value
Let's say we are counting occurences of a words. We can increment the value of how many times we've seen that word:
```rust
for word in text.split_whitespace() {
    let count = map.entry(word).or_insert(0);
    *count += 1;
}
```
Recall: the `or_insert` method returns a mutable reference (&mut V) to the avlue for this key. Here we store that mutable reference in the `count` variable. We must first dereference `count` using the asterisk. The mutable reference goes out of scope at the end of the `for` loop so this is safe.

### Hashing Functions
`HashMap` uses a "crytopgraphically strong" hash function, which is resistant to Denial of Service (DoS) attacks. Not fast, but secure. For other options, visit the book again which gives more details.

# 9. Error Handling
Rust requires you to acknowledge the possibility of an error, and take some action before your code will compile.

Rust groups errors into two major categories: *recoverable* and *unrecoverable* errors. For a recoverable error, such as file not found error, it's reasonable to report and retry. Unrecoverable ones are symptoms of bugs, like trying to access aray index out of bounds.

Most languages don't distinguish between these two kinds of errors by using Exceptions. Rust doesn't have exceptions. Instead, it has the type `Result<T, E>` for recoverable errors and the `panic!` macro that stops execution when the program encounters unrecoverable error.

## 9.1. Unrecoverable Errors with `panic!`
Sometimes, bad things happen, and there's nothing you can do about it. Sad :(

When the `panic!` macro executes, your program will print a failure message, unwind and clean up the stack, and then quit. This occurs when a bug of some kind has been detected and it's not clear to the programmer how to handle the error.

### Unwinding the Stack or Aborting in Response to a Panic
By default, when panic, the program starts *unwinding*. Which means Rust walks back up the stack and cleans up data from each function it encounters. 

This is a lot of work, but we can immediately *abort*, which ends without cleaning up. Memory that program was using will be cleaned up by OS.

If you want to make resulting binary as small as possible, can switch from unwinding to aborting by doing this to *Cargo.toml*:
```rust
[profile.release]
panic = 'abort'
```

Let's try calling `panic!` in a simple program:
```rust
fn main() {
    panic!("At The Disco");
}
```

In some cases, the `panic!` call might be in code that our code calls, and the filename and line number reported by the error message will be someone else' code where the `panic!` macro is called, not the line of our code which calls `panic!`.

### Using a `panic!` Backtrace
Another example when a `panic!` is due to library bcause of bug in our code:
```rust
fn main () {
    let v = vec![1, 2, 3];

    v[99];
}
```
Rust will panic because using `[]` is supposed to return an element, but if you apss an invalid index, there's no element that Rust could return here that would be correct.

The error we get will point to the file we didn't write *libcore/slice/mod.rs*. That's the implementation of `slice` in Rust source code, when we use `[]` on our vector `v`.

The next note line tells us that we can set the `RUST_BACKTRACE` environment variable to get a backtrace of exactly what happened. *Backtrac* is a list of all the functions that have been called to get to this point. Read backtrace from top and read until you see files you wrote.

Run `RUST_BACKTRACE=1 cargo run` t o get full backtrace. That's a lot of output, but in order to get backtraces with this information, debug symbols must be enabled.

If we don't want our program to panic, the location pointed to by the first line mentioning a file we wrote is where we should investigate.

## 9.2. Recoverable Errors with `Result`
Most errors aren't serious enough to require the program to stop entirely.

Recall how `Result` enum is defined, having two variants:
```rust
enum Result<T, E> {
    Ok(T),
    Err(E),
}
```

The `T` and `E` are generic types. `T` represents the type of the value that will be returned in success, while `E` represents the error when we fail. Due to generics, we can use `Result` type and the functions that the std library has defined on it in many different situations where the successful value and error value we want to return may differ.

```rust
use std::fs:File;

fn main() {
    let f = File::open("hello.txt");
}
```
How do we know return type? 1. Look at API documentation, 2. be lazy and look at compiler. Just try some hack:
`let f: u32 = File::open("hello.txt");`

This should tell you that "found enum `std::result::Result<std::fs::File, std::io::Error>`". Which means that `T` and `E` have been filled in.

That means the call to `File::open` might succeed or not, and the `Result` enum conveys exactly that.

We need to add code that acts differently depending on value of `File::open`.
```rust
use std::fs:File;

fn main() {
    let f = File::open("hello.txt");

    let f = match f {
        Ok(file) => file,
        Err(error) => panic!("Problem opening the file: {:?}", error)
    }
}
```
Like the `Option` enum, the `Result` enum and its variants have been brought into scope, so no need to specify `Result::` before the two variants.

Both arms should be pretty clear and easy to understand what they are doing.

### Matching on Different Errors
Maybe we want to act differently depending on the error. Example:
```rust
use std::fs:File;
use std::io::ErrorKind;

fn main() {
    let f = File::open("hello.txt");

    let f = match f {
        Ok(file) => file,
        Err(error) => match error.kind() {
            ErrorKind::NotFound => match File::create("hello.txt") {
                Ok(fc) => fc,
                Err(e) => panic!("Problem creating file: {:?}", e),
            }
            other_error -> {
                panic!("Problem opening file {:?}", other_error)
            }
        },
    }
}
```

The `open` returns inside the `Err` variant an `io::Error`, which has `kind` method to get the `io::ErrorKind` value. It has several variants, and the one we want to use is `ErrorKind::NotFound`, which indicates the file we're trying to open doesn't exist yet.

The condition we want to check in the inner match is whether the value returned by `error.kind()` is `NotFound` variant. The rest should be clear.

But this is a lot of `match`. You might want to write it like this instead (as a seasoned Rustacean):
```rust
use std::fs::File;
use std::io::ErrorKind;

fn main() {
    let f = File::open("hello.txt").unwrap_or_else(|error| {
        if error.kind() == ErrorKind::NotFound {
            File::create("hello.txt").unwrap_or_else(|error| {
                panic!("Problem creating file: {:?}", error);
            })
        } else {
            panic!("Problem opening file: {:?}", error);
        }
    });
}
```
Read this after Chapter 13 and look up the `unwrap_or_else` method in std library documentation.

### Shortcuts for Panic on Error: `unwrap` and `expect`
`match` works but doesnt always communicate intent well. `unwrap` is a shortcut for unwrapping `Ok` variant to return the value, but if it is `Err` varaint, we will call the `panic!` macro.
Example:
```rust
use std::fs::File;

fn main() {
    let f = File::open("hello.txt").unwrap();
}
```

We can also use `expect` to choose the `panic!` error message:
```rust
    let f = File::open("hello.txt").expect"Failed to open hello.txt");
```

It might be easier to find the piece of code that is problematic since we have specified the error messages, compared to figuring out which `unwrap` causes the panic.

### Propagating Errors
You can return error to the calling code, known as *propagating* the error. Consider this:
```rust
use std::fs::File;
use std::io;
use std::io::Read;

// note the return type
fn read_username_from_file() -> Result<String, io::Error> {
    let f = File::open("hello.txt");

    let mut f = match f {
        Ok(file) => file,
        Err(e) => return Err(e), // early termination
    };

    let mut s = String::new();

    // read the contents of f into s
    match f.read_to_string(&mut s) {
        Ok(_) => Ok(s),
        Err(e) => Err(e),
    }
}
```

The code that calls this code will either get an `Ok` with the username, or `Err` which contains `io::Error`.

This pattern is so common that we have an operator to make it easier in the next section:

### A Shortcut for error propagation: the `?` operator
This has the same functionality as above
```rust
fn read_username_from_file() -> Result<String, io::Error> {
    let mut f = File::open("hello.txt")?;
    let mut s = String::new();
    f.read_to_string(&mut s)?;
    Ok(s);
}
```
The `?` places after `Result` value is defined to work almost in the same way as `match` expressions to handle values like in the previous case. If `Result` is `Ok`, the value inside `Ok` is returned. However if `Err`, the `Err` will be returned from the whole function as if we had used the `return` keyword.

Note minor difference: error values that have the `?` operator called on them go through the `from` function, defined in the `From` trait in the standard library. Whatever error type received by `?` will be converted to the error defined in the return type of the function.

We have made it short to look potentially like this:
```rust
fn read_username_from_file() -> Result<String, io::Error> {
    let mut s = String::new();

    File::open("hello.txt")?.read_to_string(&mut s)?;

    Ok(s);
}
```

But there's an even shorter way!
```rust
use std::fs;
use std::io;

fn read_username_from_file() -> Result<String, io::Error> {
    fs::read_to_string("hello.txt")
}
```
Reading a file into a string is failrly common, so Rust provides `fs::read_to_string` function.

### The `?` Operator Can Be Used in Functions That Return `Result`
Let's look what happens if we use `?` operator in the `main` function, which has return type of `()`
```rust
// wont compile
use std::fs::File;

fn main() {
    let f = File::open("hello.txt")?;
}
```

Error: use `?` operator in a function that returns `Result` or `Option` or another type that implements `std::ops::Try`. If you are not returning these and want to use `?`, two choices you have.

1. Change return type of your function to be `Result<T, E>` if you have no restrictions
2. Use a `match` or one of the `Result<T, E>` methods to handle the `Result<T, E>` in whatever way is appropriate.

`main` is special. One valid return type is `()`. Another is `Result<T, E>`:
```rust
use std::error::Error;
use std::fs::File;

fn main() -> Result<(), Box<dyn Error>> {
    let f = File::open("hello.txt")?;

    Ok(())
}
```

The `Box<dyn Error>` type is called trait object. Explored in Chapt 17. You can read it as "any kind of error". Using `?` in a `main` function with this return type is allowed.

## 9.3. To `panic!` or Not to `panic!
When to do what? Calling `panic!` is possible when you have any error situation, whether there's a possible way to recover or not, but you're the one making the decision on behalf of the code.

Returning `Result` is a good default choice, because then the calling code could decide than an `Err` value in this case is unrecoverable.

In rare situations, it's more appropriate to write code that panics instead of returning a `Result`. 

### Examples, Prototype Code, and Tests
When you're writing an example to illustrate concept, having error-handling may make it less clear. In examples, it's understood that a call to a method like `unwrap` that could panic is meant as a placefolder for the behavior.

Similaryly the `unwrap` and `expect` methods are very handy when prototyping, before you decide how to handle them.

If a method call fails in a tests, you'd want whole test to fail. Because `panic!` is how a test is marked as failure, you should call `unwrap` or `expect`.

### Cases in Which You Have More Information Than the Compiler
Suppose you have this example:
```rust
use std::net::IpAddr;

let home: IpAddr = "127.0.0.1".parse().unwrap();
```
We definitely know the `parse()` will give us a `Result` which is an `Ok` variant. So we can just call `unwrap()`.

### Guidelines for Error Handling
Panic when it's possible that your code could end up in a bad state. *Bad state* is when some assumption, guarantee, contract, or invariant has been broken.
Examples: invalid values, contradictory values, or missing values are passed to your code plus at least one of these:
* Bad state is not something that's *expected* to happen occasionally
* Your code after this point needs to rely on not being in this bad state
* There's not a good way to encode this information in the types you use

Passing value that don't make sense, might be best to call `panic!`. Similarly, `panic!` is appropriate when calling external code that is out of control and it returns invalid state. But when failure is expected, use `Result`.

When code performs operations on values, your code should verify the values are valid first and panic if not valid. Panicking when contract is violated makes sense.

Rust's type system already guarantees and simplifies things. If you expect a type, then you can be sure it's not an `Option`. It definitely has something. Or using `u32`, ensuring parameter is never negative.

### Creating Custom Types for Validation
We could do this for a guessing game, guiding users to valid inputs:
```rust
loop {
    // --snip--

    println!("Please input your guess.");

    let mut guess = String::new();

    io::stdin()
        .read_line(&mut guess)
        .expect("Failed to read line");

    let guess: i32 = match guess.trim().parse() {
        Ok(num) => num,
        Err(_) => continue,
    };

    if guess < 1 || guess > 100 {
        println!("The secret number will be between 1 and 100.");
        continue;
    }

    match guess.cmp(&secret_number) {
        // --snip--
    }

```

Above is not ideal though: if it was absolutely critical that the program only operated on values between 1 and 100, it's tedious to repeat these checks.

We can instead make a new type and put validations in a function to create an instance of the type rather than repeating validations. Functions use this new type in signatures, and confidently use values they receive.

Example:
```rust
pub struct Guess {
    value: i32,
}

impl Guess {
    pub fn new(value: i32) -> Guess {
        if value < 1 || value > 100 {
            panic!("Guess value must be between 1 and 100, got {}", value);
        }

        Guess { value }
    }

    pub fn value(&self) -> i32 {
        self.value
    }
}
```
The function `value` borrows `self`, and this kind can be thought of as a *getter*. The public method is necessary because the `value` field of the `Guess` struct is private. Code **must** call `Guess::new` function to set a value, thereby passing validation check.

# 10. Generic Types, Traits, and Lifetimes
Generics are abstract stand-ins for concrete types or other properties. When we write code, we can express the behavior of generics or how they relate to other generics without knowin what will be in their place when compiling and running the code.

### Removing Duplication by Extracting a Function
Using a technique to remove duplication that doesn't involve generic types. Consider this short program:
```rust
fn main() {
    let number_list = vec![34, 50, 25, 100, 65];

    let mut largest = number_list[0];

    for number in number_list {
        if number > largest {
            largest = number;
        }
    }

    println!("The largest number is {}", largest);
}
```

If we have two lists:
```rust
fn main() {
    let number_list = vec![34, 50, 25, 100, 65];

    let mut largest = number_list[0];

    for number in number_list {
        if number > largest {
            largest = number;
        }
    }

    println!("The largest number is {}", largest);

    let number_list = vec![100, 23, 400, 54, 43, 8];

    let mut largest = number_list[0];

    for number in number_list {
        if number > largest {
            largest = number;
        }
    }

    println!("The largest number is {}", largest);
}
```

This works, but duplicating is tedious and error prone. SO instead we shall abstract this by defining a function that operates on any list of integers given to it in a parameter:
```rust
fn largest(list: &[i32]) -> i32 {
    let mut largest = list[0];

    for &item in list {
        if item > largest {
            largest = item;
        }
    }

    largest
}

fn main() {
    let number_list = vec![34, 50, 25, 100, 54];

    let result = largest(&number_list);
    println!("The largest number is {}", result);

    let number_list = vec![102, 34, 600, 89, 54];

    let result = largest(&number_list);
    println!("The largest number is {}", result);
}
```
The `largest` function has a parameter called `list` which represents any concrete slice of `i32` values that we might pass into the function. As a result, when we call the function, the code runs on the specific values that we pass in.

In sum we did these steps:
1. Identify duplicate code.
2. Extract duplicate code into function
3. Update two instances of duplicated code to call the function instead

Now the motivation, what if I have two functions: one that finds the largest item in a slice of `i32` values and one that finds the largest item in a slice of `char` values.

## 10.1 Generic Data Types
We can use generics to create definitions for items like function signatures or structs, which we can then use with many different concrete data types. Look at how to define functions, structs, enums, and methods using generics.

### In Function Definitions
We place generics in signature of function where we would usually specify the data types of the parameters and return value. Doing so makes our code more flexible and provides more functionality to callers of our function while preventing code duplication.

When we want to define a `largest_i32` fujction and `largest_char` function, their bodies are likely to be the same. So let's just parameterize the types in the new function we'll define. We'll use `T` because for the type parameter by convention.

To define the generic `largest` function, place type name declarations inside angle brackets, `<>`, between the name of the function and param list like this:
```rust
fn largest<T>(list: &[T]) -> T {}
```
Read this as: the fuction `largest` is generic over some type `T`. This function has one parameter named `list`, whcih is a slice of type `T`. The `largest` function will return a value of the same type `T`.

If we define our function like this, it's close, but no cigar:
```rust
fn largest<T>(list: &[T]) -> T {
    let mut largest = list[0];

    for &item in list {
        if item > largest { // > gives error because T might need a bound for `std::cmp::PartialOrd`
            largest = item;
        }
    }

    largest
}
```
`std::cmp::PartialOrd` is a trait, which we should talk about in the next section.

### In Struct Definitions
We can also define structs to use generic type parameter in one or more fields using the `<>` syntax. We can define a `Point<T>` struct to hold `x` and `y` coordinate values of any type:
```rust
struct Point<T> {
    x: T,
    y: T,
}

fn main() {
    let integer = Point { x: 5, y: 10 };
    let float = Point { x: 1.0, y: 4.0 };
}
```
Syntax for using generics here is similar to function definitions. First, we declare the name of the type parameter inside angle brackets just after the name of the struct. Then, we can use the generic type in struct definition where we owould otherwise specify concrete data types.

However, since we defined `Point<T>`, this implies that fields `x` and `y` are both that same type. If we create instance of a `Point<T>` that has values of different types, our code won't compile.

Instead, what we should do hre is to change the definition of `Point` to be generic over types `T` and `U` where `x` is of type `T` and `y` is of type `U`:

```rust
struct Point<T, U> {
    x: T,
    y: U,
}

fn main() {
    let both_integer = Point { x: 5, y: 10 };
    let integer_and_float = Point { x: 5, y: 4.0 };
}
```

### In Enum Definitions
As we did structs, we define enums to hold generic data types in their variants. Here is another look at `Option<T>`:
```rust
enum Option<T> {
    Some(T),
    None,
}
```
`Option<T>` is generic over type `T` having two variants: `Some` with type `T`, and a `None` variant. By using `Option<T>` enum, we can express the abstract concept of having an optinal value, and because `Option<T>` is generic, we can use this abstraction no matter what type of the optional value is.

Enums can use multiple generic as well:
```rust
enum Result<T, E> {
    Ok(T),
    Err(E),
}
```

It's generic over two types, `T` and `E`, having two variants: `Ok` and `Err` holding `T` and `E` respectively.

### In Method Definitions
We can implement methods on strucs and enums and use generic types in their definitions too:
```rust
struct Point<T> {
    x: T,
    y: T,
}

impl<T> Point<T> { // This can be U instead of T also
    fn x(&self) -> &T {
        &self.x
    }
}

fn main() {
    let p = Point { x: 5, y: 10 };
    println!("p.x = {}", p.x());
}
```
Note that we have to declare `T` just after `impl` so we can use it to specify that we're implementing methods on type `Point<T>`. By declaring `T` after `impl`, Rust can identify that the type in the angle brackets in `Point` is a generic type rather than a concrete type.

We could implement methods only on `Point<f32>` instances rather than on `Point<T>` instances:
```rust
impl Point<f32> {
    fn distance_from_origin(&self) -> f32 {
        (self.x.powi(2) + self.y.powi(2)).sqrt()
    }
}
```

Generic type parameters in struct definition aren't always the same as the one you use in struct method's signatures. For example:
```rust
struct Point<T, U> {
    x: T,
    y: U,
}

impl<T, U> Point<T, U> {
    fn mixup<V, W>(self, other: Point<V, W>) -> Point<T, W> {
        Point {
            x: self.x,
            y: other.y,
        }
    }
}

fn main() {
    let p1 = Point { x: 5, y: 10.4 };
    let p2 = Point { x: "Hello", y: 'c' };

    let p3 = p1.mixup(p2);

    println!("p3.x = {}, p3.y = {}", p3.x, p3.y};)
}
```
### Performance of Code using generics
Rust implements generics in a way that code doesn't run any slower using generic types.

Rust uses monomorphization to turn generic code into specific code by filling in the concrete types that are used when compiled. Because Rust compiles generic code into code that specifies the type in each instance, we pay no runtime cost for using generics. When the code runs, it performs just as it would if we had duplicated each definition by hand. 

## 10.2. Traits: Defining Shared Behavior
A *trait* tells the Rust compiler about functionality of a particular type has and can share with other types. We can use traits to define shared behaviour in an abstract way.

Note: Traits are similar to interfaces, although with some differences

### Defining a Trait
A type's behaviour consists of the methods we can call on that type. Different types share the same behaviour if we can call the same methods on all of those types. Trait definitions are a way to group method signatures together to define a set of behaviours necessary to accomplish some purpose.

Let's say we have structs to hold various kinds and amounts of text: a `NewsArticle` and `Tweet` struct. We want to have a media aggregator library that display summaries. We can define a `Summary` trait:
Filename: src/lib.rs
```rust
pub trait Summary {
    fn summarize(&self) -> String;
}
```
We declare a trait using the `trait` keyword, and then the trait's name, which is `Summary`. After . the method signature, instead of providing an implementation within curly brackets, we use a semicolon. Ecah type implementing this trait must provide its own custom behavior for the body of the method.

A trait can have multiple methods, the method signatures are listed one per line and each line ends in a semicolon.

### Implemeting a Trait on a Type
Example:
Filename: src/lib.rs
```rust
pub struct NewsArticle {
    pub headline: String,
    pub location: String,
    pub author: String,
    pub content: String,
}

impl Summary for NewsArticle {
    fn summarize(&self) -> String {
        format!("{}, by {} ({})", self.headline, self.author, self.location)
    }
}

pub struct Tweet {
    pub username: String,
    pub content: String,
    pub reply: bool,
    pub retweet: bool,
}

impl Summary for Tweet {
    fn summarize(&self) -> String {
        format!("{}: {}", self.username, self.content)
    }
}
```

Implementing a trait on a type is similar to implementing regular methods. But after `impl`, we put trait name that we want to implement, then use the `for` keyword, and then specify the name of the type we want to implement the trait for. We put the method signatures that the trait definition has defined.

Note that because we defined the `Summary` trait in lib.rs, and say crate is `aggregator`. If someone else wants to use our crate's functionality to implement the `Summary` trait, they would need to call `use aggregator::Summary;` to bring trait into their scope first. The `Summary` trait would also need the `pub` keyword.

Restriction: trait implementations must be such that either the trait or the type is local to our crate. If both are external, we can't do it. This is called *coherence* and more specifically the *orphan rule*, so named because the parent type is not present. So that other people's code can't break your code and vice versa.

### Default Implementations
We can have default implementations:
```rust
pub trait Summary {
    fn summarize(&self) -> String {
        String::from("(Read more...)")
    }
}

impl Summary for NewsArticle {}
```
Use empty block to implement a trait for something.

We could also make default implementations rely on a method that has to be implemented:
```rust
pub trait Summary {
    fn summarize_author(&self) -> String;

    fn summarize(&self) -> String {
        format!("(Read more from {}...)", self.summarize_author())
    }
}
```

### Traits as Parameters
We can explore how to use traits to define functions that accept many different types. Let's say we want to define a `notify` function that calls the `summarize` method on its `item` parameter, which is of some type that implements the `Summary` trait:
```rust
pub fn notify(item: impl Summary) {
    println!("Breaking news! {}", item.summarize())
}
```

#### Trait Bound Syntax
The `impl summary` is syntactic sugar for:
```rust
pub fn notify<T: Summary>(item: T) {
    println!("Breaking news! {}", item.summarize());
}
```

But `impl Trait` can make syntax look like this:
```rust
pub fn notify(item1: impl summary, item2: impl Summary) {}
```
If we allow `item1` and `item2` to have different types, using `impl Trait` would be appropriate, but if you want to force both parameters to have the **same** type:
```rust
pub fn notify<T: Summary>(item1: T, item2: T) {}
```

#### Specifying Multiple Trait Bounds with the `+` Syntax
We can also specify more than one trait bound:
```rust
pub fn notify(item: impl Summary + Display) {}
```
The `+` syntax is also valid with trait bounds on generic types:
```rust
pub fn notify<T: Summary + Display>(item: T) {}
```
With the two trait bounds specified, the body of `notify` can call `summarize` and use `{}` to format `item`.

#### Clearer Trait Bounds with `where` Clauses
Using too many trait bounds have its downsides. It can make it hard to read:
```rust
fn some_function<T: Display + Clone, U: Clone + Debug>(t: T, u: U) -> i32 {}
```

But we can instead fix it like this:
```rust
fn some_function<T, U>(t: T, u: U) -> i32
    where T: Display + Clone,
          U: Clone + Debug,
{
```

### Returning Types that Implements Traits
We can also use `impl Trait` syntax to return a value of some type that implements a trait:
```rust
fn returns_summarizable() -> impl Summary {}
```

However, this only works if you're returning a single type. This won't work:
```rust
fn returns_summarizable(switch: bool) -> impl Summary {
    if switch {
        NewsArticle { ... }
    } else {
        Tweet { ... }
    }
}
```
This isn't allowed due to restrictions aroudn how the `impl Trait` syntax is implemented in the compiler. More in Chapter 17.

### Fixing the `largest` Function with Trait Bounds
Now with this knowledge, we should change the singature of `largest`:
```rust
fn largest<T: PartialOrd>(list: &[T]) -> T {}
```

But with that we will get an error saying `cannot move out of type [T], a non-copy slice`. With our non-generic versions, we were only trying to find largest `i32` or `char`. Types like `i32` and `char` have a known size and can be sotredo nthe stack, so they implement the `Copy` trait. 

Due ot generics, ti became possible for the `list` parameter to have types in t that don't implement `Copy` trait. Consequently, we wouldn't be able to move the value out of `list[0]` and into the `largest` variable.

To call this code with only those implementing `Copy` trait, we can add `Copy` trait:
```rust
fn largest<T: PartialOrd + Copy>(list: &[T]) -> T {}
```

If we don't want to restrict it to types that implement `Copy` trait, we could instead specify that it has the trait bound `Clone` instead. Then we could clone each vlaue in the slice when we want the `largest` funciton to have ownership. This means that we are making more heap allocations and can be slower. 

Another way is to return a reference to a `T` value in the slice. If we cahnge the return type to `&T` instead of `T`, thereby changing theb ody of the funciton to return ar reference, we wounldn't need the `Clone` or `Copy` trait bounds and we could avoid heap allocations.

### Trait Bounds to Conditionally Implement Methods
We can implement methods conditionally for types that implement the specified traits. For example, type `Pair<T>` always implements the `new` function. But `Pair<T>` only implements the `cmp_display` method if its innter type `T` implements the `PartialOrd` trait that enabled Comparison *and* `Display` trait that enables printing

```rust
use std::fmt::Display;

struct Pair<T> {
    x: T,
    y: T,
}

impl<T> Pair<T> {
    fn new(x: T, y: T) -> Self {
        Self { x, y }
    }
}

impl<T: Display + PartialOrd> Pair<T> {
    fn cmp_display(&self) {
        if self.x >= self.y {
            println!("The largest member is x = {}", self.x);
        } else {
            println!("The largest member is y = {}", self.y);
        }
    }
}
```

We can also conditionally implement a trait for any type that implements another trait. Implementations of a trait on any type that satisfies the trait bounds are called *blanket implemntations* and are exensively used in Rust standard library. For example, the standard library implemnts the `ToString` trait on any type that implements the `Display` trait:

```rust
impl<T: Display> ToString for T {
    // -- snip -- 
}
```

Bcs std library has this blanket implementation, we can call the `to_string` method defined by the `ToString` trait on any type that implements the `Display` trait. 

Blanket implementation appears in the docs in the "Implementors" section

## 10.3. Validating Reference with Lifetimes
Every reference in Rust has a *lifetime* which is the scope for which that reference is valid. We usually infer them, but we annotate lifetimes when wthe lifetimes of references could be related in a few different ways. Rust requires us to annotate the relationships using generic lifeitme parameters to ensure the actual references used at runtime will definitely be valid.

### Preventing Dangling References with Lifetimes
We want to prevent dangling references, which cause a program to reference data other than the data it's intended to reference. Consider this uncompile-able code:
```rust
{
    let r;

    {
        let x = 5;
        r = &x;
    }

    println!("r: {}", r);
}
```

We attempt to set the value of `r` as a reference to `x`. Then inner scope ends, and we print value in `r`, but it won't compile because the value `r` is referring to has gone out of scope before we try to use it.

If Rust allowed this code to work, `r` would be referencing memory that was deallocated when `x` went out of scope, and anything we tried to do with `r` wouldn't work correctly. Rust determines that this code is invalid using the borrow checker.

### The Borrow Checker
Rust compiler has *borrow checker* that compares scopes to determine whether all borrows are valid. We annotate the previous code with lifetimes of variables:
```rust
    {
        let r;                // ---------+-- 'a
                              //          |
        {                     //          |
            let x = 5;        // -+-- 'b  |
            r = &x;           //  |       |
        }                     // -+       |
                              //          |
        println!("r: {}", r); //          |
    }                         // ---------+
```
We annotate lifetime of `r` with `'a` and lifetime of `x` with `'b`. Tjhe inner `'b` block is much smaller than the outer `'a` block. Rust compares the size of the two lifetimes and sees that `r` refers to something with a smaller scope. `'b` is shorter than `'a`: **the subject of reference doesn't live as long as the reference**

This will fix the code to have no dangling reference:
```rust
    {
        let x = 5;            // ----------+-- 'b
                              //           |
        let r = &x;           // --+-- 'a  |
                              //   |       |
        println!("r: {}", r); //   |       |
                              // --+       |
    }                         // ----------+
```

`x` here has lifetime of `'b` that is larger than `'a`. 

### Generic Lifetimes in Functions
Writing a function that retuns the longer of two string slices:
```rust
fn main() {
    let string1 = String::from("abcd");
    let string2 = "xyz";

    let result = longest(string1.as_str(), string2);
    println!("The longest string is {}", result);
}
```
We want fn to take string slices, which are references, because we don't want the `longest` function to take ownership of parameters. Acept slices of a `String` type as well as string literals.

If we try to implement the `longest` function:
```rust
// Won't compile:
fn longest(x: &str, y: &str) -> &str {
    if x.len() > y.len() {
        x
    } else {
        y
    }
}
```
It will say that we need a generic lifetime parameter on it because Rust can't tell whether it returns `x` or `y`, and we dont' know either! Since we don't know so much, we'll add generic lifetime parameters that define the relationship between the references so the borrow checker can perform its analysis.

### Lifetime Annotation Syntax
It doesn't change how long any of the references live. Like generic types, functions can accept references with any lifetime by specifying a generic lifetime parameter. **Lifetime annotatiosn describe the relationships of the lifetimes of multiple references to each other without affecting the lifetimes**

The syntax is unusual: it must staart with `'` and all very short like generic types. We place lifetime parameter annotations after the `&` of a reference, using a space to separate the annotation from the reference's type.

Examples:
```rust
&i32        // a reference
&'a i32     // a reference with an explicit lifetime
&'a mut i32 // a mutable reference with an explicit lifetime
```

One lifetime annotation by itself doesn't say much, because they are meant to tell Rust how generic lifetime parameters of multiple references relate to each other.

Eg. we have a function with the parameter `first` that is a reference to an `i32` with lifetime `'a`. The function also has another parameter named `second` that is another reference to an `i32` that also has lifetime `'a`. It indicates that both `first` and `second` must both live as long as that generic lifetime.

### Lifetime Annotations in Function Signatures
As with type parameters, we need to declare generic lifetime parameters inside angle brackets. We express the constraint that all the references in the parameters and the return value must have same lifetime:
```rust
fn longest<'a>(x: &'a str, y: &'a str) -> &'a str {
    if x.len() > y.len() {
        x
    } else {
        y
    }
}
```

This means that the liftime of the reference returned by `longest` functions is the same as the smaller of lifetimes of the references passed in. We enforce this constraints to Rust. We're not changing lifetimes here, but we're specifying that the borrow checker hsould reject any values that don't adhere to these constraints. It doesn't need to know how longe exactly `x` and `y` will live, just that some scope can be substituted with `'a` that will satisfy this signature.

The annotations go in function signature NOT body. Function references to or from code outside that function, it becomes almost impossible for Rust to figure out the lfietimes of parameters or return values on its own. Lifetimes might be different each time function is called and we need to annotate lifetimes manually.

When we pass concrete values, concrete lifetime that is substituted for `'a` is the part of the scope `x` that overlaps with scope `y`. I.e. equal to the smaller of the two lifetimes. 

This is because we've annotated the returned reference with `'a` and this returned reference should also be valid for the length of the smaller of the two lifetimes `x` and `y`.

Let's look at how lifetime annotations restrict the `longest` function by passing in references that have different concrete lifetime:
```rust
fn main() {
    let string1 = String::from("long string is long");

    {
        let string2 = String::from("xyz");
        let result = longest(string1.as_str(), string2.as_str());
        println!("The longest string is {}", result);
    }
}
```

`string1` is valid until the end of the outer scope, `string2` is valid until the end of the inner scope, and `result` references something that is valid until the end of the inner scope. Borrow checker will approve this.

Let's try this now:
```rust
fn main() {
    let string1 = String::from("long string is long");

    {
        let string2 = String::from("xyz");
        let result = longest(string1.as_str(), string2.as_str());
    }
    println!("The longest string is {}", result); // moved down here
}
```
The error shows that for `result` to be valid for the `println!` statement, `string2` would need to be valid until end of outer scope. 

Compiler can't tell this is valid, it might be the case that the longer string is `string2` and in that case it would have expired!

### Thinking in Terms of Lifetimes
The way in which you need to specify lifetime parameters depends on what your funciton is doing. E.g. if `longest` always return the first parameter, we wouldn't need to specify lifetime of `y`:
```rust
fn longest<'a>(x: &'a str, y: &str) -> &'a str {
    x
}
```
The lifetime of `y` does not have any relationship with the lifetime of `x` or the return value.

When returning reference from function, the lifetime paramter for the return type needs to match the lifetime parameter for one of the parameters. If it does *not* refer to one of the paramters, it must refer to values created inside the function, which is a dangling reference because the value will go out of scope at the end of the function!

```rust
fn longest<'a>(x: &str, y: &str) -> &'a str {
    let result = String::from("really long string");
    result.as_str()
}
```

Problem: `result` goes out of scope at the end of the function. There is no way we can specify lifetime parameters that would change the dangling reference. Best fix is to return an owned data type rather than a reference so the calling function is then responsible for cleaning up the value.

Ultimately, lifetime is about **connecting lifetimes of various parameters and return values of function**. Rust will have enough information to allow memory-safe operations and disallow operations that would create dangling pointers or otherwise memory safety.

### Lifetime Annotations ain Struct Definitions
It's possible for hold references, but it would need a lifetime annotation on every reference:

```rust
struct ImportantExcerpt<'a> {
    part: &'a str,
}

fn main() {
    let novel = String::from("Call me cjwelly. Some years ago...");
    let first_sentence = novel.split('.').next().expect("Could not find a '.'");
    let i = ImportantExcerpt {
        part: first_sentence,
    };
}
```

This annotation means an instance of `ImportantExcerpt` can't outlive the reference it holds in its `part` field. I.e. `part` should live longer.

The `main` example here creates an instance of `ImportantExcerpt` struct. The data in `novel` exists before the `ImportantExcerpt` instance is created, and it doesn't go out of scope until after the `ImportantExcerpt` goes out of scope, so the reference in the `ImportantExcerpt` instance is valid.

### Lifetime Elision
We need lifetimes when parameters for functions or structs use references but there are cases where we don't need it to.

Historically, we need to give explicit lifetime:
```rust
fn first_word<'a>(s: &'a str) -> &'a str {}
```
There is pattern as many Rust programmers started repeating this and they rewrote the compiler to simplify this. Rust's analysis of references are called *lifetime elision rules*. They're a set of cases compiler will consider and if it fits you won't need it.

Lifetimes on function or method parameters are called *input lifetimes*, and lifetimes on return values are called *output lifetimes*.

It uses three rules to figure out what lifetimes references have when there aren't explicit annotations. First: input lifetimes, Second & Third: apply to output lifetimes. If it can't figure it out by the end of the three rules, it will error. **Apply this to `fn` definitions and `impl` blocks**

1. First rule is that each param that is a reference gets its own lifetime parameter. So for two params: `fn foo<'a, 'b>(x: &'a i32, y: &'b i32)`
2. Second rule, if one input lifetime param, that lifetime is assigned to all output lifetime parameters
3. Third rule, if multimple input lifetime param, but one is `&self` or `&mut self` because this is a method, the lifetime of `self` is assigned to all output lifetime parameters. It makes methods much nicer to read and write because fewer symbols are ncessary.

So studying this:
```rust
fn first_word(s: &str) -> &str {}
```
We can apply rule 1 and 2 to get here:
```rust
fn first_word<'a>(s: &'a str) -> &'a str {}
```
All references have lifetimes, and compiler can continue its analysis without needing annotations.

Another example:
```rust
fn longest(x: &str, y: &str) -> &str {}
```

Applying first rule we get:
```rust
fn longest<'a, 'b>(x: &'a str, y: &'b str) -> &str {}
```
Second and third rule don't apply here and we haven't figured out what the return type's lifetime is.

Because third rule applies to method signatures, it means we don't have to annotate lifetimes in method signatures very often:
### Lifetime Annotations in Method Definitions
We use the same syntax as generic type parameter. In method's signatures inside the `impl` block, references might be tied to the lifetime of references in struct's fileds or indedepndent. In addition, lifetime elision rules often makes it so that lifetime annotations aren't necessary in method signatures.

Example:
```rust
impl<'a> ImportantExcerpt<'a> {
    fn level(&self) -> i32 {
        3
    }
}
```
We are not required to annotate method, because of lifetime elision rules.

But here's another example where third lifetime elision rule applies:
```rust
impl<'a> ImportantExcerpt<'a> {
    fn announce_and_return_part(&self, announcement: &str) -> &str {
        println!("Attention please: {}", announcement);
        self.part
    }
}
```
First rule: `&self` and `announcement` get their own lifetimes
Third rule: return type gets lifetime of `&self`, and life is good

### The Static Lifetime
`'static` means reference *can* live for the entire duration of the program. All string literals have it but we canannotate it as follows:
```rust
let s: &'static str = "I have a static lifetime.";
```

You might see it being suggested in error messages, but think whether it lives the entire lifetime or not. Problem would usually result from attempting to create a dangling reference or a mistmatch of available lifetimes.

### Generic Type Parameters, Trait Bounds, and Lifetimes Together
So here we have an example of everything combined:
```rust
use std::fmt::Display;

fn longest_with_an_announcement<'a, T>(
    x: &'a str,
    y: &'a str,
    ann: T,
) -> &'a str
where
    T: Display,
{
    println!("Announcement! {}", ann);
    if x.len() > y.len() {
        x
    } else {
        y
    }
}
```
There is extra param here, which displays it before doing comparisons, which is why `Display` trait bound is necessary. Lifetimes are a type of generic, the declarations of the lifetime parameter `'a` and the generic type parameter `T` go in the same list inside angle brackets.

# 10. Writing Automated Tests
If for example we have `add_two` function to add 2 to whatever number is passed to it. Rust's type checking and borrow checking will ensure that we aren't passing a `String` value or an invalid reference to this function. But Rust *cannot* check that this funciton will do precisely what we intend. Maybe it's adding 10? This is why we should test!

## 10.1 How to Write Tests
The bodies of test functions typically perform these three actions:
1. Set up any needed data or state
2. Run the code you want to test
3. Assert the results are what you expect

### The Anatomy of a Test Function
A test in Rust is a function that's annotated with the `test` attribute. Attributes are metadata about pieces of Rust code. Example: `derive` attribute. When you run your tests with the `cargo test` command, Rust builds a test runner binary that runs the functions annotated with the `test` attribute and reports on whether each test funciton passes or fails.

When we build a new library project with Cargo, a test module with a test function in it is automatically generated for us. It helps to start write tests. You can add as many additional test functions!

Creating a new library project called `adder`: `cargo new adder --lib`

Note that the `#[test]` annotation before the `fn` line indicates that this is a test function so the runner will treat it as such. 

We can have non-test functions to help set up common scenarios or perform common operations.

Function body uses the `assert_eq! macro to assert that 2 + 2 equals 4. This assertion serves as eg of the format of a typical test.

The `cargo test` command runs all tests in our project.

Because we don't have any tests we've marked as ignored, the summary shows `0 ignored`. We also haven't filtered, so it shows `0 filtered out`.

The `0 measured` statistic is for benchmark tests that measure performance. But it is only available in nightly Rust.

The next part of the test output, which starts with `Doc-tests adder` is for the results of any documentation tests. Rist can compile any code examples that appear in our API documentation. This helps our docs and our code in sync.

Tests fail when something in the test function panics. Each test is run in a new thread, and when the main thread sees that a test thread has died, it is marked as failed. 

After failing the test suite, two new sections appear between the individual results and the summary: the first section displays the detailed reason for each test failure. The next section just details which tests are failing.

### Checking Results with the `assert!` Macro
`assert!` marco is useful when you want to ensure that some condition in a test evaluates to `tru`. We give it an argument that returns a boolean. If `true`, nothing happens and test passes, else `false` it will call the `panic!` macro.

Let's write a `Rectangle` and `can_hold` method to try out the `assert!` macro.

The `can_hold` method returns a Boolean, which makes it a perfect use case for the `assert!` macro. 

We can write a test for it:
```rust
#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn larger_can_hold_smaller() {
        let larger = Rectangle {
            width: 8,
            height: 7,
        };
        let smaller = Rectangle {
            width: 5,
            height: 1,
        };

        assert!(larger.can_hold(&smaller));
    }
}
```

Because the `tests` module is an inner module, we need to bring the code under test in the outer module into the scope of the inner module. Use a glob here so anything we define in the outer module is available to `tests` module: `use super::*;`

Now let's try asserting that a smaller rectangle cannot hold a larger one. Refer to example in the book.

We negate the boolean returned to assert something that is supposed to give us `false`. Now we see what happens to our test results when we introduce a bug in our code!

E.g. replace greater than sign with a less than sign
Our tests will catch this bug when we run `cargo test`.

### Testing Equality with the `assert_eq!` and `assert_ne!` Macros
You could technically use `assert!` with `==`, but it's a comon pattern that we just have a pair of macros for it: `assert_eq!` and `assert_ne!`. What's good is that they print the two values if the assertion fails.

We have seen an example of `assert_eq!` in the beginning. Now try adding a bug to the code (e.g. adding 3 in the function). Not only the macro will catch the bug, it will also tell us why the two values are different.

In Rust, it doesn't matter which order we specify the value. They are just called `left` and `right` instead of `expected` and `equal`.

Whereas for `assert_ne!`, it is most useful if you are not sure what the values *will* be, but you know what value it definitely *won't* be.

Since we print the arguments using debug formatting if a test fails, the values being compared must implement the `PartialEq` and `Debug` traits. Usually it's as straight forward as adding `#[derive(PartialEq, Debug)]`.

### Adding Custom Failure Messages
You can add a custom message printed with the failure message as optional arguments to the various `assert` macros.

Any optional arguments are passed along to the `format!` macro, so you can format string that contains `{}` placeholders and values to go in those placeholders.

You might want to write a test like this to make it more descriptive if it fails (because it prints out the value):
```rust
#[test]
fn greeting_contains_name() {
    let result = greeting("Carol");
    assert!(
        result.contains("Carol"),
        "Greeting did not contain name, value was `{}`",
        result
    );
}
```

### Checking for Panics with `should_panic`
We add another attribute, `should_panic` to our test function. It makes a test pass if the code inside the function panics; the test will fail if it doesn't panic.

So you could write a test like this:
```rust
#[test]
#[should_panic]
fn being_at_the_disco() {
    panic!("At the Disco!");
}
```

We place the `#[should_panic]` attribute after the `#[test]` attribute and before the test function it applies to.  (but quick testing seems to show that it's ok for it not to be right after)

If test does not panic as expected, it's not as descriptive as you might have. So you can add an `expected` parameter to the `should_panic` attribute.

So you can write a test like this (this should fail):
```rust
#[test]
#[should_panic(expected = "At the Disco!")]
fn being_at_the_disco() {
    panic!("At the Club!");
}
```
This code will still panic, but it is not passing because the panic is due to another reason.

### Using `Result<T, E>` in Tests
We can rewrite tests like this to use `Result<T, E>` and return an `Err`:
```rust
#[test]
fn it_works() -> Result<(), String> {
    if 2 + 2 == 4 {
        Ok(())
    } else {
        Err(String::from("two plus two does not equal four"))
    }
}
```

Rather than calling `assert_eq!` macro, we return `Ok(())` when test passes and an `Err` with a `String` inside if it fails.

Writing tests so they return a `Result<T, E>` enables you to use the question mark operator in body of tests, which can be convenient. 

However, you can't use the `#[should_panic]` annotation on tests that use `Result<T, E>`. Instead you should return `Err` value directly when the test fails.

## 10.2 Controlling How Tests Are Run
`cargo test` will compile your code in test mode and runs the resulting test binary. You can specify command line options to change behaviour. E.g. default of the binary produced is to run all tests in parallel and capture output generated during the run, preventing the output from being displayed and making it easier to read output related to the test results.

Some command line options go to `cargo test` and some go to the resulting test binary. To separate these types of arguments, you list arguments going to `cargo test` followed by separator `--` and the ones that go to the test binary.

Running `cargo test --help` displays options you can use with `cargo test`. Running `cargo test -- --help` displays the options you can use after the separator `--`.

### Running Tests in Parallel or Consecutively
By default they run in parallel using threads, so it will finish running faster so you can get feedback quicker. Make sure your tests don't depend on each other or on any shared state, including a shread environment. For example, current working directory or environment variables.

Say each of your tests run some code that creates a file on disk named *test-output.txt* and writes some data to that file. If this file is changed, the second test using it might behave differently and fail. A solution: each test writes to a different file; another solutioN: run tests one at a time.

You can do it so:
`cargo test -- --test-threads=1`

Here we set number of test threads to `1`, telling the program not to use any parallelism. Running the tests using one thread will take longer, but won't interfere with each other if they share state.

### Showing Function Output
By default, if the test passes, we won't see the stdout. We'll see only line that indicates the test passed.

If we want to see printed values for passing tests as well, we can tell Rust to also show the output of successful tests at the end like this: `cargo test -- --show-output`

### Running a Subset of Tests by Name
If you're working on code in particular area, you might want to run only the tests pertaining to that code. You can choose which tests to run by passing `cargo test` the name or names of the test(s) you want to run as an argument.

#### Running Single Tests
Say we have a test called `one_hundred`, we can simply run `cargo test one_hundred` to run *just* that test.

#### Filtering to Run Multiple Tests
Say now we have two tests `add_two` and `three_add`. To run these things we can do: `cargo test add` because it finds all tests whose names contain `add`.

### Ignoring Some Tests Unless Specifically Requested
You can annotate `ignore` to exclude tests from the `cargo test`.

## 10.3. Test Organization
Rust community thinks about tests in terms of two main categories: *unit tests* and *integration tests*.

Unit tests are small and more focused, testing one module in isolation at a time and can test private interfaces.

Integration tests are entirely external to your library and use your code in the same way any other external code would, using only the public interface and potentially exercising multiple modules per test.

### Unit Tests
It tests each unit of code in isolation from the rest of the code to quickly pinpoint where code is and isn't working as expected.

Put in *src* directory in each file with the code that they're testng. Create a module named `tests` in each file to contain the test functions, and annotate with `cfg(test)`.

#### The Tests Module and `#[cfg(test)]`
The `#[cfg(test)]` annotation on the tests module tells Rust to compile and run the test code when you run `cargo test` not `cargo build`. 

This will save compile time when you only want to build the library. Integration tests go in a different directory because they don't need this annotation. However because unit tests go in the same files as the code, you'll use `#[cfg(test)]` to specify that they shouldn't be included in the compiled result.

When we create the project with the library, the test code is automatically generated test module. The attribute `cfg` stands for configuration and tells Rust that the following item should only be included given a certain configuration option.

Here the option is `test`. By using `cfg`, Cargo compiles our test code if we actively run the tests with `cargo test`, inclusive of helper functions in the module.

#### Testing Private Functions
Rust's privacy rules do allow testing of private functions.

```rust
fn internal_adder(a: i32, b: i32) -> i32 {
    a + b
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn internal() {
        assert_eq!(4, internal_adder(2, 2));
    }
}
```
Note that the function is not marked as `pub` but because tests are just Rust code and the `tests` module is just another module, you can bring the private funciton into the test scope.

### Integration Tests
Units of code that work correctly on their own could have problems when integrated, so test coverage of the integrated code is important as well. You first need a *tests* directory.

#### The *tests* Directory
Make a *tests* directory, and create a new filed named *tests/integration_test.rs*

We don't need to annotate it with `#[cfg(test)]`. It treats the `tests` directory specially and compiles files in this directory only when we run `cargo test`.

It will run three things: unit, integration and doc tests.

If we add more things in the *tests* directory, there will be more integration test sections. 

If you just want to run particular integration test funciton, you can just specify the test function's name. To run all the tests in a particular integration test file, use the `--test` argument of `cargo test` followed by the name of the file: `cargo test --test integration_test` in our case.

#### Submodules in Integration Tests
Treating each integration test file as its own crate is useful to create separate scopes that are more like the way end users will use your crate This means files in the *tests* directory don't share the same behaviour as files in *src* do.

The different behaviour of files in *tests* directory is most noticeable when you have helper functions that would be useful in multiple integration test files. 

E.g. if we create *tests/common.rs*, and place function `setup`, we can add some code to `setup` that we want to call from multiple test functions in multiple test files.

When we run the tests again, we'll see a new section in the test output for the *common.rs* file, even though this file has no test nor did we call `setup`.

Having `common` appear is not something we want. To avoid having `common` appear, we create: *tests/common/mod.rs*. This naming convention is something Rust understands. It tells Rust not to treat the module as an integration test file. 

Files in subdirectories of the *tests* directory don't get compiled as separate crates or have sections in the test output.

We can use contents of `tests/common/mod.rs` from any integration test files as a module. Example:
```rust
use adder;

mod common;

#[test]
fn it_adds_two() {
    common::setup();
    assert_eq!(4, adder::add_two(2));
}
```

#### Integration Tests for Binary Crates
If our project is a binary crate that only contains *src/main.rs* file and no *src/lib.rs*, we can't create integration tests in the *tests* directory and bring functions defined in the *src/main.rs* file into scope with a *use* statement. 

**Only library crates expose functions that other crates can use; binary crates are meant to be run on their own**

Rust projects that provide a binary have a straightforward *src/main.rs* file that calls logic that lives in the *src/lib.rs* file. Using that structure, integration tests *can* test the library crate with `use` to make the important functionality available. If the important functionality works, the small amount of code in the *src/main.rs* file will work as well, and that small amount of code doesn't need to be tested.

I DONT UNDERSTAND THIS LITTLE SECTION