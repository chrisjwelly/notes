Integration with Android guide can be found [here](https://reactnative.dev/docs/integration-with-existing-apps#code-integration-1).

By following the guide, it should be mostly enough. However, watch out for these:

## Configure permissions for development error overlay
This section will tell you that we should add some code to the Activity's `onCreate()` method. It might be confusing at first, but you should read the next section first. It will ask you to create a `MyReactActivity` class. This is where the addition to the `onCreate()` method and overriding of `onActivityResult` should be done.

Also, you will see that the doc says "If your app is targeting Android `API level 23` or greater, make sure you have the permission `android.permission.SYSTEM_ALERT_WINDOW` enabled for the development build." What this means is the following:
1. Add this line to `AndroidManifest.xml`: `<uses-permission android:name="android.permission.SYSTEM_ALERT_WINDOW" />`
2. When you load the app, it will load a page that might show "Display over other apps". Adding the line above should make your application appear in this screen. Allow/enable it. 

The line quoted basically means that we should declare permission and enable it in settings. Not declaring the permission in the manifest (line 1) will make the "Display over other apps" page keep appearing and you can't do anything because our app will not appear as something you can enable.

## `java.lang.UnsatisfiedLinkError: couldn't find DSO to load: libhermes.so`
I faced this and the error appeared in the Logcat. I followed the top answer of this [Stack Overflow post](https://stackoverflow.com/questions/57036317/react-native-java-lang-unsatisfiedlinkerror-couldnt-find-dso-to-load-libherm). It involves changing two files.

Add this to **app/build.gradle**:
```
project.ext.react = [

...
    // your index js if not default, other settings
  // Hermes JSC ?
 enableHermes: false,

...
]

def jscFlavor = 'org.webkit:android-jsc:+'

def enableHermes = project.ext.react.get("enableHermes", false);

dependencies {

    implementation fileTree(dir: "libs", include: ["*.jar"])
    implementation "com.facebook.react:react-native:+"  // From node_modules

    if (enableHermes) {
      // For RN 0.60.x
      def hermesPath = "../../node_modules/hermesvm/android/"

      // --- OR ----          

      // for RN 0.61+
      def hermesPath = "../../node_modules/hermes-engine/android/";


      debugImplementation files(hermesPath + "hermes-debug.aar")
      releaseImplementation files(hermesPath + "hermes-release.aar")
    } else {
      implementation jscFlavor
    }
```

and add this to root **build.gradle**:

```
maven {
        // Android JSC is installed from npm
        url("$rootDir/../node_modules/jsc-android/dist")
    }
```

For the additions to **app/build.gradle**, I used the one for RN 0.61+. I'm not fully sure how to check, but I observed mine was 0.62+ when I ran `yarn add react-native` for the first time in the terminal, during the setup.

In my first trial, I used the 0.60.x version but that didn't go well hahaha.

## Failed Resolution of SwipeRefreshLayout
You might face an error saying this:
`    java.lang.NoClassDefFoundError: Failed resolution of: Landroidx/swiperefreshlayout/widget/SwipeRefreshLayout;`

I did not face this error when integrating an app with `appcompat:1.0.4` in the build.gradle, but instead I faced it when integrating with an app with `appcompat:1.1.0` as the dependency.

To fix, refer to [this](https://github.com/react-navigation/react-navigation/issues/6267#issuecomment-528883756).

Basically, add the following two lines to `dependencies` in `android/app/build.gradle`:
```
implementation 'androidx.appcompat:appcompat:1.1.0-rc01'
implementation 'androidx.swiperefreshlayout:swiperefreshlayout:1.1.0-alpha02'
```

OR for stable version refer to this [reply](https://github.com/react-navigation/react-navigation/issues/6267#issuecomment-601204355) in the same thread.
The two lines added are:
```
implementation 'androidx.appcompat:appcompat:1.1.0'
implementation 'androidx.swiperefreshlayout:swiperefreshlayout:1.0.0'
```

