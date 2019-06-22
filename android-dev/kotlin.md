# Android Development with Kotlin
[Reference](https://www.youtube.com/watch?v=e7WIPwRd2s8&list=PLlxmoA0rQ-Lw5k_QCqVl3rsoJOnb_00UV&index=1)

# Section 1: Getting Started
## Main Activity
The activity represents one screen in Android

The Main Activity is just the name of the Activity. Main Activity should inherit `AppCompatActivity()`. You should import `android.support.v7.app.AppCompatActivity` to do so. Don't forget constructor! 

The most basic entry point is the `onCreate` method, and you should override. Select the one with `savedInstanceState: Bundle?`

Each activity has some layout attached. The MainActivity should contain some layout attached to it. In this case, it is the `activity_main.xml`. To do so `setContentView(R.layout.activity_main)`. This is attaching the layout of `activity_main` to the MainActivity

When you run the build, the screen you see is built upon `MainActivity.kt` + `activity_main.xml`. 

Whenever we run an android application, there is an entry point and in the basic case MainActivity is this entry point. There is also an entry point for the method, which is the `onCreate` method. The functionality of `setContentView` is to render the layout.

## Project structure
There are some views in the top left, just use Project view. Our concern is the `app` folder! `app` folder is the child project of `MsgShareApp` in our example. There is a `src/main/`, where there is `java` and `res` (resources) folder. 

* `java` folder stores the logical part of the app.
* `res` stores the graphics. Whatever is visible is stored in here.

There is also `AndroidManifest.xml`. Don't worry about it too much as it is automatically generated. The `<activity android:name=".MainActivity">` and `<intent-filter>` is what determines the entry point of the application. 

`build.gradle`: Some plugins, configuration, build types and project dependencies. Whatever library you use in the future, you have to mention in the dependencies section

Application Name: This name appears on the play store for users, but you can change the App name any time manually.

Package name: Should be **unique**, and **not clash** with other apps. *Can change* package name later. E.g. `com_tumblr` is the package for tumblr. 

`app` folder: also known as a module. 

#### `res` folder:
* `res/drawable`: Image assets, Vector assets
* `res/mipmap`: App launcher Icons
* `res/values`: App styles and themes, color details, Localised Strings ( texts used in app UI ). 
* `res/layout`: The layouts for your activity

#### `AndroidManifest.xml`: 
* Contains application component details
* Declaration of Activity, Service, BroadcastReceiver and ContentProvider
* Define necessary permission (Uses Internet, User Camera
* It is like the **Summary** of the application

#### `build.gradle`
* Build configuration
* Plugins to be used
* External libraries or dependencies to be included

___
# Section 2: Exploring Android App Structure in Depth
## Explore Activity, User Interface and Views
Four Building blocks of Android:
* Activity
* Broadcast Receiver
* Service
* Content Provider

All of these must be declared in `AndroidManifest.xml`

An *Activity* represents a single screen with a user interface. 

### View
What is View? It is related more to the Layout. Break down Layout into smaller components. Things like Horizontal Scrolling. 

A Layout can have many views such as: TextView, Checkbox, Button, etc

The HelloWorld in the previous section in the `.xml` is actually a TextView!

In the past, instead of `AppCompatActivity`, it was simply `Activity`. 

## Designing layout and handle events
Use the Design tab to add views to the layout. 
Layout is divided into the 4 quadrants. Android Studio will help position all these for you

layout attributes may be different and it's okay. 
What's important is that **id must be unique**

You can go to `MainActivity.kt` and insert this:
```kotlin
btnShowToast.setOnClickListener {
    // Code
    // Takes in a Lambda
    Log.i("MainActivity", "Button was clicked!")

    Toast.makeText(this, "Button was clicked!", Toast.LENGTH_SHORT).show()
}
```

Use Alt + Enter to rectify any error!

The `Log` allows you to view it in LogCat. The `Toast` creates a toast message. **It is important to have the `show()`** method!!

## Navigating between activities
Now suppose you have a view with id of `etUserMessage` which is a text input. You can retrieve the text via `etUserMessage.text.toString()`. The 'text' is essentially the getter but in Kotlin such things don't exist (?), and that's ok.

An Intent takes in the current context and the target context. You can then define a button that redirects you to another activity upon clicking it like the following:
```kotlin
btnSendMsgToNextActivity.setOnClickListener {
    val message: String = etUserMessage.text.toString() // getting the message
    Toast.makeText(this, message, Toast.LENGTH_SHORT).show() // show the message as a toast

    val intent = Intent(this, SecondActivity::class.java)
    // ::class.java is the concept of Kotlin reflection
    startActivity(intent)
}
```

*Don't forget to declare the new Activity in `AndroidManifest.xml`!!* Not declaring it can cause your app to crash! It can be done like the following:

`<activity android:name=".SecondActivity"></activity>`

## Share Data using Explicit Intent
Intent is an operation to be performed. Explicit intent means that you know the target activity! e.g. in the above we have the SecondActivity as the target activity.

We can pass things to the intent! e.g. `intent.putExtra("key", msg)` where `msg` contains a string. The key has to be unique!

To extract, go to the target activity. Use the `getExtra`, but no getters in Kotlin. Therefore we can have: `val bundle: Bundle? = intent.extras`. Specifically now we use the key to get the string! As such: `val msg = bundle!!.getString("key")`

LinearLayout vertical orientation allows you to kind of automatically arrange and stack. Some attributes you learnt: textSize, textStyle, textColor, textAlignment, layout_margin(from all direction). 

Now in SecondActivity you can have: `txvUserMessage.text = msg` to assign the `msg` to the view with id `txvUserMessage`

## Share Data using Implicit Intent
How to share data to other applications? Like e.g. Facebook, Whatsapp, etc. In Implicit Intent, you do not know your target activity

Suppose you have a new view, and you can set a new listener like this:

```kotlin
btnShareToOtherApps.setOnClickListener {
    val message: String = etUserMessage.text.toString()

    val intent = Intent() // because this is implicit
    intent.action = Intent.ACTION_SEND
    intent.putExtra(Intent.EXTRA_TEXT, message) 
    // EXTRA_TEXT is a well-recognized key between apps
    intent.type = "text/plain"

    startActivity(Intent.createChooser(intent, "Share to: "))
}
```
This will allow you to forward the message to other applications once you click the button!

---
# Section 3: Implementing Lists and Kotlin Classes
## Introduction to RecyclerView and CardView
RecyclerView is an Advanced and Efficient ListView. Three types of orientation:
* Linear Layout
* Grid Layout
* Staggered Grid Layout

A list-like structure, grid-like structure, arranged like a puzzle

Card-like structure: have an image and a text

## Adding RecyclerView and CardView
Some steps to implement RecyclerView:
1. XML Layouts
   * Add RecyclerView
   * Design the layout for each item in the list
2. Prepare the data model
3. Create Custom Adapter class
4. Link Custom Adapter with RecyclerView

You may need to some downloading here and that's fine. Just ensure you are connected to the internet

## Define Model Class
We do so using a data class. Just create a `Model.kt` file and add a data class of Hobby. It requires a `title` which is a String.

Then we have an object declaration of `Supplier`, and define a listOf hobbies in the Supplier

## Creating Adapter Class
Adapter is something that holds the data

Link HobbiesAdapter with RecyclerView, it helps to bind data to the UI (attach models to RecyclerView)

Within the main package, create a `HobbiesAdapter`. Later on, don't forget to implement all the members function!

Honestly, I don't understand a thing but here is the code
```kotlin
class HobbiesAdapter(val context: Context, val hobbies: List<Hobby>) : RecyclerView.Adapter<HobbiesAdapter.MyViewHolder>(){
    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): MyViewHolder {
        // It is responsible for creating the ViewHolder, which is the each item in the list
        val view = LayoutInflater.from(context).inflate(R.layout.list_item, parent, false)
        return MyViewHolder(view)
    }

    override fun getItemCount(): Int {
        return hobbies.size
    }

    override fun onBindViewHolder(holder: MyViewHolder, position: Int) {
        // responsible for binding all data to all the
        // views that are created
        val hobby = hobbies[position]
        // in the future we need the position so we put it there
        holder.setData(hobby, position)
    }

    inner class MyViewHolder(itemView: View) : RecyclerView.ViewHolder(itemView) {
        fun setData(hobby: Hobby, pos: Int) {
            itemView.txvTitle.text = hobby!!.title
        }
    }
}
```

## Link RecyclerView and Custom Adapter
The basic linking can be done by modifying the `onCreate` method in the `HobbiesActivity`
```kotlin
override fun onCreate(savedInstanceState: Bundle?) {
    super.onCreate(savedInstanceState)
    setContentView(R.layout.activity_hobbies)
    // so far it is basic

    // here it can be modified to be StaggeredGridLayout 
    val layoutManager = LinearLayoutManager(this)
    // Don't forget to setOrientation like this! (kotlin style)
    layoutManager.orientation = LinearLayoutManager.VERTICAL
    // the recyclerView here is the id of the RecyclerView view
    recyclerView.layoutManager = layoutManager

    val adapter = HobbiesAdapter(this, Supplier.hobbies)
    recyclerView.adapter = adapter
}
```
Essentially, you got to set the 1) layout manager and 2) the adapter to the view.

