Using Udacity's "Developing Adroid Apps with Kotlin" [tutorial](https://www.udacity.com/course/ud9012).

# Lesson 1: Build your First App

1-8 are skipped as they are just miscellaneous introductions.
## 9. Main App Anatomy
`MainActivity` class is created and extends `AppCompatActivity` automatically.

`res` folder is used for resources. Static content like images, string layouts, values, and standards layouts. 

Kotlin code (in Java) is separated from static resources. Make it easier to change one of the files uses.

Don't and shouldn't edit the generatedJava folder. Looking at them is useful for debugging.

`manifests` contain `AndroidManifest.xml` which tells the OS what they need. Important: need to add the Activity that you have in the AndroidManifest.xml otherwise it will crash.

Gradle scripts, take kotlin files and external libraries, compile, bundle up res folder and generate file known as APK.

Summary -- Android project contains:
* Kotlin files for the core logic of the app
* A resources folder for static content such as images and strings
* An Android Manifest file that defines essential app details so the OS can launch your app
* Gradle scripts, for building and running your app

## 10. Quiz: App Anatomy
Answers:
* Screen layouts are in the... res folder
* Kotlin code is in the... Java folder
* Images are in the... res folder
* App Permissions are in the... AndroidManifest
* Code to build and run the app... Gradle scripts

## 11. Activity and Layout
Activity: Core android class responsible for drawing app user interface and receiving input events.

Activities are associated with layout files. `MainActivity.kt` is associated with activity_main.xml`:

Layout files: xml files expressing what the app actually looks like. Divides text images and buttons (called views) in the screen.

Connected by Layout Inflation. Triggered when activity starts. Views in xml are inflated (turned) to Kotlin view objects in memory. Can dynamically modify them.

12 is skipped because it's just turning "Hello World" to "Hello Android"

## 13. Adding the Button
Adding roll button.

`LinearLayout` is a View Group. They are responsible for holding multiple views in the screen and specify their positions.

`LinearLayout` places views linearly. Horizontal default but vertical stacking can work too.

This is the default code given to us, which I have given additional comments
```xml
<LinearLayout xmlns:android="http://schemas.android.com/apk/res/android"
    xmlns:tools="http://schemas.android.com/tools"
    android:layout_width="match_parent"
    android:layout_height="wrap_content"
    tools:context=".MainActivity">

    <TextView
        android:layout_width="wrap_content"
        android:layout_height="wrap_content"
        android:text="Hello World!" />

</LinearLayout>
```

Updated:
```xml
<LinearLayout xmlns:android="http://schemas.android.com/apk/res/android"
    xmlns:tools="http://schemas.android.com/tools"
    <!-- parent of linear layout is the root view which is the entire screen -->
    android:layout_width="match_parent"
    <!-- match the height of its content, which is only the TextView here -->
    android:layout_height="wrap_content" 
    <!-- change layout to vert bcs horiz is default -->
    android:orientation="vertical" 
    <!-- otherwise they are centered horizontally, but flushed to top -->
    android:layout_gravity="center_vertical"
    tools:context=".MainActivity">

    <TextView
        <!-- content of textview is the text itself which is "1" -->
        android:layout_width="wrap_content"
        android:layout_height="wrap_content"
        android:text="1"
        android:layout_gravity="center_horizontal"
        <!-- sp = scale indepdent pixel, sizing independently of display quality -->
        android:textSize="30sp" />

    <Button
        android:layout_width="wrap_content"
        android:layout_height="wrap_content"
        <!-- centered horizontally should be pretty clear -->
        android:layout_gravity="center_horizontal"
        <!-- use resources and abstract the roll -->
        android:text="@string/roll"/>
