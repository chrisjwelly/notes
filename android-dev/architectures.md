There are several architectures an Android application can adopt. This note will briefly mention:
* Model-View-Presenter
* Android Architecture Components

## Model-View-Presenter
A popular architecture which removes all business logic from `Activities`, `Fragments`, etc and put it inside a `Presenter` instead. The `Presenter` sits between and acts as a middleman for `Model` (which stores data) and call methods on `View` to display data.

From what I have seen, it seems that a new class `MainActivityPresenter` will be defined and inside it we will have an inner `View` interface. The `MainActivityPresenter` is constructed by passing `view` as parameter. Then whenever there is something in `MainActivityPresenter` that requires UI changes, we will call methods of `view`. 

It has some advantages over the traditional Model-View-Controller architecture! Elaborated in one of the further readings.

Further readings:
* [A simple demo of MVP](https://medium.com/cr8resume/make-you-hand-dirty-with-mvp-model-view-presenter-eab5b5c16e42)
* [A more hardcore MVP example, which involves Dependency Injection](https://www.raywenderlich.com/7026-getting-started-with-mvp-model-view-presenter-on-android)

## Android Architecture Components
It has official support from Google. A `View` calls `ViewModel` to get data, and data is returned as `LiveData` objects observed by the `View` object. `LiveData` objects when updated will notify `View` to update itself. An advantage of this solution is the ability to automatically unsubscribe from `LiveData` based on lifecycle events.

Readings:
* [Official Android docs](https://developer.android.com/topic/libraries/architecture)
