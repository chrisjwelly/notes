# Android Development with Kotlin
[Reference](https://www.youtube.com/watch?v=e7WIPwRd2s8&list=PLlxmoA0rQ-Lw5k_QCqVl3rsoJOnb_00UV&index=1)

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
`res/drawable`: Image assets, Vector assets
`res/mipmap`: App launcher Icons
`res/values`: App styles and themes, color details, Localised Strings ( texts used in app UI ). 
`res/layout`: The layouts for your activity

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
