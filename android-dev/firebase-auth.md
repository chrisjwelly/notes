[Reference](https://www.youtube.com/watch?v=ylqOGRZNEKs&list=PLk7v1Z2rk4hhUCFBSnVTECda_MdTp3GnQ&index=1)

# Setting-up Firebase
In Android Studio, this is really simple. Simply click on the upper-right hand corner and log-in to the Google account you want to use. You can then go to Tools -> Firebase. Select 'Authentication', 'E-mail and Password authentication', and follow the steps outlined at least up to step 2. 

In step 2, your gradle should be re-building itself. It may take some time so take this time to visit console.firebase.google.com , there you should be opening your project. Go to Authentication -> Sign-in method, and enable Email/Password authentication. 

Your gradle should have rebuilt itself by now. Time to implement registration

# Registration and Signing in
It is important that you include this line of code at the top level of the class:
```kotlin
private lateinit var mAuth: FirebaseAuth
```

Afterwards, what's important is to have your `onCreate` method like this:
```kotlin
override fun onCreate(savedInstanceState: Bundle?) {
    super.onCreate(savedInstanceState)
    setContentView(R.layout.activity_register)

    // IMPORTANT!!
    mAuth = FirebaseAuth.getInstance()

    // What happens when you click the button
    button_register.setOnClickListener {
        val email = edit_text_email.text.toString().trim()
        val password = edit_text_password.text.toString().trim()

        // Start of input validations
        if (email.isEmpty()) {
            edit_text_email.error = "Email Required"
            edit_text_email.requestFocus()
            // Exit this setOnClickListener
            return@setOnClickListener
        }

        if (!Patterns.EMAIL_ADDRESS.matcher(email).matches()) {
            edit_text_email.error = "Valid Email Required"
            edit_text_email.requestFocus()
            return@setOnClickListener
        }

        if (password.isEmpty() || password.length < 6) {
            edit_text_password.error = "6 char password required"
            edit_text_password.requestFocus()
            return@setOnClickListener
        }
        // End of input validations

        // Helper function
        registerUser(email, password)
    }
}
```

And your helper function
```kotlin
private fun registerUser(email: String, password: String) {
    // This is if you have progressbar that keeps spinning. XML-dependent
    progressbar.visibility = View.VISIBLE
    
    // this method is key!!
    mAuth.createUserWithEmailAndPassword(email, password)
        .addOnCompleteListener(this) { task ->
            progressbar.visibility = View.GONE
            if (task.isSuccessful) {
                // Registration success
                // util
                login()
            } else {
                task.exception?.message?.let {
                    showToast(it)
                }
            }

        }
}

fun login() {
    // Registration success
    val intent = Intent(this, DashboardActivity::class.java).apply {
        // we want to start a fresh activity. Will nullify the old activity (can't go back)
        flags = Intent.FLAG_ACTIVITY_NEW_TASK or Intent.FLAG_ACTIVITY_CLEAR_TASK
    }
    startActivity(intent)
}
```

As for signing in, it should be mostly similar. The only difference is that instead of `createUserWithEmailAndPassword`, you will use the `signInWithEmailAndPassword` function. 

## Active sessions
If you already have an active session, you can override `onStart()` method. This uses Kotlin syntax. Which means if the `currentUser` is not null, we will call `login()`. Otherwise (the currentUser is null, meaning not logged in), we ignore the block entirely
```kotlin
override fun onStart() {
    super.onStart()
    // If already logged in, just start the dashboard activity
    mAuth.currentUser?.let {
        login()
    }
}
```

# Signing out
This one is simpler, all you did to have is an `onClickListener`. Here is a code snippet of the important part of the code:
```kotlin
...
    // Note the .create().show() at the end!!
    R.id.btn_sign_out -> {
        AlertDialog.Builder(this).apply {
            setTitle("Are you sure?")
            /* _, _ means that you are not gonna use the parameters,
                technically you can use the parameter names but you are gonna
                get warnings that you are not using the parameter
            */
            setPositiveButton("Yes") { _, _ ->
                // The important bit of signing out
                FirebaseAuth.getInstance().signOut()
                // logout() is similar to login(), it's just the direction of
                // activity starting is reversed
                logout()
            }
            setNegativeButton("Cancel") { _, _ ->
            }
        }.create().show()
    }
...
```
