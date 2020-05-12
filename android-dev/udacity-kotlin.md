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

# Lesson 2: Layouts
1 and 2 are intro

## 3. View Groups & View Hierarchy
All visual elements make up a screen are views, all children of the `View` class. Share a lot of properties such as width and height and a background. All can be made interactive

Examples: `TextView` for holding text, `ImageView` and `Button`. Other views: `EditText`, Checkboxes, sliders, and many many more.

Can implement custom views.
Unit for expressing location is Density Independent Pixel (dp). Abstract. on 160 dpi screen: 1 dp == 1 pixel, on a 480 dpi: 1 dp == 3 pixels. Android devices will handle automatically.

Views that make up a layout are hierarchy of groups. ViewGroups contain other views as a primary job. Commonly a layout has a top-level ViewGroup and any other amount of View or ViewGroup. LinearLayout can be vertical or horizontal. Then you add views to it. Because the about me app has a simple vertical layout.

There is also a `ScrollView` for scrolling. Views in our layout are inflated. When Android needs to inflate this, these hierarchies are traversed and sometimes multiple times. For some apps the view hierarchy can get pretty complex. Android optimises the complexity but it can get slow.

Android offers `ConstraintLayout` for flat view hierarchy and optimised for complex layouts.

Other layouts are still good because of other tradeoffs. Best for arranging small or complex layouts that otherwise require deep nesting if constraint layout is not used.

4 is just creating the project, 5 is creating the activity_main.xml, 6 shows the layout editor basics

## 7. Adding a TextView
Existense of `dimens.xml` that you should create first before you can use the lightbulb to extract dimension resource
If you manually create the activity xml, don't forget to call `setContentView(R.layout.activity_main)`

## 8. Styling a TextView
Some fun things that happened:
* Added paddings
* Added layout margins
* Added a new fontFamily for Roboto (navigate to more fonts, then find Roboto and add it to the project)
* From the component tree, you can also Refactor -> Extract Style. Then it will be inside `styles.xml`

## 9. Add a TextView, ImageView, and Styling
Notable things:
* Drag and drop an image view
* Add a new yellow star
* Refactor the id from `imageView` to something else (dont manual change!)
* Set the content description, creating a resource for it
* Use the `layout_margin` resource

## 10. Adding a ScrollView
Scrollview: contain only 1 thing as a child. Usually it's just LinearLayout but in this example it's just a `TextView` inside it.

You can use `lineSpacingMultiplier` to make it more readable.

One nifty trick is the Code -> Reformat Code to make sure that the order of the attributes are consistent.

## 11. Adding an EditText for Text Input
When you click on Text in the Palette, notice that `TextView` is not underlined while the others are. Undelined Ab means that they are editable. The different Views have different validations, so you should select an appropriate one.

Important attributes:
* `inputType` where you can select which is the type of input that you want
* `hint`, which helps the user know what he should do. Delete the text so that you can see the hint

Quiz:
True - `EditText` extends `TextView`
False - You must specify an inputType for every `EditText`
True - The Android System automatically validates input based on the inputType
False - You should not provide hints because they clutter the input field
True - Selecting the narrowest inputType helps users avoid errors

## 12. Adding a Done button
To have a good styling for button:
`style="@style/Widge.AppCompat.Button.Colored"`, which gives you a `colorAccent` which you can modify in `colors.xml`

Now you need a new TextView to display something.

Visibility:
* Invisible - hides the view, but still takes up space
* Gone - takes the view but takes no space

Remember to make Text empty string because we are not showing any text

## 13. ClickHandler
Code:
`onCreate`:
```kotlin
    ...
    findViewById<Button>(R.id.done_button).setOnClickListener {
        // `it` is the done button which is passed as argument
        addNickname(it)
    }
```

New function:
```kotlin
    private fun addNickname(view: View) {
        val editText: EditText = findViewById(R.id.nickname_edit)
        val nicknameTextView: TextView = findViewById(R.id.nickname_text)

        nicknameTextView.text = editText.text
        editText.visibility = View.GONE
        view.visibility = View.GONE
        nicknameTextView.visibility = View.VISIBLE

        // hide the keyboard.
        // unexplained so we take it as it is
        val imm = getSystemService(Context.INPUT_METHOD_SERVICE) as InputMethodManager
        imm.hideSoftInputFromWindow(view.windowToken, 0)
    }
```

## 14. Data Binding
Under the hood, code uses findViewById to get references to views. Android has to traverse the view hierarchy at runtime to find it which can be difficult and slow down the app.

To fix this we use data binding pattern/technique that allows us to connect a layout and activity at compile time. It creates a helper class called binding class when activity class. Then we can access the views through generated binding class without extra overhead.

## 15. Data Binding: Views
Enable data binding by doing this in build.gradle in Module:app
```
dataBinding {
  enabled = true
}
```

Then inside `activity_main.xml`, instead of having `LinearLayout` as the top level, wrap everything with a `<layout></layout>`.

