Using Udacity's "Developing Adroid Apps with Kotlin" [tutorial](https://www.udacity.com/course/ud9012).

This document contains notes on:
* Lesson 1: Build your First App
* Lesson 2: Layout
* Lesson 7: RecyclerView

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

# Lesson 7: RecyclerView
1 is just intro for-fun video. It seems like this lesson requires applications from the previous lesson

## 2. Introduction
Advantages of RecyclerView:
* Efficient display of large list
* Minimizing refreshes when an item is updated, deleted, or added to the list
* Reusing views that scroll off screen to display the next item that scrolls on screen
* Displaying items in a list or a grid
* Scrolling vertically or horizontally
* Allowing custom layouts when a list or a grid is not enough for the use case

Some other lists:
* ListView - 100-ish list is pretty good for this
* GridView
* LinearLayout - suitable for very small lists

## 3. Your first RecyclerView (Need to rewatch this)
Adapter - Converts one interface to work with another.

RecyclerView: Data -> Adapter -> RecyclerView. We don't want to change the way we store or process data just to process it to the screen. Build an adapter so that we can display it in RecyclerView

Concretely Data = Room + ViewModel. In adapter, details such as scrolling doesn't require changes to the room or viewmodel.

Note: Adapter is a general pattern.

Adapter Interface must provide:
* How many items
* How to draw an item
* Create a new view - important! While recyclerview handles the recycling, it does not know what kind of view you will display

RecyclerView runs, it will use adapter to figure how to display data. It starts by asking adapter how many items. It will be create views for the screen. RecyclerView will ask adapter to create new view for the first data item, then once it has the view it will ask adapter to draw the item. It will repeat until no more views can fit the screen.

When recycling, RecyclerView doesnt need to create a view, it will just reuse and ask adapter how to draw it.

To implement recycling and support multiple type of views, RecyclerView doesn't interact with views but instead ViewHolders.

`ViewHolders`:
* hold views (lol)
* Store information for RecyclerView which is used to efficiently move views
* RecylerView's main interface. know last position the items have in the list

Extra info taken care for us, so we don't need to pay much attention to it. ViewHolder is an implementation detail of RecyclerView.

Pay special attention to where the adapter fits!

## 4. Adding a RecyclerView
Uses code from lesson 6 which at this point I haven't done HAHAHA. Will clone the repo

### Replacing ScrollView to RecyclerView:
Create the following in fragment_sleep_tracker.xml:
```xml
<androidx.recyclerview.widget.RecyclerView 
  android:id="@+id/sleep_list"
  ...
  ...
  app:layoutManager="androidx.recyclerview.widget.LinearLayoutManager"
/>
```
AppLayoutManager = how to actually position the elements of the list
`LinearLayoutManager` lays out the items in a list of full-width roles. 

### Creating a new adapter
In SleepNightAdapter.kt:
Write this:
```kotlin
// What kind of view holder will it be working with? Here it's generic TextItemViewHolder
class SleepNightAdapter: RecyclerView.Adapter<TextItemViewHolder>() {
    // data source
    var data = listOf<SleepNight>()

    override fun getItemCount() = data.size

    override fun onBindViewHolder(holder: TextItemViewHolder, position: Int) {
        val item = data[position]
        holder.textView.text = item.sleepQuality.toString()
    }
}

```
RecyclerView won't use `data` directly and it won't even know `SleepNight` exists. Position: position in the list we are supposed to be binding

`onBindViewHolder`: We need to update the views held by this `ViewHolder` to show the item at the position past. So if we are past pos 3, then we have to update `ViewContent` to position 3. Method only calls for items on screen or items just about to be on the screen.

## 5. Display SleepQualityData
Tell RecyclerView how to create a new `ViewHolder`. In practice, View and ViewHolders are kinda referred to as the same thing.

Whenever RecyclerView needs a new ViewHolder, this method will give it one. Maybe for the first item or when there is more item.

