# Ruby
With reference from [Ruby in 100 Minutes](http://tutorials.jumpstartlab.com/projects/ruby_in_100_minutes.html)

## 1. Instructions & Interpreters
Ruby is an interpreted language. To execute Ruby, you can do so through IRB or through the command line

### Running Ruby from command line
Suppose we have this code snippet named `my_program.rb`:
```ruby
class Sample
  def hello
    puts "Hello, world!"
  end
end

s = Sample.new
s.hello
```
We could run the program by typing this in the command line: `ruby my_program.rb`

### Running Ruby from IRB
IRB is an REPL for Ruby. Start IRB in the terminal by typing `irb`

## 2. Variables
You don't need to declare the type to a variable. 

### Creating & Assigning a Variable
Ruby variables are automatically created when you assign a value to them. i.e. There is no need to assign a value to it

```ruby
a = 5 # => 5
a # => 5
```
The first line creates a variable `a` and stores `5` into it.

#### Right Side First
When evaluating an assignment, ruby evaluates the right side first:
```ruby
b = 10 + 5 # => 15, because (10 + 5) is evaluated first
```

#### Flexible Typing
Variables can hold any types and change the type they hold
```ruby
c = 20 # => 20 (a number)
c = "hello" # ok, despite assigning a string!
```

#### Naming Variables
Requirements:
* always start with lowercase (underscore ok, but rare)
* no spaces
* do not contain special chars like `$`, `@`, and `&`

Conventions:
* use `snake_case` where each word is lowercase connected by underscore
* named after meaning of content, not type of content
* aren't abbreviated

Good names include: `count`, `students_in_class`, or `first_lesson`

**Bad** examples: `studentsInClass` (camel-case), `1st_lesson` (starts with number), `students_array` (include the type of data in the name), `sts` (abbreviates).

## 3. Strings
Stores collection of letters and numbers.

### Writing a String
Like usual, starts with a quote `"`, and ends with a quote. Empty string: `""`. A single string can contain paragraphs and even pages of text; this is not uncommon!

### Substrings
Pulling out part of the whole string:
```ruby
greeting = "Hello Everyone!"
greeting[0..4] # => "Hello"
greeting[6..14] # => "Everyone!"
greeting[6..-1] # => "Everyone!"
greeting[6..-2] # => "Everyone" (no '!')
```
Chararacter in string have a position number starting with zero.
In the second line above, we are pulling out letters in position zero, one, two, three and four.

Ruby interprets negative positions to count back from the end of a string. That is why in the fourth line above, we are taking letters from position 6 all the way to the end of the string! (-1 denotes the last character)

Try to use positive numbers as it is easier to reason about, but negative positions allow looking for something based on it being at the end of the string.

### Common String Methods
`.length` tells you how many characters (space inclusive) in the string:
```ruby
my_name = "Christian James Welly"
my_name.length # => 21
```

`.split` offers you the capability to break strings into part. E.g. a sentence in string you want to break into words:
```ruby
sentence = "This is my sample sentence."
setence.split # => ["This", "is", "my", "sample, "sentence."]
```
`.split` as demonstrated above gives you back an Array. It cuts the string whenver it encounters a space (`" "`) character.

`.split` can also take in an argument if you want to split on character other than space.
```ruby
numbers = "one,two,three,four,five"
numbers.split # => ["one,two,three,four,five"]
numbers.split(",") => ["one", "two", "three", "four", "five"]
```
Second line tries to split on spaces but there's none. In the second try we specify that the splitting happens wherever there is comma!

`.sub` is like "Find and replace", which is short for substitute and it substitutes single occurences.
`.gsub` is like "Replace all", which replaces all occurences.

For both of them you need to arguments:
1. Substring you want to replace
2. The string you want to replace it with

Example:
```ruby
greeting = "Hello Hello Everyone!"
greeting.sub("Hello", "Bye") # => "Bye Hello Everyone"
greeting.gsub("Hello", "Bye") # => "Bye Bye Everyone"
```

### Combining Strings and Variables
There are two ways to combine variables with string:

#### String Concatenation 
Joins it with a plus sign
```ruby
name = "Christian"
puts "Good morning, " + name + "!"
```
(But this is quite verbose with all the `+`, Ruby offers a better method below)

#### String Interpolation
Sticking data into the middle of the string. **Only works with double-quotes strings**. We use the marker `#{}`, where inside we can put any *variables* or *Ruby code* which will be evaluated.
The example above can be translated to String Interpolation as follows:
```ruby
name = "Christian"
puts "Good morning, #{name}!"
```

Another example where we execute a Ruby code inside `#{}`:
```ruby
modifier = "very "
mood = "excited"
puts "I am #{modifier * 3 + mood} for today's class!"
# I am very very very excited for today's class!
```
`modifier * 3 + mood` is evaluated first and then injected into the outer string.

It is highly recommended to use String Interpolation instead of String Concatenation.

## 4. Symbols (New to you!)
Kinda like halfway between a string and a number. Recognisable because it starts with a colon then one or more letters: `:flag`, or `:best_friend`.

### Symbols for new programmers
Symbol is like a strpped down string with barely no methods and no string interpolations:
```ruby
"hello".methods
"hello".methods.count # 183
:hello.methods
:hello.methods.count # 84
```

### Symbols for the experienced
Symbol is like "named integer". It doesn't matter what actualy value the symbol references. Any reference to that value will give back the same value. Symbols are therefore defined in a global symbol table and their value cannot change. (I'm guessing this is like a const???)

