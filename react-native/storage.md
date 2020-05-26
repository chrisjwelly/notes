This refers to usage of React Native with Android.

## Async Storage
Refer to the repo [here](https://github.com/react-native-community/async-storage).

### Installations
The repo would instruct you to do:
```
yarn add @react-native-community/async-storage
```

Followed by:
```
npx pod-install
```
However, you may encounter difficulties such as not being able to use `npx pod-install`. The Virtual Device would also ask you to do `react-native link @react-native......`. You mayalso end up with another error.

What you will want to do is to refer to [manual linking](https://github.com/react-native-community/async-storage/blob/master/docs/Linking.md). The only difference being, instead of adding `new AsyncStoragePackage()` to the `MainApplication.java`, you will want to modify your `ReactInstanceManager` builder in whatever ReactActivity you have (assuming you followed the docs on manual integration with existing apps).

So you will have something like:
```kotlin
reactInstanceManager = ReactInstanceManager.builder()
    ...
    ...
    .addPackage(AsyncStoragePackage())
    ...
    ...
    .build()
```

### Usage
These two videos might be useful: video [one](https://www.youtube.com/watch?v=PRGHWgTydyQ) and [two](https://www.youtube.com/watch?v=aCe0h50hyCc).

These are the key steps to use `AsyncStorage`:
1. Import first
```js
import AsyncStorage from '@react-native-community/async-storage';
```

2. Define a function like such. This function will be invoked when you do certain things, such as button press on a component:
```js
functionName = async () => {
  try {
    await AsyncStorage.setItem('key', 'value');
    this.setState({'key': 'value'}); // assume you have 'key' as a state
  } catch (e) {
    console.log(e);
  }
}
```

3. Call function somewhere:
```js
<TouchableOpacity onPress={this.functionName}>
  ...
</TouchableOpacity>
```

4. Retrieve Data for the next time you fire this component again:
```js
constructor(props) {
  super(props);

  this.getData(); // we will define getData below
}

getData = async() => {
  try {
    const data = await AsyncStorage.getItem('key');
    if (data !== null) {
      this.setState({'key': data});
    }

    // If you have more than one things in the AsyncStorage
    // const anotherData = await AsyncStorage.getItem('anotherKey');
    // if (anotherData !== null) ....
  } catch (e) {
    console.log(e);
  }
}
```

And you should be all set!