Now the problem that we currently have is that the cards cannot be pressed. Nothing happens when you click on it. To change this, you should go to the innter class and make some inits!
```kotlin
inner class MyViewHolder(itemView: View) : RecyclerView.ViewHolder(itemView) {
    // I think this is adding properties to the class
    var currentHobby: Hobby? = null
    var currentPosition: Int = 0

    init {
        // itemView obtained from the parameter
        itemView.setOnClickListener {
            // observer that you use currentHobby, and this is a property
            // of the class
            Toast.makeText(context,
                currentHobby!!.title + " Clicked !",
                Toast.LENGTH_SHORT )
                .show()
        }

        // essentially this is the same code as before for sharing!
        itemView.imgShare.setOnClickListener {
            val message: String = "My hobby is: " + currentHobby!!.title

            val intent = Intent()
            intent.action = Intent.ACTION_SEND
            intent.putExtra(Intent.EXTRA_TEXT, message)
            intent.type = "text/plain"

            // context is required because startActivity method is in there
            context.startActivity(Intent.createChooser(intent, "Share to: "))
        }
    }

    fun setData(hobby: Hobby, pos: Int) {
        itemView.txvTitle.text = hobby!!.title

        // this is something new added
        this.currentHobby = hobby
        this.currentPosition = pos
    }
}
```

---