## 5. Numbers
There are integers and floats. Integers are easy to work with because you can use normal math operations. To look at the methods, you can run `5.methods`.

### Repeating instructions
A for-loop construct in Javascript may look something like:
```javascript
for (let i = 0; i < 5; i++) {
  console.log("Hello World!");
}
```
In Ruby:
```ruby
5.times do
  puts "Hello World!"
end
```
We can do this because Ruby's integers are objects and they have methods. 

## 6. Blocks
A block starts with the `do` and ends with the `end` keyword, like the "loop" example above

#### Bracket blocks
We can use alternate markers to begin and end the block if we have single instruction, like the following:
```ruby
5.times{ puts "Hello World!" }
```

### Blocks Are Passed To Methods
Blocks are parameter passed into a method call. 

For eg: in `5.times`, we don't really know what we want to do 5 times. When you give it a block, the block is like an argument saying that this is the thing we want to do 5 times.

The `.gsub` method will run a block once for each match:
```ruby
"this is a sentence".gsub("e"){ puts "Found an E!" }
# Found an E!
# Found an E!
# Found an E!
# => "this is a sntnc"
```
`Found an E!` appears three times because we are running `puts` every time we find an "e".

### Block Parameters
Our block may need to reference the value they're working with. We can specify block parameter inside pipe characters:

```ruby
3.times do |i|
  puts "#{i}: Hello, World!"
end
# 0: Hello, World!
# 1: Hello, World!
# 2: Hello, World!
# => 3
```
Another example:
```ruby
"this is a sentence".gsub("e"){|letter| letter.upcase}
# => "this is a sEntEncE"
```
`gsub` is now using the result of the block as the replacement!

## 7. Arrays
We need to deal with a *collection* of data, and Array provides us the ability to do so.

Arrays in code:
```ruby
meals = ["Breakfast", "Lunch", "Dinner"]
# => ["Breakfast", "Lunch", "Dinner"]
meals << "Dessert" # "shovel operator" to add to the end of an array
# => ["Breakfast", "Lunch", "Dinner", "Dessert"]
meals[2]
# => "Dinner"
meals.last
# => "Dessert"
```
### Common Array Methods
- `sort`
- `each`: iterate through each elemnt
- `join`: mashing together into one
- `index`: finding address of a specific element
- `include?`: ask if element is present

## 8. Hashes
Each element is addressed by a name. It's kinda like an array but instead of number indices we use string.

### Key/Value pairs
A hash is *unordered*, organised into "key/value pairs"
```ruby
produce = {"apples" => 3, "oranges" => 1, "carrots" => 12}
puts "There are #{produce['oranges']} oranges in the fridge."
```

Creating a hash: key and value linked by the rocket `=>` symbol. You can see that it starts with `{` and ends with `}`.

Keys in hash *must be unique*. If you do `produce["oranges"] = 6`, the value `1` will be replaced by `6`. If you do `produce["grapes"] = 221`, a new key/value pair will be inserted.

`.keys` and `.values` methods are also available to just look at these halves.

### Simplified Hash Syntax
Commonly, we use symbols as keys of hash. A new variation is therefore:
```ruby
produce = {apples: 3, oranges: 1, carrots: 12}
puts "There are #{produce[:oranges]} oranges in the fridge."
```
Keys *end* with a colon rather than beginning with one. This simplified syntax works with Ruby v1.9 and higher.
