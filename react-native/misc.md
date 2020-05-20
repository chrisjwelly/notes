Miscellaneous notes which may be helpful when doing React Native
# Flexbox
Learning flexbox is quite important. It essentially determines the ratio that a UI component takes up.
These are helpful videos to get started fast:
* A quick 2.5-minute [video](https://youtu.be/7_yRrrDMCwQ). This one is really clear!
* An 18-minute [video](https://youtu.be/R2eqAgR_KlU) by The Net Ninja. Gives live demonstration of some examples!

# Creating a vertical bar as separator
Refer to [this](https://github.com/kirankalyan5/react-native-segmented-control-tab/issues/35).

Basically create a `View` like this:
```
<View
  style={{
    borderLeftWidth: 1,
    borderLeftColor: 'white',
  }}
/>
```

# To have an image as background with some text in it
Use the `ImageBackground` [component](https://reactnative.dev/docs/imagebackground). What you can do is to add more `<Text>` as a child component of the `ImageBackground` component.

This 30-minute [video](https://www.youtube.com/watch?v=FznGNZeU_Xc) on building a Travel App UI has some good examples!

# Adding a Rating Star
The [react-native-ratings](https://github.com/Monte9/react-native-ratings) provide some support, but it didn't work well with `ImageBackground`, because the rating stars are inside a recatangular white background.

The [react-native-star-rating](https://github.com/djchie/react-native-star-rating) package provides better support in that aspect. But I have yet to find out how I can fill the background of an empty star.
