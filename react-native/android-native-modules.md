Sometimes you may need to expose the native Android API to the JavaScript and this can be done via React Native modules. You can refer to the full thing [here](https://reactnative.dev/docs/native-modules-android). When I did it, there was no need to run the Native Modules Setup. Code snippets will be in Kotlin.

# Finish Activity
Use case: calling `finish` on the activity upon pressing a "back" button in the React Native UI.

## Code
FinishModule.kt:
```kotlin
import com.facebook.react.bridge.ReactApplicationContext
import com.facebook.react.bridge.ReactContextBaseJavaModule
import com.facebook.react.bridge.ReactMethod

class FinishModule internal constructor(private val reactContext: ReactApplicationContext) :
    ReactContextBaseJavaModule(reactContext) {

    override fun getName(): String {
        return "Finish"
    }

    @ReactMethod
    fun finishActivity() {
        val activity = reactContext.currentActivity
        activity?.finish()
    }
}
```

CustomPackage.kt:
```kotlin
import com.facebook.react.ReactPackage
import com.facebook.react.bridge.NativeModule
import com.facebook.react.bridge.ReactApplicationContext
import com.facebook.react.uimanager.ViewManager
import java.util.*
import kotlin.collections.ArrayList

class CustomPackage: ReactPackage {
    override fun createViewManagers(reactContext: ReactApplicationContext): List<ViewManager<*, *>> {
        return Collections.emptyList()
    }

    override fun createNativeModules(
        reactContext: ReactApplicationContext
    ): List<NativeModule> {
        val modules: MutableList<NativeModule> = ArrayList()
        modules.add(
            FinishModule(
                reactContext
            )
        )
        return modules
    }
}
```
Take note for the above, when you copy the Java code from the docs you may encounter a problem with `ViewManager`, saying that "2 type arguments expected for class ViewManager<T: ...., C: ...>". This [Stack Overflow post](https://stackoverflow.com/questions/48051190/kotlin-one-type-argument-expected-for-class-for-abstract-generic-view-holder) might help.

What I did was to change it to `ViewManage<*, *>`. It seems hacky, and I have yet to study what it does. But I was told it was okay.

**IMPORTANT (because I took like hours to debug this lol)**. Instead of modifying MainApplication.java as mentioned by the docs, if you have integrated RN to an existing android app, you might not have that file initialised, and that's okay. 

Essentially if you are using `ReactInstanceManager.Builder`, you can ignore `ReactApplication` and friends (which `MainApplication` would have implemented if we had it)
MyReactNative.kt:
```kotlin
    override fun onCreate(savedInstanceState: Bundle?) {
        ...
        mReactInstanceManager = ReactInstanceManager.builder()
            ...
            .addPackage(CustomPackage()) // add this according to the name of the package
            ...
            .build()

        ...
    }
```

Then you can follow the tutorial in the docs almost very similarly. Just need to change the names:

Finish.js:
```js
// Insert some documentation here
import { NativeModules } from 'react-native';
module.exports = NativeModules.Finish;
```

and in index.js (or wherever you want to use it):
```js
import Finish from './native_modules/Finish'

// ...
// ...

// Call it like this
Finish.finishActivity();
```
