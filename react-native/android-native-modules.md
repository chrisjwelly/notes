Sometimes you may need to expose the native Android API to the JavaScript and this can be done via React Native modules. You can refer to the full thing [here](https://reactnative.dev/docs/native-modules-android). When I did it, there was no need to run the Native Modules Setup. Code snippets will be in Kotlin. However, there will be parts of the code that was auto-converted code by Android Studio from Java to Kotlin. Syntax may be weird.

# Finish Activity
Use case: calling `finish` on the activity upon pressing a "back" button in the React Native UI.

## Code
This code is with reference to this [Stack Overflow post](https://stackoverflow.com/a/58509781/11284745)
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
Take note for the above, when you copy the Java code from the docs you may encounter a problem with `ViewManager`, saying that "2 type arguments expected for class `ViewManager<T: ...., C: ...>`". This [Stack Overflow post](https://stackoverflow.com/questions/48051190/kotlin-one-type-argument-expected-for-class-for-abstract-generic-view-holder) might help.

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

# Multiple Modules
Creating Multiple modules is as simple as creating a new Kotlin file and in your package kotlin file, do this:
```kotlin
override fun createNativeModules(
  reactContext: ReactApplicationContext
): List<NativeModule> {
  val modules: MutableList<NativeModule> = ArrayList()
  modules.addAll(
    listOf(FirstModule(reactContext),
      SecondModule(reactContext),
      ThirdModule(reactContext))
  )
  return modules
}
```

Important note: Make sure that the `getName()` method in the respective module are unique:
FirstModule.kt:
```kotlin
override fun getName(): String {
  return "First"
}
```

SecondModule.kt:
```kotlin
override fun getName(): String {
  return "Second" // Different
}
```

Then you can import it in your JS code as per normal.

# Returning a value using the native module methods
By default, methods annotated with `@ReactMethod` are void/unit functions. They must not return. So if you want to obtain a value, you have to do a little bit more. You should refer to callbacks/promises in the [docs](https://reactnative.dev/docs/native-modules-android.html#callbacks). This [video](https://www.youtube.com/watch?v=u8auHumLWK4) might also help.

I personally only used Promises and this is how I did it. Suppose from the JS code, you want to call a native method that checks whether a number is even or odd. In the native code, do this:
FirstModule.kt:
```kotlin
@ReactMethod
fun isEven(n: Int, promise: Promise) {
  try {
    val isEven = n % 2 == 0

    promise.resolve(isEven)
  } catch (e: Exception) {
    promise.reject("An error occurred", e)
  }
}
```
Notice in the code above, you are passing `Promise` as a parameter. Don't be confused in the code below when you don't see it!

Then in the JS code, you have to use `async`/`await` syntax.
```js
nativeIsEven = async (n) => {
  try {
    // one argument instead of two
    return await First.isEven(n);
  } catch (e) {
    console.log(e);
  }
}

componentDidMount = async () => {
  ...
  let isEven = await this.nativeIsEven(10);
  ...
}
```
In both functions, notice the usage of `async` and `await`. So all in all, whoever is calling the function needs to be annotated with `async`, and the piece of code that actually calls another `async` function must use `await` for us to expect the result.

Also notice the call to the native module doesn't even have `Promise` passed as an argument. Don't panik, this is okay. I don't know why yet, but all I know is that this is ok.