</LinearLayout>
```
It's good to place user-facing strings to res! Put cursor over the text on android studio and AS will correct or optimise the code.

14 is exercise.
## 15. Connecting the Button
In the previous example, you can imagine a tree hierarchy: `LinearLayout` is the root, with `TextView` and `Button` as the children. Uniquely identify the view. Let's call Button as a `roll_button`. Android Studio will create integer constant immediately inside the R (resource class). That's why in `MainActivity.kt` you can use `findViewById(R.id.roll_button)`. 

Another option in Android Studio 3.6 and higher is View Binding which replaces `findViewById`. It provides the following advantages:
* Type safety - `findViewById` requires you to specify what exactly should be returned
* Null safety - You can technically pass any ID which is an integer as parameter and this may cause `NullPointerException`. View binding references view objects directly and don't look them up by integer IDs

16 is exercise to do above

## 17. OnClickListener
You can do this to react to a button click:
```kotlin
rollButton.setOnClickListener {
  Toast.makeText(this, "button clicked", Toast.LENGTH_SHORT).show()
}
```
Toast needs access to a context. Activity is a context so we can just use `this`. Don't forget to call `show()` method to make it actually show!

## 18. Change the Text in dice
We can create this:
```kotlin
private fun rollDice() {
  val resultText: TextView = findViewById(R.id.result_text)

  val randomInt = Random().nextInt(6) + 1
  resultText.text = randomInt.toString()
}
```

19 is some video about dice. 20 is just copying images

## 21. Adding Image View
Remember to replace `TextView` with `ImageView` and assign `empty_dice` drawable to it

Replace reference to the `TextView with `ImageView`

Choose the right drawable based on random int:
```kotlin
val drawableResource = when (randomInt) {
  1 -> R.drawable.dice_1
  2 -> R.drawable.dice_2
  ...
  else -> R.drawable.dice_6
}
```
and finally assign drawableResource from above to diceImage:
```kotlin
diceImage.setImageResource(drawableResource)
```
22 is student feedback

## 23. Finding Views Efficiently
For this line of code rollDice:
```kotlin
fun rollDice() {
  // -- snip --

  val diceImage: ImageView = findViewById(R.id.dice_image)

  // -- snip --
}
```

This is expensive because you have to keep searching every time you call `rollDice()`
So instead we shall put it up before `onCreate()`:
```kotlin
lateinit var diceImage: ImageView
```
Lateinit promises that variable will be initialised before we call any method to it. We promise we won't leave it as null. So we can just initialise this (call `findViewById()` to it immediately)

## 24. Namespaces
Problem: we want to start off with empty dice. So we do this: `android:src="@drawable/empty_dice"`, but preview will show nothing. What you can do is to also ADD on `tool:src="@drawable/dice_1"`, which is `tool` namespaced elsewhere.

## 25. Introduction to Gradle
Gradle:
* What devices run your app
* Compile to executable
* Dependency management
* App signing for Google Play
* Automated Tests

APK = Android Application Package -- Executable format for distributing Android applications

Module - Collection of source files and resources for a discrete piece for a functionality of your app

Right now it's just build.gradle(Module:app).

## 26. Build.gradle
There are two files named build.gradle in this folder. The [website](guides.gradle.org/building-android-apps/) actually have a good guide.

Change view to Project view, biuld.gradle for project is directly inside root. Whereas for app is iside app

Repository in gradle = remote server where external code is downloaded from
Depedencies = external code, usch as libraries that your project depends on

Other build gradle, plugin is required to build kotlin and android projects. CompiledSdkVersion and minSdkVersion looks at what you compiled it in, and what phone supports. TargetSdkVersion tells us what version you have tested it on.

Not possible to publish with an applicationId that is not unique. Convention: reverse domain and then add application name.

Scroll down and then there are dependencies

## 27. Android Compatibility
Basically, choose a reasonable Android versions. Don't write code that will crash app devices.

AndroidX is Android Jetpack?

## 28. Vector Drawables
Vector Drawables suppported all the way from JDK 7?
Adding support:
1. Add to build.gradle
2. Use correct layout namespaace
3. Change src to srcCompat

Code:
1. Enable use of support lbrary for vector drawables in build.gradle
```kotlin
vectorDrawables.useSupportLibrary = true
```

2. Use app:srcCompat in the image tag in the layout file:
```kotlin
app:srcCompat="@drawable/empty_dice"
```

3. You'll also need to add namespace to the root of the layout
```kotlin
xmlns:app="http://schemas.android.com/apk/res-auto"
```