The parameters `ViewGroup` the new view will be added after its bound to an adapter position. Just means that this view will be added to some `ViewGroup` before it gets displayed to the screen. `ViewGroup` holds a few `View`

`ViewType` is used when you have multiple types to be shown in the `RecyclerView`.

We define the method `onCreateViewHolder()`:
```kotlin
    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): TextItemViewHolder {
        // Somewhat important to use the right context. Views know a lot about themselves
        // Random context like application context you might get views with unexpected sizes
        val layoutInflater = LayoutInflater.from(parent.context)

        // two additional important arguments. But, you will most likely use this kind of pattern
        // for every time u define onCreateViewHolder. Slowly learn!
        val view = layoutInflater.inflate(R.layout.text_item_view, parent, false) as TextView

        // Wrap our view in a Holder and return object
        return TextItemViewHolder(view)
    }
```

We also create a custom setter to `data` that calls `notifyDataSetChanged()`:

```kotlin
// use var
var data = listOf<SleepNight>()
    // Letting recycler view know when data changes
    // custom setter to the data variable. All it has to do is update field
    // which is set value in the setter

    // Might be overkill but we keep it for now
    set(value) {
        field = value
        // tells recyclerview that the entire data might have changed
        notifyDataSetChanged()
    }

```

Now we visit the `SleepTrackerFragment` to initialise our `SleepNightAdapter`

```kotlin
val adapter = SleepNightAdapter()
binding.sleepList.adapter = adapter

// Actually tell adapter what data it should be adapting
// our view model has list of sleepnight available already, so we can add an observer.
// by using ViewModel LifecycleOwner, we can make sure this observer is around
// when RecyclerView is still onscreen only. In the observer whenever we get a non-null
// value, we just assign it to adapter data
sleepTrackerViewModel.nights.observe(viewLifecycleOwner, Observer {
    it?.let {
        adapter.data = it
    }
})
```

Debugging tips:
If you app compiles but it doesn't work:
* Make sure you've added at least one night of sleep
* Do you call `notifyDataSetChanged()` in `SleepNightAdapter`?
* Try setting breakpoint and ensure it is getting called
* Did you register an observer on `sleepTrackerViewModel.nights` in `SleepTrackerFragment`?
* Did you set the adapter in `SleepTrackerFragment` using `binding.sleepList.adapter = adapter`?
* Does `data` in `SleepNightAdapter` hold a non-empty list?
* Try setting a breakpoint in the setter and `getItemCount()`?

## 6. Recycling ViewHolders
On `onBindViewHolder`, we can show low sleep quality in red:
```kotlin
if (item.sleepQuality <= 1) {
  holder.textView.setTextColor(Color.RED)
}
```

But once you scroll, you will notice the wrong things are red, regardless of their sleepQuality value. What you want to do is to add an `else` block to reset color:
```kotlin
if (item.sleepQuality <= 1) {
  holder.textView.setTextColor(Color.RED)
} else {
  holder.textView.setTextColor(Color.BLACK)
}
```

## 7. More about ViewHolder
If you look at the `Util.kt`, then `TextItemViewHolder` seems to only be calling `RecyclerView.ViewHolder(view)`. Why can't we just pass in `view` which is `TextView`?

In essence, wrapping it in a `ViewHolder `is not a useless thing to do! A `ViewHolder` describes an item view and metadata about its place within the `RecyclerView`. One of the methods that is useful is `getLayoutPosition` or `getItemId()`. Your ViewHolder can tell the `RecyclerView` what the Id is.

Important thing: `ViewHolder` is a key part of how a `RecyclerView` actually draws, animates, and scrolls your list.

## 8. Displaying SleepQualityList
So first you gotta create a new XML file `list_item_sleep_night` and add views to the `ConstraintLayout` to build the design as seen.

Then, in `SleepNightAdapter`, create a `ViewHolder` class that extends `RecyclerView.ViewHolder`, like so:

