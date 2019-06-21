# Kotlin
My Kotlin notes as I am going through the Kotlin Koans

## Introduction

### Hello, World! (Functions)
Defined with a `fun` keyword. Type in parameters: Required, Return type: Optional if it can be inferred.
Examples:
Basic
```kotlin
fun sum(a: Int, b: Int): Int {
    return a + b
}
```
Expression body and inferred return type
```kotlin
fun sum(a: Int, b: Int) = a + b
```
Functions returning no meaningful value: (`Unit` return type can be omitted)
```kotlin
fun printSum(a: Int, b: Int): Unit {
    println("sum of $a and $b is ${a + b})
}
```

### Java to Kotlin conversion
In IntelliJ, you can copy paste a Java code to Kotlin file and it will automatically convert it to Kotlin for you!

### Named arguments
Suppose I have:
```kotlin
fun myFun(first: String = "a", 
          second: String = "b",
          third: String = "c",
) : String {
    return first + second + third
}
```
I can specify which argument I am supplying to when invoking the function
```kotlin
myFun(second = " new B ", third = "new C")
// returns a new B new C
// notice I don't need to supply to 'first'
```

### Default arguments
Default values are defined using the `=` after type along with the value.

They can help to reduce overloadings. Consider this overloaded method in Java:

```java
public String foo(String name, int number, boolean toUpperCase) {
      return (toUpperCase ? name.toUpperCase() : name) + number;
}
public String foo(String name, int number) {
      return foo(name, number, false);
}
public String foo(String name, boolean toUpperCase) {
      return foo(name, 42, toUpperCase);
}
public String foo(String name) {
      return foo(name, 42);
}
```

A Kotlin counterpart:
```kotlin
// Note the default values 42 and false
fun foo(name: String, number: Int = 42, toUpperCase: Boolean = false) =
        (if (toUpperCase) name.toUpperCase() else name) + number
```

