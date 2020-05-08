With reference to the [Rust book](https://doc.rust-lang.org/book/). Just going to put some summary notes here.

# 1. Getting Started
## 1.1. Installation
I use WSL when learning Rust so I followed the command [here](https://www.rust-lang.org/tools/install).

## 1.2. Hello, World!

```rs
fn main() { 

}
```

### Anatomy of a Rust Program
This defines a function in Rust and the `main` function is the entry point.
```rs
fn main() {
    println!("hello, world!");
}
```

The following does the work in the program:
```rs
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
```rs
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
```rs
let guess: u32 = match guess.trim().parse() {
    Ok(num) => num,
    Err(_) => continue,
}
```
Here, we desire u32, which `parse()` recognises.

# 3. Common Programming Concepts

## 3.1. Variables and Mutability

Suppose we have the following code snippet:
```rs
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
```rs
const MAX_POINTS: u32 = 100_000;
```

### Shadowing
This is different from assigning things to variables! We can shadow by using the same variable's name and repeating the use of the `let` keyword as follows:
```rs
fn main() {
    let x = 5;
    let x = x + 1;
    let x = x * 2;

    println!("The value of x is {}", x);

}
```
This will output, using value of `x` that is `12`. Again it's different from marking variable as `mut`, because we'll get compile-time error if we accidentally reassign. By using `let`, we can re-use a variable name while keeping the old variable as immutable.

Nifty trick: Create new variable and use `let` keyword again, we can change the type of the value. For example:
```rs
let spaces = "    ";
let spaces = spaces.len();
```
The above is valid even though the first `spaces` is string type and the second is int.

Compare this to:
```rs
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

```rs
fn main() {
    let x = 2.0; // f64
    let y: f32 = 3.0; // f32
}
```

#### Boolean Type
Same as normal, `true` or `false`, and Boolean type is specified using `bool`.
```rs
fn main() {
    let t = true;

    let f: bool = false; // with explicit type annotation
}
```

#### Character Type
Rust supports letters too, Rust's `char` is the language's most primitive alphabetic type. (Note `char` uses single quotes compared to double quotes for string literals)

```rs
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
```rs
fn main() {
    let tup: (i32, f64, u8) = (500, 6.4, 1);
}
```
`tup` will bind the entire tuple, as a single compound element. You can destructure like this:
```rs
fn main() {
    let tup = (500, 6.4, 1);

    let (x, y, z) = tup;

    println!("y is {}", y);
}
```
The above snippet first binds `tup`, then it uses the pattern with `let` to take `tup` and turn it into separate variables `x`, `y`, `z`.

We can also access element directly using period (`.`), followed by the index of the value we want to access:
```rs
fn main() {
    let tup = (500, 6.4, 1);

    let five_hundred = x.0;

    let six_point_four = x.1;

    let one  = x.2;
}
```

#### Array Type
Unlike Tuple, Array must have same type. Arrays in Rust have a fixed length, written as a comma-separated list inside square brackets:

```rs
fn main() {
    let a = [1, 2, 3, 4, 5];
}
```
Useful when you want data on stack than heap. Consult `vector` if you want resizeable array.

To write an array type in square brackets:
* Include type of each elem
* Semicolon
* Number of elements in the array

```rs
let a: [i32; 5] = [1, 2, 3, 4, 5];
```

Here, `i32` is the type of each element and we have 5 elements.

Alternative syntax for initializing an array: if you want to create an array that contains *same value* for each element, can specify initial value instead of the type in the way to do it above:
```rs
let a = [3; 5]; // shorthand for let a = [3, 3, 3, 3, 3]
```

#### Accessing Array Elements
Using array indexing like normal:
```rs
fn main() {
    let a = [1, 2, 3, 4, 5];

    let first = a[0];
    let second = a[1];
}
```

#### Invalid Array Element Access
When you access an element that is past the end of array?
```rs
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
```rs
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
```rs
fn main() {
    another_function(5); // passing an argument 5
}

fn another_function(x: i32) {
    println!("The value of x is: {}", x);
}
```
In function signatures you **must** declare the type of each parameter. When you want to have multi parameters, separate with commas:
```rs
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

```rs
fn main() {
    let y = 6; // this is a statement
}
```

Since assignment is a statement, you can't assign `let` to another variable:
```rs
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
```rs
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
```rs
{
    let x = 3;
    x + 1
}
```
is a block that in this case evaluates to `4`. **IMPORTANT**: the `x + 1` is *without* a semicolon. Expressions do not end with a semicolon. If you add a semicolon to the end of expression, you turn it into a statement.

### Functions with Return Values
We don't name return values, but declare type after an arrow (`->`). In Rust, the return value is value of the final expression in the block of the body of a function. Can return early using `return` but most functions return implicitly.

Example:
```rs
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
```rs
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
```rs
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
```rs
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
```rs
fn main() {
    let condition = true;
    let number = if condition { 5 } else { 6 };

    println!("The value of number is {}", number);
}
```

The `number` variable will be bound to value based on the outcome of `if` expression.

Recall: blocks evaluate to last expression, and numbers by themselves are also expressions.

Values that have the potential to be results must be of the same type. If types are mismatched like the following example, we can get an error:
```rs
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
```rs
fn main() {
    loop {
        println!("again");
    }
}
```

Rust provides a reliable way to break out a loop using the `break` keyword.

#### Returning Values from Loops
One use of `loop` is to retry operation you know might fail, such as checking whether a thread has completed its job. But you might need to pass the result to the rest of the code. To do this, you can add value you want returned after the `break` expression you use to stop the loop. That value will be returned, as shown:
```rs
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
```rs
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

```rs
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
```rs
fn main() {
    let a = [10, 20, 30, 40, 50];

    for element in a.iter() {
        println!("the value is {}", element);
    }
}
```

Most Rustacenas would use a `for` loop as well. To do that we use `Range` which is a type provided by the standard library that generates all numbers in sequence starting from one number and ending before another number.

Countdwn would look like this using a `for` loop and another method `rev` which reverses the range:

```rs
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
```rs
let s = "hello";
```
Variable `s` refers to a string literal. The variable is valid from the point at which it's delared until the end of the current *scope*. More comments:
```rs
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

```rs
let s = String::from("hello");
```

The double colon (`::`) is an operator that allows us to namespace this particular `from` function under the `String` type rather than using some sort of name like `string_from`.

This kind of string *can* be mutated:
```rs
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

```rs
{
    let s = String::from("hello"); // s is valid from this point on

    // do stuff with s
}   // this scope is now over and no longer valid
```
There is a natural point at which we can return the memory our `String` needs to the OS: when `s` goes out of scope. When variable goes out of scope, Rust calls a special function for us called `drop`. This is where author of `String` can put code to return to memory and Rust calls `drop` automatically at closing curly bracket.

This may be simple right now, but behavior of code can be unexpected in more complicated situations when we want to have multi variables use data we've allocated on the heap.

#### Ways Variables and Data Interact: Move
Multiple vars can interact with the same data in different ways in Rust.
```rs
let x = 5;
let y = x;
```
We can uess what's this doing: "bind value of `5` to `x`, then *make a copy* of the value in `x` and bint it to `y`". We now have two variables, `x` and `y`, and both equal `5`.

`String` version:
```rs
let s1 = String::from("hello");
let s2 = s1;
```
Okay there are some diagrams in the website here which I cannot reproduce so I will just describe them. `String` is made up of three parts: a pointer to memory, a length, and capacity. This group of data is stored on stack. On the right is memory on the heap that holds the contents.

The length is how much memory, in bytes, the contents of the `String` is currently using. The capacity is total amount `String` has received from the operating system. The difference between length and capacity matters, but not in this context, so for now, it's fine to ignore the capacity.

When we assign `s1` to `s2`, the `String` data is copied, meaning we copy the pointer, the length and capacity that are *on the stack*. We **do not copy** the data on the heap that the pointer refers to.

Earlier: variable goes out of scope, Rust calls `drop` automatically to clean up. But this is a problem: when `s2` and `s1` go out of scope, they will both try to free the same memory. This is known as *double free* error and is one of the memory safety bugs we mentioned previously. Freeing memory twice can lead to memory corruption, which can potentially lead to security vulnerabilities.

To ensure memory safety, there's on more detail. Instead of trying to copy allocated memory, Rust considers `s1` to no longer be valid and, therefore Rust doesn't need to free anything when `s1` goes out of scope. Check out what happens when you try to use `s1` after `s2` is created:
```rs
let s1 = String::from("hello");
let s2 = s1;

println!("{}, world!", s1);
```
You'll get an error because Rust prevents you from using invalidated reference

The act of making a *shallow copy* is the most similar here, but instead of being called such, we call it a *move*. This solves our problem as `s2` is valid, when it goes out of scope, it alone will free the memory and we're done.

Implication: Rust will never automatically create "deep" copies of data. Any *automatic* copying can be assumed to be inexpensive in terms of urntime performance.

#### Ways Variables and Data Interact: Clone
If we do want to deeply copy the heap data of `String`, we can use a common method called `clone`. Example:
```rs
let s1 = String::from("hello");
let s2 = s1.clone();

println!("s1 = {}, s2 = {}", s1, s2);
```
Works just fine and create a copy of the heap data. When you call `clone`, you know that some arbitrary code is being executed and code may be expensive. It's a visual indicator that something different is going on.

#### Stack-Only Data: Copy
This code is valid:
```rs
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
```rs
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
```rs
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
```rs
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
```rs
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
```rs
fn calculate_length(s: &String) -> usize { // s is a reference to a String
    s.len()
} // Here, s goes out of scope. But because it does not have ownership of what it refers to,
// nothing happens.
```

The scope of `s` is valid, but when it goes out of scope, we don't need to drop what `s` reference points to because we don't have ownership. We call having references as function parameters *borrowing*.

Attempt to try to modify something we're borrowing:
```rs
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
```rs
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
```rs
let mut s = String::from("hello");
{
    let r1 = &mut s;
} // r1 goes out of scope here, so we can make a new reference with no problems.

let r2 = &mut s;
```
Similar rule for mix and match of mutable and immutable references:
```rs
let mut s = String::from("hello");

let r1 = &s; // no problem
let r2 = &s; // no problem
let r3 = &mut s; // BIG PROBLEM

println!("{}, {}, and {}", r1, r2, r3);
```
We *also* cannot have mutable reference while we have immutable ones. Users of immutable reference don't expect values to suddenly change out from under them. Multiple immutable ok though because they are read-only.

Note that a reference's scope starts from where it is introduced and continues through the last time that reference is used. This is ok:
```rs
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
```rs
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
```rs
fn dangle() -> &String { // dangle returns a reference to a String
    let s = String::from("hello"); // s is a new String

    &s // we return a reference to String s
} // Here s goes out of scope, and is dropped. Its memory goes away. Danger!!
```
Because `s` is created inside `dangle`, when the code of `dangle` is finished, `s` will be deallocated but we tried to return a reference of it! That means this reference would be pointing to an invalid `String`!

The solution is to return directly:
```rs
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
```rs
fn first_word(s: &String) -> ?
```
The function has a `&String` as parameter. Since we don't want ownership, this is fine. But what should we return? We don't really have a way to talk about *part* of string. But we could return the index of the end of the word. For example:
```rs
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
```rs
for (i, &item) in bytes.iter().enumerate() 
```
`iter` is a method that returns each element in a collection, `enumerate` wraps the result of `iter` and returns each element as part of a tuple instead. First elem there is the index, and second element is a reference to the element. This is more convenient that calculating the index ourselves.

Because `enumerate` returns a tuple, we can destructure it. In the `for` loop, we specify a pattern that has `i` for index, and `&item` for the single byte in the tuple. Because we get a reference to element when using `enumerate()`, we use `&`.

Inside the `for` loop, we search byte that represents space using byte literal. If we find a space, we return that position. Otherwise, return length of string using `s.len()`.

New problem: we're returning a `usize` on its own, but it's meaningful only in the context of `&String`. Because it's a separate value from `String`, there's no guarantee that it will still be valid in the future. Consider this:
```rs
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
```rs
let s = String::from("hello world");

let hello = &s[0..5];
let world = &s[6..11];
```
Similar to referencing whole `String` but with extra `[0..5]` bit. It references a *portion* of the `String`.

We can create slices using a range within brackets by specifying `[starting_index..ending_index]` where we reference starting from `starting_index` inclusive to `ending_index` exclusive. Internally the slice stores: starting position, and length of slice. 

Some syntactic sugar:
```rs
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
```rs
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
```rs
fn main() {
    let mut s = String::from("hello world");

    let word = first_word(&s);

    s.clear(); // error!

    println!("the first word is: {}", word);
}
```

#### String Literals Are Slices
Consider this:
```rs
let s = "Hello, world!";
```
The type of `s` here is `&str`: it's a slice pointing to that specific point of the binary. This is also why string literals are immutable; `&str` is an immutable reference

#### String Slices as Parameters
We can make an improvement on the `first_word` from:
```rs
fn first_word(s: &String) -> &str 
```
to:
```rs
fn first_word(s: &str) -> &str
```

If we have string slice, we can pass that directly and if we have `String`, we can pass a slice of the entire `String`. It makes our API more general and useful.

### Other Slices
There's a more general slice type than string:
```rs
let a [1, 2, 3, 4, 5];

let slice = &a[1..3];
```
The slice has type `&[i32]`. It works the same way as string slices.
