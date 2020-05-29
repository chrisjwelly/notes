Information about app storage in Android can be found [here](https://developer.android.com/training/data-storage).

# Storing into app-specific files
This is for internal storage. Not touching external storage yet
## Saving into file:
```kt
private fun writeIntoFile() {
    val filename = "some_filename" // not sure if should append extension
    val string: String = // your string here

    // context can be `this` if you are in an activity
    context.openFileOutput(filename, Context.MODE_PRIVATE).use {
        it.write(string.toByteArray())
    }
}
```

## Accessing saved file (with reference from [here](https://www.javatpoint.com/kotlin-android-read-and-write-internal-storage)):
```kt
private fun readFromFile() {
    val filename = "some_filename" // not sure if should append extension

    // Reads data from file, and stores read data into a StringBuilder
    var fileInputStream: FileInputStream?
    fileInputStream = PopularMoviesApplication.context.openFileInput(filename)
    var inputStreamReader = InputStreamReader(fileInputStream)
    val bufferedReader = BufferedReader(inputStreamReader)
    val stringBuilder = StringBuilder()
    var text: String? = null
    while ({ text = bufferedReader.readLine(); text }() != null) {
        stringBuilder.append(text)
    }

    // Obtain back the saved file by using the toString() method
    return stringBuilder.toString()
}
```

Note that if file does not exist, it will throw a `FileNotFoundException`. Make sure to handle this scenario.

# Conversion from Data Class Object to JSON string and vice versa (with GSON)
If you want to store some object in the file, you might need to convert it to String before you can write such information into the file. We will do that with the help of GSON. Dependency set-up in my project when I tried was already done when I was doing Retrofit tutorials (can be found in [api-requests note](https://github.com/chrisjwelly/notes/blob/master/android-dev/api-requests.md)). Some more info can be found [here](https://www.baeldung.com/kotlin-json-convert-data-class).

## Conversion from Data Class Objects to JSON String
```kt
val movie: Movie = // some object which is of Data Class Movie
val jsonStringOneMovie = Gson().toJson(movie)

val movies: List<Movie> = // a list containing many objects of Data Class Movie
val jsonStringMovies = Gson().toJson(movies) // this is also ok. It will give the string in an array of the objects
```

## Conversion from JSON String to Data Class Objects
The List<Movie> conversion is referenced from this [Stack Overflow post](https://stackoverflow.com/a/45605731/11284745)
```kt
val jsonStringOneMovie = // some JSON string representing one object of a data class
val movie: Movie = Gson().fromJson(jsonStringOneMovie, Movie::class.java) // this is straightforward

val jsonStringMovies // Now this represents a list of objects. Which in JSON is an array of objects
val movies: List<Movie> = Gson().fromJson(jsonStringMovies, Array<Movie>::class.java).toList()
```

# Local database using Rooms
With reference to the official [docs](https://developer.android.com/training/data-storage/room). Also hands-on tutorial: [Android Room with a View - Kotlin](https://codelabs.developers.google.com/codelabs/android-room-with-a-view-kotlin/#0).

(I still don't fully understand so I will not write much about the details here but I will collect several helpful links and place it here)

But the high-level idea is as such:
1. Define the Data Class and annotate it with `@Entity`. 
2. Create a `Dao` for it. You should know some database queries for this.
3. Define a `RoomDatabase` which contains a singleton instance. It will contain methods that return the `Dao`s you need
4. Using that instance, party harddddd and do all queries you need~
5. Okay but seriously speaking, you might want to define `ViewModel` and `Repository`, but up to step 3 should be sufficient for functionalities.

## Error: To use Coroutine features, you must add `ktx`....
When going through the hands-on tutorial, you might encounter the error above. Refer to this [Stack Overflow post](https://stackoverflow.com/questions/58671990/repeated-build-fails-to-use-coroutine-features-you-must-add-ktx) for a solution.

In particular, add this to your app/build.gradle:
```
implementation 'androidx.room:room-ktx:2.2.1'
```

## Alternatives to Coroutines
You cannot access database in the main thread, so you need to do database accesses asynchronously. The tutorial goes through the `suspend` function of coroutines, but my mentor said this might be overkill for simple apps. An alternative I found is `Executor` (refer to this [Stack Overflow post](https://stackoverflow.com/questions/46482423/android-room-asynctask)):
```kotlin
val executor = Executors.newSingleThreadExecutor()
executor.execute {
  // things you want to do asynchronously
  myDao.insert(model)
}
```

If you want to get some result, (because `execute` returns void), you can do this instead:
```kotlin
val callable = Callable { someTask() }
val future = Executors.newSingleThreadExecutor().submit(callable)
future.get() // this is the result
```
Credits to this [Stack Overflow post](https://stackoverflow.com/a/59768908/11284745)

An alternative is `AsyncTask`, but I didn't study this enough to talk about it yet hahaha.

## Querying for single object using its primary key
Kinda like a hash table access with the key. If you have a `model_table`, with `id` as its primary key, you can define a `Dao` method like this:
```kotlin
@Query("SELECT * FROM model_table where id = :id")
fun getModelById(id: Int): Model
```

## Attaching `Observer` to `LiveData` in a non `LifecycleOwner`
My current application uses an MVP architecture, and I want to attach an observer to my `LiveData`. **Typically**, you would have this code in the `Activity`:
MainActivity.kt:
```kotlin
livedata.observe(this, Observer { items ->
  items?.let { adapter.setItems(it) }
})
```
But `this` here is a `LifecycleOwner` because it extends `AppCompatActivity` (I think). Whereas if you want it in your presenter, it doesn't quite work because your `XXXActivityPresenter` is likely not to be a `LifecycleOwner`.

Solution (a hacky one that is): use `observeForever`:
MainActivityPresenter.kt:
```kotlin
// Need to specify type because it can't be inferred
val observer = Observer<List<Item>> { items -> items?.let { ... } } 
livedata.observeForever(observer)

// When MainActivity (the View gets destroyed), need to detach it as well
fun onViewDestroy() {
  livedata.removeObserver(observer)
}
```

## Defining a one-to-one relationship
With reference to the [docs](https://developer.android.com/training/data-storage/room/relationships#one-to-one)
You might have an entity, that has a one-to-one relationship with another entity.

So these are the two entities you want to connect:
```kotlin
@Entity
data class User(
  @PrimaryKey val userId: Long,
  val name: String,
  val age: Int,
)

@Entity
data class Library(
  @PrimaryKey val libraryId: Long,
  val userOwnerId: Long,
)
```

You define the relationship as such:
```kotlin
data class UserAndLibrary(
  @Embedded val user: User,
  @Relation(
    parentColumn = "userId",
    entityColumn = "userOwnerId"
  )
  val library: Library
)
```
`userId` and `userOwnerId` should match.

And you will have to add this method to ANY DAO class. This is what confused you, because you thought you might need another DAO. In actuality, you can reuse the `UserDao` you might have already defined.

```kotlin
@Transaction
@Query("SELECT * FROM User")
fun getUsersAndLibraries(): List<UserAndLibrary>
```

Now another thing you notice is that you are getting `UserAndLibrary` from the `User` table. This is okay. I don't understand DB well, but this is okay and you should follow the "main" table name. So if you defined `User` table to be `user_table`, then use that.

Finally, an important point is that in the above example, when adding `User` with a certain `userId`, the database will expect having the corresponding `Library` with the same `userOwnerId` to **have already existed**. So this means that if you are adding them to the database simultaneously for some reason, you should add `Library` first.