Also move the namespaces to the `<layout>` from `<LinearLayout>`. So it will look something like this:
```xml
<layout xmlns:android="..."
  xmlns:app="...">

  <LinearLayout <!-- xmlns isn't here anymore
    >
  </LinearLayout>

</layout>
```

Inside `MainActivity.kt`, insert this line to create the binding object: `private lateinit var binding: ActivityMainBinding`

Then make these changes:
```kotlin
override fun onCreate(savedInstanceState: Bundle?) {
  super.onCreate(savedInstanceState)
  // setContentView is no longer necessary
  // setContentView.... 
  binding = DataBindingUtil.setContentView(this, R.layout.activity_main)

  // instead of findViewById<Button>(R.id.done_button)
  binding.doneButton.setOnClickListener { ... }
}

private fun addNickname(view: View) {
  // use the apply method instead of binding.nickname, binding.doneButton
  // multiple times. This is syntactic sugar
  binding.apply {
    nickname.text = binding.nicknameEdit.text

    // invalidate so that they get recreated with the correct data
    invalidateAll()
    nicknameEdit.visibility = View.GONE
    doneButton.visibility = View.GONE
    nicknameText.visibility = View.VISIBLE
  }
}
```

## 16. and 17. Data Binding: Data
Keep data in a data class. For example, create a `MyName.kt` which contains a `data class MyName()`.

Then create a `<data>` block to identify data as variables to use with the views. Can do as the first child of <layout>:
```xml
<data>
  <variable
    name="myName"
    type="com.example.android.aboutme.MyName" />
</data>
```

Then to use them, you need to replace text with: `android:text="@={myName.name}"

Don't forget to create instance of myName: `private val myName: MyName = MyName("Christian James Welly")

And in `onCreate`: `binding.myName = myName`

In `addNickname:
```kotlin
myName?.nickname = nicknameEdit.text.toString()
// Invalidate all binding expressins and request a new rebind to refresh
invalidateAll()
```

18 is skipped because it's interview with tech leads.

## 19. ConstraintLayout
Constraint - A connection or alignment to another UI element, to the parent layout, or to an invisible guideline

Advantages:
* Make it responsive
* Usually flatter view hierachy
* Optimized for laying out its views
* Free-form

20 is creating project. 21 is showing how to create a simple box. A bit too much so better just visit the video again because it involves a lot of IDE-specific features.

## 22. Constraints
If you don't specify, always appear at (0, 0).

Fixed Constraint: A constraint that is specified using hard-coded number
Adaptable Constraint: Defines a relationship in relative and weighted terms
Absolute poisiotning: Positioning is numerical such as the position in x and y coordinates
Relative positioning: Views are positioned by specifying relationship to other views

Bias: like a bungy cord that keeps the views together. More bias can mean more towards one side or the other.

## 23. Ratios
Specifying a ratio is helpful when your layout has views that need to keep their shape / aspect ratio even when the screen orientation or dimensions change.

## 24. Chain
Spread Chain - Elements are spread equally in space
Packed chain - Elements are packed to use minimum space
Spread inside chain - Elements are spread to use available space with head and tail attached to the parent
Packed chain with bias - Elements are packed to use minimum space and are moved on their axis depending on bias
Weighted chain - Elements are resized to use all available space according to specified weights with head and tail glues to parent

25 is just adding new boxes

## 26. Adding Three Aligned Boxes
To select multiple of the text boxes: Command + Left Click (on Mac). Then afterwards add chain. From the topmost box, chain it to the adjacent box (in our case it's box two)'s top, and the bottom chain is attached to the adjacent box's bottom. Then all the three boxes' left constraint is attached, and so is all the right constriant.

## 27. Adding Click Listeners
Code here:
```kotlin

// common pattern: just create a list and set all the boxes to
// listen to it
private fun setListeners() {
    val clickableViews: List<View> =
        listOf(box_one_text, box_two_text, box_three_text,
            box_four_text, box_five_text)

    for (item in clickableViews) {
        item.setOnClickListener { makeColored(it) }
    }
}

// When you click corresponding boxes, it will colour up
private fun makeColored(view: View) {
    when (view.id) {
        // Boxes using Color class colors for background
        R.id.box_one_text -> view.setBackgroundColor(Color.DKGRAY)
        R.id.box_two_text -> view.setBackgroundColor(Color.GRAY)

        // Boxes using Android color resources for background
        R.id.box_three_text -> view.setBackgroundResource(android.R.color.holo_green_light)
        R.id.box_four_text-> view.setBackgroundResource(android.R.color.holo_green_dark)
        R.id.box_five_text-> view.setBackgroundResource(android.R.color.holo_green_light)

        else -> view.setBackgroundColor(Color.LTGRAY)
    }
}

```

## 28. Baseline Constraint
Useful when you are aligning two things which have different font. In Android Studio 3.6.3, you need to right click to show baseline (logo has Ab). The video shows that it exists by default but idk why hahahha.

The order of the baselining also matters. Need to look up more on this.

## 29. Add Basline Constraints to more buttons
In this exercise video, I saw the `ConstraintLayout` being given the id `constraint_layout` and it was referenced in the Kotlin code in the video. However, I couldn't seem to use it..