### Lambdas
Kotlin support functional-style programming (yay!)
Read more about [Lambdas](https://kotlinlang.org/docs/reference/lambdas.html)

Parameter types can be omitted if it can be inferred. 
Lambda expression requires code blocks:
```kotlin
{ a, b -> a + b }
```

```kotlin
fun containsEven(collection: Collection<Int>: Boolean = collection.any { x -> x % 2 == 0 }
// is equivalent to
fun containsEven(collection: Collection<Int>: Boolean = collection.any { it % 2 == 0 }
```

### Strings
String literals in Kotlin can be escaped strings or raw string. Escaped string is like a normal Java string:
```kotlin
val s = "Hello, world!\n"
```
Whereas raw string is delimited by a triple quote(`"""`)
```kotlin
val text = """
    for (c in "foo")
        print(c)
"""
```
A raw string does not support backslash escaping

You can also remove leading whitespace with the `trimMargin()` function

String literals may contain template expressions, which are code that are evaluated and the results will be concatenated into the string. 
Examples
```kotlin
// Example 1
val i = 10
println("i = $i") // prints "i = 10"

// Example 2
val s = "abc"
println({$s.length is ${s.length}") // prints "abc.length is 3"
```

Observe that for simple things you can just omit the curly braces

### Data classes
Quick links:
* [Classes](https://kotlinlang.org/docs/reference/classes.html)
* [Properties](https://kotlinlang.org/docs/reference/properties.html)
* [Data Classes](https://kotlinlang.org/docs/reference/data-classes.html)

`var` is mutable, `val` is read-only
Kotlin has a concise syntax for declaring properties and initializing them from primary constructor:
```kotlin
class Person(val firtName: String, val lastName: String, var age: Int) { ... }
```

### Nullable types
[Null Safety](https://kotlinlang.org/docs/reference/null-safety.html)

Kotlin's type system distinguishes between those types which can hold `null` (nullable references) and those which cannot.
`String` cannot hold `null`:
```kotlin
var a: String = "abc"
a = null // compilation error
```
To allow nulls, we can declare a variable as nullable string, written `String?`
```kotlin
var b: String? = "abc"
b = null // ok
print(b)
```

This scenario allows:
```kotlin
val l = a.length // guaranteed not to cause NPE
val l2 = b.length // error: variable 'b' can be null
```

You can check for `null` the normal way:
```kotlin
val l = if (b != null) b.length else -1
```

but there is a safe call operator, written `?.`
```kotlin
val a = "Kotlin"
val b: String? = null
println(b?.length)
println(a?.length) // unnecessary safe call
```
This returns `b.length` if not null, and `null` otherwise. The type of this expression is `Int?`

Safe calls are useful in chains
```kotlin
bob?.department?.head?.name // returns null if any of the properties is null
```

You can also perform operations only for non-null values, by using the safe call operator together with `let`
```kotlin
val listWithNulls: List<String?> = listOf("Kotlin", null)
for (item in listWithNulls) {
    item?.let { println(it) } // prints Kotlin and ignores null
}
```

#### Elvis operator
When we have a nullable reference `r`, we can say "if `r` is not null, use it, otherwise use some non-null value `x` and it can be expressed with Elvis operator, written `?:`:
```kotlin
// normal
val l: Int = if (b != null) b.length else -1

// elvis
val l = b?.length ?: -1
```

You can use `throw` and `return` together with elvis operator

```kotlin
fun foo(node: Node): String? {
    val parent = node.getParent() ?: return null
    val name = node.getName() ?: throw IllegalArgumentException("Name expected")
}
```

#### The !! Operator
This option is for NPE-lovers and I do not love NPE, therefore I do not bother to continue with this section

#### Collections of Nullable Type
`filterNotNull` can be used to filter non-null elements
```kotlin
val nullableList: List<Int?> = listOf(1, 2, null, 4)
val intList: List<Int> = nullableList.filterNotNull()
```

#### Kotlin Koans Task
```java
public void sendMessageToClient (
    @Nullable Client client,
    @Nullable String message,
    @NotNull Mailer mailer
) {
    if (client == null || message == null) return;

    PersonalInfo personalInfo = client.getPersonalInfo();
    if (personalInfo == null) return;

    String email = personalInfo.getEmail();
    if (email == null) return;

    mailer.sendMessage(email, message);
}
```
is equivalent to the following in Kotlin:
```kotlin
fun sendMessageToClient(
        client: Client?, message: String?, mailer: Mailer
){
    val email = client?.personalInfo?.email
    if (email != null && message != null) {
        mailer.sendMessage(email, message)
    }
}

class Client (val personalInfo: PersonalInfo?)
class PersonalInfo (val email: String?)
interface Mailer {
    fun sendMessage(email: String, message: String)
}
```

### Smart Casts
[Reference](https://kotlinlang.org/docs/reference/typecasts.html#smart-casts)
Don't neeed the explicit cast operators:
```kotlin
// example 1
fun demo(x: Any) {
    if (x is String) {
        print(x.length) // x is automatically cast to String
    }
}

// example 2
if (x !is String) return

print(x.length) // x is automatically cast to String

// example 3, right side of || and &&
if (x !is String || x.length == 0) return

if (x is String && x.length > 0) {
    print(x.length) // x is automatically cast to String
}

// example 4 for when-expressions and while-loops
when (x) {
    is Int -> print(x + 1)
    is String -> print(x.length + 1) 
    is IntArray -> print(x.sum())
}
```

#### When Expression
[Reference](https://kotlinlang.org/docs/reference/control-flow.html#when-expression)
`when` replaces the switch operator
Simple example:
```kotlin
when (x) {
    1 -> print("x == 1")
    2 -> print("x == 2")
    else -> { // note the block
        print("x is neither 1 nor 2")
    }
}
```
Each branch can be a block, and its value is the last value of the last expression in the block

If many cases should be handled in the same way. the conditions can be combined

```kotlin
when (x) {
    0, 1 -> print("x == 0 or x == 1")
    else -> print("otherwise")
}
```

We can also check a value for being `in` or `!in` a range or collection:
```kotlin
when (x) {
    in 1..10 -> print("x is in the range")
    in validNumbers -> print("x is valid")
    !in 10..20 -> print("x is outside the range")
    else -> print("none of the above")
}
```

It is possible to capture `when` subject in a variable using following syntax

```kotlin
fun Request.getBody() = 
        when (val response = executeRequest()) {
            is Success -> response.body
            is HttpError -> throw HttpException(response.status)
        }
```
Scope of variable, introduced in `when` subject, is restricted to `when` body. (I don't quite understand this yet but it's all right)

### Extension functions
[Reference](https://kotlinlang.org/docs/reference/extensions.html)

Provides the ability to extend a class with a new functionality without having to inherit class. 
We need to prefix its name with a receiver type, which is the type being extended. The following example adds a `swap` function to `MutableList<Int>`
```kotlin
fun MutableList<Int>.swap(index1: Int, index2: Int) {
    val tmp = this[index1] // 'this' corresponds to the list
    this[index1] = this[index2]
    this[index2] = tmp
}
```

### Object Expressions
[Reference](https://kotlinlang.org/docs/reference/object-declarations.html)
Object expressions play the same role as anonymous inner classes in Java
To create an object of an anonymous class that inherits from some type, we write:
```kotlin
window.addMouseListener(object : MouseAdapter() {
    override fun mouseClicked(e: MouseEvent) { ... }
    
    override fun mouseEntered(e: MouseEvent) { ... }
})
```

If a supertype has a constructor, parameters must be passed to it
```kotlin
open class A(x: Int) {
    public open val y: Int = x
}

interface B { ... }

val ab: A = object : A(1), B {
    override val y = 15
}
// I don't understand this example
```

If we need "just an object", with no nontrivial supertypes:
```kotlin
fun foo() {
    val adHoc = object {
        var x: Int = 0
        var y: Int = 0
    }
    print(adHoc.x + adHoc.y)
}
```

### SAM Conversions
[Reference](https://kotlinlang.org/docs/reference/java-interop.html#sam-conversions)
You can pass a Lambda instead if the target is an interface with Single Abstract Method!

### Extensions on collections
[Reference](https://blog.jetbrains.com/kotlin/2012/09/kotlin-m3-is-out/#Collections)
[Kotlin Standard Library](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/)

## Conventions
