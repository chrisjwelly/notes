# Installation Matters
## Setting up the development environment
This is all done while reading React Native CLI Quickstart, with macOS as Development OS and Android as Target OS.

All seems well until I ran `npx react-native init AwesomeProject`, it will give an error message about "failing to install CocoaPods dependencies for iOS project which is required by this template". I chose the installation option to use brew instead of gem.

Several things I tried to do include:
* Using the manual command given as a suggestion after the initial error message
* Using `sudo gem install cocoapods` (installation seems to be successful, but re-init-ing the project doesn't change anything)
* [Installing Xcode](https://developer.apple.com/download/more/). There was a [Stack Overflow post](https://stackoverflow.com/questions/58934022/react-native-error-failed-to-install-cocoapods-dependencies-for-ios-project-w) suggesting this command: `sudo xcode-select --switch /Applications/Xcode.app`, but my laptop doesn't seem to have `Xcode.app`.

All three didn't help. However, since I am building an Android application, I simply followed with the instructions and it seems that I can run the application on Android Virtual Device normally. So I'm going to leave it as it is.

