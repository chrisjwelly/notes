# Making API requests for Android Development
REST API calls in android application can be handled by Retrofit. Some example tutorials can be found [here](https://www.journaldev.com/13639/retrofit-android-example-tutorial) and [here](https://medium.com/@prakash_pun/retrofit-a-simple-android-tutorial-48437e4e5a23).

Some notes about the articles:
* They are written in Java. Since I use Kotlin, I'm still figuring out alternatives and how to do it (update: see below for more information)
* The Medium article uses an older version of the SDK. When I was trying it for the first time, I had to refactor the imported dependencies to AndroidX
* The Medium article's code will run with the following in red in the 'Run' tab: `E/RecyclerView: No adapter attached; skipping layout`, do not panic

## `SerializedName` annotation
When creating the model and the fields, use the `@SerializedName` annotation. This can be used to serialize a field with a different name instead of an actual field name ([source](https://www.tutorialspoint.com/what-to-use-serializedname-annotation-using-gson-in-java)). I interpret it as the `@SerializedName()` specifies the field name in the JSON, while the variable that has been annotated is what we can call it in our program. For example if we have a JSON like this: `{"id": 115, "name": "CJW", "person_address": "home"}`, we might create our model (in Java) like this:
```java
class Person {
  @SerializedName("id")
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

For Kotlin, it can be done like this:
```kotlin
// note that this is normal brackets and not curly ones
data class Person(
  @SerializedName("id") val id: Int,
  @SerializedName("name") val name: String,
  @SerializedName("person_address") val personAddress: String
)
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
This [Stack Overflow post](https://stackoverflow.com/questions/45940861/android-8-cleartext-http-traffic-not-permitted) seems to provide a lot of good details. Option 1 and Option 2 of the top answer didn't help me, but what helped in the end was setting `android:usesCleartextTraffic="true"` inside `AndroidManifest.xml`:
```xml
<manifest ...>
  <application
    ...
    android:usesCleartextTraffic="true"
    ...>
    ...
  </application>
</manifest>
```

## Format of data in the API request
Beware the format of data! The example is the Medium article uses data that is just an array of objects. Whereas the one I worked on was an object with 2 fields. The first field is a (hardly-noticeable) debugging info field (it seems like an error code), and the second field is the array of object data which I needed. 

Not being careful in interpreting data could result in this error:
```
java.lang.IllegalStateException: Expected BEGIN_ARRAY but was BEGIN_OBJECT at line 1 column 2 path $ 
```

## Retrofit with Kotlin
I managed to make Retrofit work with Kotlin with the help of this [article](https://dev.to/paulodhiambo/kotlin-and-retrofit-network-calls-2353). However a note for that article is that they requires some API key for their API server, so I opted to use the same API server as the one in the [Medium article](https://medium.com/@prakash_pun/retrofit-a-simple-android-tutorial-48437e4e5a23) (that is in Java).

Also the article didn't seem to mention the need to insert this to `AndroidManifest.xml`: `<uses-permission android:name="android.permission.INTERNET" />`.

I also configured setting images to the layout by using Picasso using the same medium article. An implication of this is that in the `bind` method in their `MoviesViewHolder` have to be modified to pass in a `Context`. The argument for this function should be `this@MainActivity`.

Their code wasn't very descriptive with the name of the files, so I was curious what I should name the layout for the individual items. I later figured it was `movie_item.xml` by observing that in `onCreateViewHolder` of `MoviesAdapter` class, they made a call of `inflate(R.layout.movie_item, ..., ...)`.

Aside from that, there isn't much difference that I made.

Some other potentially useful articles, but I didn't use them:
* [Kotlin and Retrofit 2: Tutorial with working codes (this one has examples and link to a complete repo!)](https://medium.com/@elye.project/kotlin-and-retrofit-2-tutorial-with-working-codes-333a4422a890)
* [Android Networking in 2019 - Retrofit with Kotlin's Coroutines](https://android.jlelse.eu/android-networking-in-2019-retrofit-with-kotlins-coroutines-aefe82c4d777)
* [Retrofit with Kotlin-Android](http://www.kotlincodes.com/kotlin/retrofit-with-kotlin/)
