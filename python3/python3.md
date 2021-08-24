# Python3 Notes

These are my notes on Python3, which mostly comes from my preparation for Tech Interviews using Python3

## Data Structures

### Set

```py
my_set = set()

my_set.add('asd')
my_set.remove('asd') # error if it is not present

if 'val' in my_set:
    print("value is in my_set")

for val in my_set:
    print("will iterate through the values in set")
```

### Dictionary

```py
my_dict = dict()
my_dict2 = {} # Not a set!
my_dict3 = {'k1': 'v1', 'k2': 'v2', 'k3': 'v3'}

# Gets value with non-existent key. If it doesn't exist, use default value
my_dict.get('non-existent key', defaultvalue)

for v in my_dict.values():
    print("iterates through the values in dictionary")

for k in my_dict:
    print("iterates through the keys in dictionary")

for k in my_dict.keys():
    # no difference with .keys() or not
    print("iterates through the keys in dictionary")
```

### Defaultdict

```py
from collections import defaultdict

my_defauldict = defaultdict()

my_defaultdict.values() # returns view of the values
list(my_defaultdict.values()) # the type of value here slightly different from above. This will actually give the list
```

### Counter

```py
from collections import Counter

counter = Counter()
counter['k1'] += 1 # counter: {'k1': 1}
counter['k2'] += 1 # counter: {'k1': 1, 'k2', 1}
```

## Checking Empty List

```py
lst = []
if lst == []:
    print("List is empty")

if not lst:
    print("List is empty")

if len(lst) == []:
    # Should be an O(1) check, since the length of the list is stored internally
    print("List is empty")

```

## Iteration

### Complete Iteration

```py
for i in range(n):
    print("iterates through [0..n-1]")

for i in range(0, n):
    print("iterates through [0..n-1]")

for num in nums:
    print("iterates through all num in nums")

for i in reversed(range(n)):
    print("iterates down [n-1..0])
```

### Partial Iteration:

```py
for i in range(1, n):
    print("iterates through [1..n-1]")

for num in nums[1:]:
    # note: creation of the slice of references nums[1:] will take O(n) space
    # if a solution of o(n) [note: little-o notation] is desired, do not use this
    print("iterate through num in nums, excluding 1st elem")
```

## List manipulation

### Reversing

```py
nums[::-1]

# Reverses in-place
nums.reverse()
```

### Sorting

```py
copy_of_sorted_nums = sorted(nums)

# Sorts in-place
nums.sort()

# Sort with a key comparator
intervals.sort(key=(lambda interval: interval[0]))
```

## String

### Sorting a string
```py
s = "bca"

# note: sorted(s) returns a list
sorted_s = ''.join(sorted(s))
```

### Removing Trailing and Leading Newline and spaces
```py
str1 = "\n Starbucks has the best coffee \n \n   "
newstr = str1.strip()
print(newstr) # "Starbucks has the best coffee"
```

### Removing Trailing (only) Newline and spaces
```py
str1 = "   \n Starbucks has the best coffee \n  "
newstr = str1.rstrip()
print(newstr) # "Starbucks has the best coffee"
```

## Math

```
mid = (lo + hi) // 2 # floor division
```

## Misc

- If you want to use a fixed dictionary as a key to dictionary, make that fixed dictionary a tuple first
- To research: Python integers have arbitrary precisions? It won't overflow because you added beyond 32 bits
- Seems like casting ignores trailing and leading whitespaces. e.g. `int(" \n 1234 \n   ")` works just fine

## I/O
### With `fileinput`

```py
import fileinput

if __name__ == "__main__":
    lines = []
    for line in fileinput.input():
        # strip() to remove trailing newline
        lines.append((line.strip()))
```

To run the code:

```py
python3 code.py < input.txt
```

### With Files

```py
if __name__ == "__main__":
    with open("inputs.txt") as file:
        data = [int(line) for line in file]
```

## OOP tingz
Methods to take note:

* `help`
* Dunder `__init__`, `__str__`, `__repr__`

### Property Decorator Examples

```py
class Employee:
    def __init(self, ...):
        # ...
        pass

    @property
    def email(self):
        return f"{self.first}.{self.last}@email.com"
    
    @property
    def fullname(self):
        return f"{self.first} {self.last}"

    # this is interesting! 
    @fullname.setter
    def fullname(self, name):
        first, last = name.split(" ")
        self.first = first
        self.last = last

    @fullname.deleter
    def fullname(self):
        # usage: del employee.fullname
        print("delete name!")
        self.first = None
        self.last = None
```