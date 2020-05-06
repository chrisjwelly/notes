With reference to the [Rust book](https://doc.rust-lang.org/book/). Just going to put some summary notes here.

## 1.1 Installation
I use WSL when learning Rust so I followed the command [here](https://www.rust-lang.org/tools/install).

## 1.2 Hello, World!

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

## 1.3 Hello, Cargo!
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