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