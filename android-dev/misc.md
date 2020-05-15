Miscellaneous notes for Android Development that I could not place appropriately anywhere.

## App Theme (without title bar)
Simply change AndroidManifest to use this: `<android:theme="@android:style/Theme.AppCompat.Light.NoActionBar">`. With inspiration from [here](https://stackoverflow.com/questions/13370719/remove-android-default-action-bar).

## View Binding
Refer to the [docs](https://developer.android.com/topic/libraries/view-binding) to learn more about View Binding. It should not be too hard to change the code to use View Binding:
1. Enable View Binding in `build.gradle`
2. Inflate all the Binding objects inside the class
3. Replace all instances of `findViewById` with a property access

If you get an `unresolved reference` error because of the non-existence of `databinding` package (I think), don't forget to Rebuild Project (courtesy of this [Stack Overflow post](https://stackoverflow.com/questions/55933708/unresolved-referenceactivitymainbinding):
```
Build -> Clean Project
Build -> Rebuild Project
```

To make View Binding work with RecyclerView, refer [here](https://stackoverflow.com/questions/60313719/how-to-use-android-view-binding-with-recyclerview). But the gist is:
1. Create `lateinit var` for the binding object, and initialise it inside `onCreateViewHolder` (inflate using 3 parameters with `parent` as 2nd param and `false` as third param)
2. Pass the `binding` object to the `ViewHolder` (this replaces the `ItemView`)
3. Change the `ViewHolder`'s parameters correspondingly. 
4. Since you are not passing an `itemView` anymore, you need to change the parameters you pass to the parent class. Instead of extending `RecyclerView.ViewHolder(itemView)`, you are now extending `RecyclerView.ViewHolder(binding.root)`

## Application Class for global variables
If you want some global variables at the application level (for example, a singleton), you can create a custom class which extends `Application`. Then create any instantiation of the variables there. You will need to add some things to the AndroidManifest.xml too.
For example:

```kotlin
class CoolApp : Application() {
  override fun onCreate() {
    super.onCreate()
    SomeLibrary.createSingleton()
  }
}
```

Then in `AndroidManifest.xml`:
```xml
<application
  android:name=".CoolApp"
  ...
  ...>
```

For more information, can refer to this [wiki link](https://github.com/codepath/android_guides/wiki/Understanding-the-Android-Application-Class)

## Retrieving String from `strings.xml` outside context or activity
For **system resources**: 
```kotlin
Resources.getSystem().getString(android.R.string.somecommonstuff)
```

However, if this is your self-defined strings, it's a little more complicated. The gist is that you want to create a static instance of a custom class which extends `Application` during that class' `onCreate()`. Afterwards, since it is static, you can reference that context anywhere. Let's say the custom class is called `CoolApp`, then you can do this:
```kotlin
CoolApp.instance.getString(R.id.string_you_wanna_retrieve)
```

References:
* [For the solution of retrieving system resources](https://stackoverflow.com/questions/4253328/getstring-outside-of-a-context-or-activity/8765766)
* [For the solution of self-defined strings](https://stackoverflow.com/questions/4391720/how-can-i-get-a-resource-content-from-a-static-context/4391811#4391811). An answer there has a nicely defined `Strings` class to help with any additional arguments.

