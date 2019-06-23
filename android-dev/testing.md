# Test-driven development (with Espresso)
![reference](https://www.youtube.com/watch?v=3weiK_qKuSI)

Go into Android view. Open up Java and go to the package with `(androidTest)` (the one with `test` is actually for unit tests)

Don't forget to set up the dependencies for Espresso in the build.gradle!

You can create a new method like this:
```kotlin
// This is required to fire off the Activity that you want to test
@Rule
@JvmField
val rule: ActivityTestRule<MainActivity> = ActivityTestRule(MainActivity::class.java)

@Test
fun user_can_enter_first_name() {
  onView(withId(R.id.firstName)).perform(typeText("Daniel"))
}
```

You can have a more funky test like this:
```kotlin
@Test
fun when_user_enters_first_and_last_name_check_to_confirm_that_message_is_correct() {
  onView(withId(R.id.firstName)).perform(typeText("Jake"))
  onView(withId(R.id.lastName)).perform(typeText("Smith"))
  onView(withId(R.id.button)).perform(click())
  onView(withId(R.id.message)).check(matches(withText("Welcome, Jake Smith!")))
}
```

You can do this any time and really quickly any time by right-clicking the package folder and running it!