```kotlin
class ViewHolder(itemView: View): RecyclerView.ViewHolder(itemView) {
  val sleepLength: TextView = itemView.findViewById(R.id.sleep_length)
  val quality: TextView = itemView.findViewById(R.id.quality_string)
  val qualityImage: TextView = itemView.findViewById(R.id.quality_image)
}
```

Then change the declaration of `SleepNightAdapter` to have its type parameter to be `SleepNightAdapter.ViewHolder`. I think we must keep the `SleepNightAdapter` qualifier there because we are currently "outside" its scope.

Make sure all the return type and parameters are updated to `SleepNightAdapter.ViewHolder` too.

Update onBindViewHolder:
Change `onBindViewHolder` to take `holder: ViewHolder` as parameter and update the views in `VieHolder` to display resources instead of colors:
```kotlin
override fun onBindViewHolder(holder: ViewHolder, position: Int) {
    val item = data[position]
    val res = holder.itemView.context.resources

    holder.sleepLength.text = convertDurationToFormatted(item.startTimeMilli, item.endTimeMilli, res)
    holder.quality.text = convertNumericQualityToString(item.sleepQuality, res)

    holder.qualityImage.setImageResource(when (item.sleepQuality) {
        0 -> R.drawable.ic_sleep_0
        1 -> R.drawable.ic_sleep_1
        2 -> R.drawable.ic_sleep_2
        3 -> R.drawable.ic_sleep_3
        4 -> R.drawable.ic_sleep_4
        5 -> R.drawable.ic_sleep_5
        else -> R.drawable.ic_sleep_active
    })
}
```

## 9. Refactor onBindViewHolder
Our `onBindViewHolder` is currently doing all the binding for this holder. This might not be flexible if you have many different `ViewHolder`. So what you want to do is to refactor all the binding to a `bind` function that is a method inside the `ViewHolder` class. This way, `onBindViewHolder` can easily call `holder.bind(item)`.

Some nifty tricks: Android Studio can help you refactor and extract a piece of code out as a funfction. You can also press *Option-enter* and transform the `holder` with *Convert parameter to receiver*

## 10. Refactor onCreateViewHolder
1. Encalpsulate logic for creating the `ViewHolder`, by refactoring it into a `public` method called `from`.
2. Move the `from` code into `companion object` by clicking option-enter on the `from` method, and move it to the `ViewHolder` class.
3. Change the `ViewHolder` class declaration to be `private constructor`:
```kotlin
class ViewHolder private constructor(itemView: View)
```
4. Change return statement in onBindViewHodler to:
```kotlin
return ViewHolder.from(parent)
```

Your refactored `ViewHolder` class might have this companion object:
```kotlin
companion object {
  fun from(parent: ViewGroup): ViewHolder {
    val layoutInflater = LayoutInflater.from(parent.context)
    val view = layoutInflater.inflate(R.layout.list_item_sleep_night, parent, false)

    return ViewHolder(view)
  }
}
```

## 11. Improving Data Refresh
Here, a quick summary of everything was given. A problem we have, `notifySetDataSetChanged()` is being used for updates. This:
* Re-draws **every** views
* Very expensive

Can show flickers, or hiccup while scrolling. It's gonna hang and catches up with a big jump and stuff. To fix this, we need to tell `RecyclerView` what changed. It has a rich API for updating elements.

`RecyclerView` updates:
* Add
* Remove
* Move
* Update

This is tedious, and hard to get right if you aren't careful. `RecyclerView` has a class called `DiffUtil`: helper for `RecyclerView` adapters that calculates changes in lists and minimizes modifications.

It will take an old and new list, use Myers diff to find the minimum number of changes to get it to a new list.

`DiffUtil` benefits:
* Only redraw changed Items
* Animate by default
* Efficient

