# Installation Matters
## Setting up the development environment
This is all done while reading [React Native CLI Quickstart](https://reactnative.dev/docs/environment-setup), with macOS as Development OS and Android as Target OS.

All seems well until I ran `npx react-native init AwesomeProject`, it will give an error message about "failing to install CocoaPods dependencies for iOS project which is required by this template". I chose the installation option to use brew instead of gem.

Several things I tried to do include:
* Using the manual command given as a suggestion after the initial error message
* Using `sudo gem install cocoapods` (installation seems to be successful, but re-init-ing the project doesn't change anything)
* [Installing Xcode](https://developer.apple.com/download/more/). There was a [Stack Overflow post](https://stackoverflow.com/questions/58934022/react-native-error-failed-to-install-cocoapods-dependencies-for-ios-project-w) suggesting this command: `sudo xcode-select --switch /Applications/Xcode.app`, but my laptop doesn't seem to have `Xcode.app`.

All three didn't help. However, since I am building an Android application, I simply followed with the instructions and it seems that I can run the application on Android Virtual Device normally. So I'm going to leave it as it is.

# Getting Started
With reference to the [docs](https://reactnative.dev/docs/getting-started).

In React, you can make components using either classes or functions. Originally: class components only for state. But with React's Hooks, you can add state and more to function components.

## Core Components and Native Components

### Views and mobile development
A **view** is basic building block of UI.

### Native Components
In Android, we use Kotlin/Java. With RN, you invoke views with JS using React components. At runtime, RN creates corresponding Android views for those components. Bcs RN apps are backed by the same views as Android and iOS, RN apps perform like any other apps. We call these platform-backed components **Native Components**

RN lets you build your own Native Components for Android/iOS to suit your app's needs

### Core Components
It is a set of essential, ready-to-use Native Components you can use immediately. React Native has many Core Components for everything from form controls to activity indicators. Refer to documentation.

Some Native UI components that are fastgame: `<View>`, `<Text>`, `<Image>`, `<ScrollView>`, and `<TextInput>`.

## React Fundamentals
Cover Concepts such as components, JSX, props and state

### Your first component
Note: this is function component
To define component, use JavaScript's `import` to import React and ReactNative's `Text` Core Component:
```js
import React from 'react';
import { Text } from 'react-native';
```

YOur component starts as a function:
```js function Cat() {}
```

Components are blueprints. Whatever a function component returns is rendered as a React element. React element let you describe what you see on the screen. Here the `Cat` component will render `<Text>`:
```js
function Cat() {
  return <Text>Hello, I am your cat!</Text>;
}
```
You can export function component with JS's `export default` for use *throughout* your app like so:
```js
export default function Cat() {
  return <Text>Hello, I am your cat!</Text>;
}
```

### JSX
JSX is syntax that lets you write elements inside JS. You an use variables inside it. Let's declare a name for the cat:
```js
export default function Cat() {
  const name = "Maru";
  return (
    <Text>Hello, I am {name}!</Text>
  );
}
```
Note that you are embedding it with curly braces inside `<Text>`.

Any JS expression will work between curly braces, including function calls like `{getFullName("Rum", "Tum", "Tigger")}:
```js
export default function Cat() {
  function getFullName(firstName, secondName, thirdName) {
    return firstName + " " + secondName + " " + thirdName;
  }

  return (
    <Text>
      Hello, I am (getFullName("Rum", "Tum", "Tugger"))!
    </Text>
  );
}
```
You can think of curly braces as creating a portal into JS functionality!
**JSX is included in the React library, it won't work if you don't have `import React from 'react'`**

### Custom Components
React lets you nest Core components inside each other to create new components. These nestable, reusable components are at the heart of the React paradigm.

E.g. nest `Text` and `TextInput` inside a `View` below:
```js
export default function Cat() {
  return (
    <View>
      <Text>Hello, I am...</Text>
      <TextInput
        style={{
          height: 40,
          borderColor: 'gray',
          borderWidth: 1
        }}
        defaultValue="Name me!"
      />
    </View>
  );
}
```

You can render component multiple times and places without repeating your code by using `<Cat>`:
```js
function Cat() {
  return (
    <View>
      <Text>I am also a cat!</Text>
    </View>
  );
}

export default function Cafe() {
  return (
    <View>
      <Text>Welcome!</Text>
      <Cat />
      <Cat />
      <Cat />
    </View>
  );
}
```
Any component that render other components is a **parent component**. `Cafe` is a parent, while `Cat` is a child component.

### Props
Short for "Properties" used to customize React components. For example, here you pass eacch <aCat> a different `name` for `Cat` to render:

```js
function Cat(props) {
  return (
    <View>
      <Text>Hello, I am {props.name)!</Text>
    </View>
  );
}

export default function Cafe() {
  return (
    <View>
      <Cat name="Maru" />
      <Cat name="John" />
      <Cat name="Jill" />
    </View>
  );
}
```

Most Rof RN's Core Components can be customized with props. E.g. when using `Image`, you pass it a prop named `source`:
```js
export default function CatApp() {
  return (
    <View>
      <Image
        source={{uri: "some_uri.jpg"}}
        style={{width: 200, height: 200}}
      />
    </View>
  );
}
```
`Image` has many diff props including `style`. We use double curly braces because 1. JSX syntax, 2. objects use curly braces. So think of it as passing an object in the JSX

### State
Props are arguments to configure how components render, state is like a component's personal data storage. Useful for handling data that changes over time or that comes from user interaction! State gives components memory!

*General rule: use props to configure a component when it renders. Use state to keep track of any component data that you expect to change over time.*

The cat here has a `hunger` state. We use State with Function Components.
First, import `useState` from React like so:
```js
import React { useState } from 'react';
```
Then declare component's state by calling `useState`:
```js
function Cat(props) {
  const [isHungry, setIsHungry] = useState(true);
}
```

You can use `useState` by passing any type parameters. `useState(0)` might track a number.
Calling `useState` does two things:
* It creates a "state variable" with an initial value. Here it is `true` for `isHungry`
* It creates a function to set that state variable's value--`setIsHungry`

**It's handy to think of it as `[<getter>, <setter>] = useState(<initialValue>)`**

Next you add `Button` Core Comp, give it `onPress` prop:
```js
<Button
  onPress={() => {
    setIsHungry(false);
  }}
/>
```
When someone presses it, `onPress` will fire, calling the `setIsHungry(false)`. When `isHungry` is false, the `Button`'s `disabled` prop is set to `true` and `title` changes.

```js
<Button
  // ...
  disabled={!isHungry}
  title={isHungry ? "Pour some milk plox" : "Arigathanks Gozaimuch!"}
/>
```
Although `isHungry` is a `const`, it seems like reassignable! When a state-setting function like `setIsHungry` is called, its component will re-render. In this case the `Cat` function will run again and this time, `useState` wil give us the next value of `isHungry`.

So finally just put the cats inside `Cafe()` component:
```js
export default function Cafe() {
  return (
    <>
      <Cat name="John" />
      <Cat name="Jill" />
    </>
  );
}
```
The `<>` and `</>` are fragments. Adjacent JSX elements must be wrapped in an enclosing tag. Fragments let you do that without an extra unnecessary wrapping element like `View`.

## Handling Text Input
We use `TextInput` which has the `onChangeText` prop taking a function and `onSubmitEditing` prop that takes a function to be called when text is submitted.
Let's say we have this example:
```js
import React, { Component, useState } from 'react';
import { Text, TextInput, View } from 'react-native';

export default function PizzaTranslator() {
  const [text, setText] = useState('');
  return (
    <View style{{padding: 10}}>
      <TextInput
        style={{height: 40}}
        placeholder="Type text to translate"
        onChangeText={text => setText(text)}
        defaultValue={text}
      />
      <Text style={{padding: 10, fonrSize: 42}}>
        {text.split(' ').map((word) => word && 'Pizza').join(' ')}
      </Text>
    </View>
  );
}
```
The code aboves translates their words into a different language. In the new language, everything will become 'Pizza'.
We store `text` in the state, because it changes over time. You could validate the text inside while the user types.

## Using a ScrollView
`ScrollView` is a generic scrolling container that can contain multiple components and views. The scrollable items need not be homogeneous, and can scroll both vertically and horizontally (by setting `horizontal` property).

This is an example:
```js
import React from 'react';
import { Image, ScrollView, Text } from 'react-native';

const logo = {
  uri: 'some_uri.png',
  width: 64,
  height: 64
};

export default App = () => (
  <ScrollView>
    <Text style={{ fontSize: 86 }}>Scroll me plz</Text>
    <Image source={logo} />
    <Image source={logo} />
    <Image source={logo} />
    <Image source={logo} />
    <Image source={logo} />
    <Image source={logo} />
    ...
  </ScrollView>
);
```
ScrollViews can be configured to allow paging through views using swiping gestures by using the `pagingEnabled` props. Swiping horizontally between views can also be implemented on Android using the `ViewPager` component.

The ScrollView works best to present small amount of things of a limited size. All the elements and views of a `ScrollView` are renderedm even if they are not currently shown on screen. If you have a long list of more items that can fit, use a `FlatList` instead.

## Using List Views
To present lists of data, generally you'll want to use either `FlatList` or `SectionList`.

`FlatList` displays a scrolling list of changing, but similarly structured, data. It works well for long lists of data, where numbers might change over time. But unlike `ScrollView`, `FlatList` **only renders** elements that are currently showing on the screen, not all elements at once.

`FlatList` component requires two props: `data` and `renderItem`. `data` is the source of information, while `renderItem` takes one item from the source and returns a formatted component to render.

This example creates basic `Flatlist` with hardcoded data. Each item in the `data` props is redered as a `Text` component. The `FlatListBasics` component then renders the `FlatList` and all `Text` components.

```js
import React from 'react';
import { FlatList, StyleSheet, Text, View } from 'react-native';

export default FlatListBasics = () => {
  return (
    <View>
      <Flatlist
        data = {[
          {key: 'Devin'},
          {key: 'Dan'},
          {key: 'Dominic'},
          ...
          {key: 'Julie'}
        ]}
        renderItem={({item}) => <Text>{item.key}</Text>}
      />
    </View>
  );
}
```

If you want to render a set of data broken into logical sections, then a `SectionList` is the way to go:
```js
import React from 'react';
import { SectionList, StyleSheet, Text, View } from 'react-native';

export default SectionListBasics = () => {
  return (
    <View>
      <SectionList
        sections={[
          {title: 'D', data: ['Devin', 'Dan']},
          {title: 'J', data: ['Jackson', 'James']},
        ]}
        renderItem={({item}) => <Text>{item}</Text>}
        renderSectionHeader={({section}) => <Text>{section.title}</Text>}
        keyExtractor={(item, index) => index}
      />
    </View>
  );
}
```

# React Native Component Lifecycler
With reference to this [article](https://blog.usejournal.com/understanding-react-native-component-lifecycle-api-d78e06870c6d)

## The Component Lifecycle API
```
constructor() -> componentWillMount() -> render() -> componentDidMount() -.
                                            ^                             |
                                            '-----------------------------
```

`constructor(props)` will initialise our components with initial state. No UI element rendered yet. Example:
```
constructor(props) {
  super(props);
  this.state={
    message:'hello world'
  }; // initial data. Update later
}
```

`componentWillMount` invoked only once before rendering component. Used to fetch data from external API.
```
componentWillMount() {
  fetch('apiserver')
  .then...
  .then...
}
```

`render()` must return JSX element to render, or null for nothing:
```
render() {
  return (
    <View>
      <Text>{this.state.message}</Text>
    </View>
  );
};
```

`componentDidMount()` invoked once after the native UI for this component finished rendering, good place to do some work on data. Updating state will invoke `render()` method again:
```
componentDidMount() {
  this.setState({
    message: 'i am a changed man'
  });
}
```

We will then enter a runtime loop:
```
shouldUpdateComponent() -true-> componentWillUpdate() -> render() -> componentDidUpdate() -.
                                                            ^                              |
                                                            '------------------------------
```

**Props Updated?** Lifecycles will be:
`componentWillReceiveProps(nextProps)`: will be invoked if the parent of the component has passed new props, so we need to re-render it.
`shouldComponentUpdate(nextProps)`: whether we need to re-render component
`componentWillUpdate()`: if previous method is true
`render()` assume true for the `shouldComponentUpdate()` also
`componentDidUpdate()`: Invoked after re-rendering the component

**State updated?** Lifecycles be like:
Will omit the `componentWillReceiveProps` because the change in state are intern.

Finally unmounting: `componentWillUnmount()` : called when a component is being removed.
