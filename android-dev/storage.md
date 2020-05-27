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

## Error: To use Coroutine features, you must add `ktx`....
When going through the hands-on tutorial, you might encounter the error above. Refer to this [Stack Overflow post](https://stackoverflow.com/questions/58671990/repeated-build-fails-to-use-coroutine-features-you-must-add-ktx) for a solution.

In particular, add this to your app/build.gradle:
```
implementation 'androidx.room:room-ktx:2.2.1'
```

## Alternatives to Coroutines
You cannot access database in the main thread, so you need to do database accesses asynchronously. The tutorial goes through the `suspend` function of coroutines, but my mentor said this might be overkill for simple apps. An alternative I found is `Executor` (refer to this [Stack Overflow post](https://stackoverflow.com/questions/46482423/android-room-asynctask)):
```kotlin
executor = Executors.newSingleThreadExecutor()
executor.execute {
  // things you want to do asynchronously
  myDao.insert(model)
}
```

An alternative is `AsyncTask`, but I didn't study this enough to talk about it yet hahaha.

## Querying for single object using its primary key
Kinda like a hash table access with the key. If you have a `model_table`, with `id` as its primary key, you can define a `Dao` method like this:
```kotlin
@Query("SELECT * FROM model_table where id = :id")
fun getModelById(id: Int): Model
```