## 12. Refresh Data with `DiffUtil`
At the bottom of `SleepNightAdapter.kt`, create a new class `SleepNightDiffCallback`:
```kotlin
// Type of parameters omitted for simplicity
class SleepNightDiffCallback : DiffUtil.ItemCallback<SleepNight>() {
  override fun areItemsTheSame(oldItem, newItem): Boolean {
    // Here, you are usually just comparing ID
    return oldItem.nightId == newItem.nightId
  }

  override fun areContentsTheSame(oldItem, newItem): Boolean) {
    // check if they are the same item
    // Both items are type SleepNight and they would have some
    // equality method defined automatically because they
    // are a data class (i think)
    return oldItem == newItem
  }
}
```

Now update what to extend to with:
```kotlin
class SleepNightAdapter : ListAdapter<SleepNight, SlepeNighAdapter.ViewHolder>(SleepNightDiffCallback()) {
```
Import it with `androidx....`

We can then remove code for `val data` and `getItemCount`. Replace `data[position]` with a call to `getItem()`

In `SleepTrackerFragment` `nights` observer, replace `adapter.data` asisngment with a call like this:
```kotlin
...
it?.let {
  adapter.submitList(it)
}
...
```

## 13. Add DataBinding to the Adapter
First, we want to wrap the `ConstraintLayout` in `layout` tag. Use the intention menu option-enter/alt-enter to "Convert to data binding layout". You will see `layout` being automatically defined and a <data>` tag is defined.

Now we can define a new variable called `sleep`, and rebuild the app:
```xml
<data>
  <variable
    name="sleep"
    type-".....SleepNight" />
</data>
```

In `SleepNightAdapter.ViewHolder`:
In the `from()` function, use `ListItemNightSleepNightBinding.inflate to create the binding object:
```kotlin
fn from(parent: ViewGroup): ViewHolder {
  val layoutInflater = LayoutInflater.from(parent.context)
  val binding = ListItemSleepNightBinding.inflate(layoutInflater, parent, false)
  return ViewHolder(binding)
}
```
You can alt-enter at this point to change the type reference of `ViewHolder`.

Now gotta refactor and rename ViewHolder class' constructor parameter to take a `ListItemSleepNightBinding` paramater aclled `binding.root`:
```kotlin
class ViewHolder private constructor(val binding: ListItemSleepNightbinding): RecyclerView.ViewHolder(binding.root) {
```
IMPORTANT: **val** binding should be used here to make it a property that you can access. (?)

Then remove all references to `findViewById`, to just access the binding object fields directly.

Since these things are cached inside the binding object, you can just refactor inline and remove the saved reference. 

By this point it should work and you can re-build the app.

## 14. Add Binding Adapters
You'll create binding adapters, and move data binding logic to XML

Add three binding adapters in the form of extension function, one for each view in `list_item_sleep_night` in `BindingUtils`:
Example:
```xml
// The binding adapter you pass in a custom name yourself
@BindingAdapter("sleepImage")
fun ImageView.setSleepImage(item: SleepNight) {
    setImageResource(when (item.sleepQuality) {
        0 -> R.drawable.ic_sleep_0
        1 -> R.drawable.ic_sleep_1
        2 -> R.drawable.ic_sleep_2
        3 -> R.drawable.ic_sleep_3
        4 -> R.drawable.ic_sleep_4
        5 -> R.drawable.ic_sleep_5
        else -> R.drawable.ic_sleep_active
    })
}

@BindingAdapter("sleepDurationFormatted")
fun TextView.setSleepDurationFormatted(item: SleepNight?) {
    item?.let {
        text = convertDurationToFormatted(item.startTimeMilli, item.endTimeMilli, context.resources)
    }
}
```


Then, replace the code in `SleepNighAdapter.ViewHolder.bind` with a single binding to the SleepNight item:
```kotlin
binding.sleep = item
binding.executePendingBindings() // I assume this method will trigger all the 3 newly created adapter
```

In `list_item_sleep_night`, add attributes to bind the views to the corresponding adapters. E.g. for `ImageView`: add `app:sleepImage="@{sleep}"
