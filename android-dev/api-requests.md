# Making API requests for Android Development
REST API calls in android application can be handled by Retrofit. Some example tutorials can be found [here](https://www.journaldev.com/13639/retrofit-android-example-tutorial) and [here](https://medium.com/@prakash_pun/retrofit-a-simple-android-tutorial-48437e4e5a23).

Some notes about the articles:
* They are written in Java. Since I use Kotlin, I'm still figuring out alternatives and how to do it
* The Medium article uses an older version of the SDK. When I was trying it for the first time, I had to refactor the imported dependencies to AndroidX
* The Medium article's code will run with the following in red in the 'Run' tab: `E/RecyclerView: No adapter attached; skipping layout`, do not panic

## `SerializedName` annotation
When creating the model and the fields, use the `@SerializedName` annotation. This can be used to serialize a field with a different name instead of an actual field name ([source](https://www.tutorialspoint.com/what-to-use-serializedname-annotation-using-gson-in-java)). I interpret it as the `@SerializedName()` specifies the field name in the JSON, while the variable that has been annotated is what we can call it in our program. For example if we have a JSON like this: `{"id": 115, "name": "CJW", "person_address": "home"}`, we might create our model (in Java) like this:
```java
class Person {
  @SerializaedName("id")
  private Integer id; // example in article uses wrapper class so I use it too
  // tutorialspoint seem to be using primitive though

  @SerializedName("name")
  private String name;

  @SerializedName("person_address")
  private String personAddress; // note that serialized name is different
  // now your program can refer to the value using `personAddress`

  // Constructor

  // Setters and Getters
  // ...
}
```

## Format when we have an array in the data
So supposing the field is an array of values, let's say an array of reviews. We should represent it like this:
```java
@SerializedName("reviews")
private List<Review> reviews;
```

Saw somewhere online (couldn't retrieve it) that should initialise it with `= new ArrayList<>()` too, but my code could work without needing it. Maybe I misread/misremembered

## Making API requests to `http` instead of `https`
In the app when I was working on it, it only told me that something went wrong without telling me what exactly went wrong. In the `onFailure()` method, I called `t.printStackTrace()` where `t` is `Throwable`. I later discovered this error:
```
Cleartext HTTP to xxx not permitted
```
This [Stack Overflow post](https://stackoverflow.com/questions/45940861/android-8-cleartext-http-traffic-not-permitted) seems to provide a lot of good details. Option 1 and Option 2 of the top answer didn't help me, but what helped in the end was setting `android:usesCleartextTraffic="true"`.

## Format of data in the API request
Beware the format of data! The example is the Medium article uses data that is just an array of objects. Whereas the one I worked on was an object with 2 fields. The first field is a (hardly-noticeable) debugging info field (it seems like an error code), and the second field is the array of object data which I needed. 

Not being careful in interpreting data could result in this error:
```
java.lang.IllegalStateException: Expected BEGIN_ARRAY but was BEGIN_OBJECT at line 1 column 2 path $ 
```

