# Typescript
With reference to 'Typecript - The Basics' video by Fireship on Youtube.

Typescript is a superset of Javascript. This means that all Javascript code is a Typescript code.

To start, install Typescript globally: `npm i -g typescript`. This gives you access to `tsc` which is a typescript compiler. (Use this like how you use `javac` to compile a Java code). e.g. `tsc index.ts`

By default, TS will transpile to ES3 code (Vanilla JS).

You can `touch tsconfig.json`. The compiler can be given some options to modify its behaviour with this. 

```typescript
{
    "compilerOptions": {
        "target": "esnext", // Flavour of JS your code will be compiled to. "esnext" gives latest ver
        "watch": true, // Recompile the code every time we save the file
        "lib": ["dom", "es2017"], // uhh i'm a bit lost here
    }
}
```
## Code with type indentations:

```typescript
let lucky = 23; // type is inferred to be number

lucky = '23'; // gives an error!
```

To opt out of the type system:
```typescript
let lucky: any = 23; // an any type

lucky = '23'; // ok!

// Variable declarations
let lucky; // any type
let lucky: number; // number type
```

You can create your own types from scratch!

```typescript
type Style = string; // A bit redundant though!
type Style = 'bold' | 'italic' | 23 // Create a union type by separating it with a pipe
```

More often than not, you will strong typing Objects!

```typescript
// Enforce the 'shape' of the object with an Interface
interface Person {
  first: string;
  last: string;
}

const person: Person = {
  first: 'Jeff',
  last: 'Delaney',
}

const person2: Person = {
  first: 'Usain', 
  last: 'Bolt',
  fast: true, // will be an error!
}
```

If the previous example is too restrictive:
```typescript
/* first and last name is required, but now you 
can add additional properties! */
interface Person {
  first: string;
  last: string;
  [key: string]: any;
}

const person: Person = {
  first: 'Jeff',
  last: 'Delaney',
}

const person2: Person = {
  first: 'Usain', 
  last: 'Bolt',
  fast: true, // will be an error!
}
```

## Functions

```typescript
// the parameters are enforced to be of number type
// return type is implicitly number type because of Math.pow
function pow(x:number, y:number) {
  return Math.pow(x, y);
}

// here we set the return type to a string!
function pow_ver_2(x:number, y:number): string {
  return Math.pow(x, y);
}
```
Functions that don't return a value can be of type `void` or `any`. Usually these are event listeners or side effects

## Array

```typescript
// enforce the type by writing type followed by '[]'
const arr: number[] = [];

arr.push(1); // ok!
arr.push('23'); // not ok!
arr.push(false); // not ok!

```

Tuples are a fixed length arrays where each element has its own type:
```typescript
type MyList = [number, string, boolean]

const arr: MyList = []; // Currently an error because initialising it as empty 

arr.push(1); 
arr.push('23'); 
arr.push(false); 

```
To fix the issue above, you can add `?` to the types to make them optional. That is, `type MyList = [number?, string?, boolean?]`.

## Generics

```typescript
class Observable<T> {
  constructor(public value: T) {}
}

// Passing in types at a later point of a code!
let x: Observable<number>

let y: Observable<Person>;

// Implicit internal number type
let z = new Observable(23);
```
