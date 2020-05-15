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

