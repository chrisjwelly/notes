An unorganised mess to be sorted out in the future

# 7 Dec 2020 - 11 Dec 2020

## Installing MySQL
Follow this link: https://dev.mysql.com/doc/mysql-getting-started/en/

By following the installer, you should get a key for the `root` user. Save this somewhere first.

With reference to https://dev.mysql.com/doc/refman/8.0/en/osx-installation-notes.html, it is advisable to add these aliases:
```
alias mysql=/usr/local/mysql/bin/mysql
alias mysqladmin=/usr/local/mysql/bin/mysqladmin
```

Now you can change password for the `root` user:
```
mysql -u root -p
ALTER USER 'root'@'localhost' IDENTIFIED BY 'new_password';
```

## Reinstalling MySQL:
Note that some of these might fail because some files don't exist
Remove from HomeBrew:
```
brew remove mysql
brew cleanup
```

Remove files:
```
sudo rm /usr/local/mysql
sudo rm -rf /usr/local/var/mysql
sudo rm -rf /usr/local/mysql*
sudo rm ~/Library/LaunchAgents/homebrew.mxcl.mysql.plist
sudo rm -rf /Library/StartupItems/MySQLCOM
sudo rm -rf /Library/PreferencePanes/My*
```

Remove previous MySQL Preferences:
```
rm -rf ~/Library/PreferencePanes/My*
sudo rm -rf /Library/Receipts/mysql*
sudo rm -rf /Library/Receipts/MySQL*
sudo rm -rf /private/var/db/receipts/*mysql*
```

## Storing passwords in the Database
References:
* https://www.youtube.com/watch?v=8ZtInClXe1Q
* https://auth0.com/blog/adding-salt-to-hashing-a-better-way-to-store-passwords/
* Go Example: https://hackernoon.com/how-to-store-passwords-example-in-go-62712b1d2212

In summary, these are the key ideas:
1. Don't just store password directly. Worst idea ever
2. Directly hashing the password and storing it in database. Vulnerable to rainbow table attack
3. Instead, add a salt (random string) to the password, and then perform some encryption. Store the encrypted password and the salt to the database. When logging in, you can append the same salt and encrypt the salted password attempt to see if it matches the encrypted password

In Golang, there is no need to store the salt, because the `bcrypt` package does it automatically:
https://godoc.org/golang.org/x/crypto/bcrypt

Function to encrypt password based on https://gowebexamples.com/password-hashing/:
```go
// passwords.go
package main

import (
    "fmt"

    "golang.org/x/crypto/bcrypt"
)

func HashPassword(password string) (string, error) {
    bytes, err := bcrypt.GenerateFromPassword([]byte(password), 14)
    return string(bytes), err
}

func CheckPasswordHash(password, hash string) bool {
    err := bcrypt.CompareHashAndPassword([]byte(hash), []byte(password))
    return err == nil
}

func main() {
    password := "secret"
    hash, _ := HashPassword(password) // ignore error for the sake of simplicity

    fmt.Println("Password:", password)
    fmt.Println("Hash:    ", hash)

    match := CheckPasswordHash(password, hash)
    fmt.Println("Match:   ", match)
}
```

## JWT
Good references:
* https://jwt.io/introduction/
* Golang example: https://learn.vonage.com/blog/2020/03/13/using-jwt-for-authentication-in-a-golang-application-dr#

The Golang example is so complete with sign in and sign out, as well as the usage of Redis.

## Socket Programming in Go
Good references:
* https://dev.to/alicewilliamstech/getting-started-with-sockets-in-golang-2j66
* https://www.youtube.com/watch?v=yW1ltZidh7g

## Idiomatic Golang
I once wrote a mutex code that looks along the lines of:
```go
func demoMutex() {
  mutex.Lock()

  _, err := doSomething1()
  if err != nil {
    mutex.Unlock()
    return
  }

  _, err = doSomething2()
  if err != nil {
    mutex.Unlock()
    return
  }

  mutex.Unlock()
  return
}
```

A better way to do handle this is through the usage of `defer`
```go
func demoMutex() {
  mutex.Lock()

  defer mutex.Unlock()

  _, err := doSomething1()
  if err != nil {
    return
  }

  _, err = doSomething2()
  if err != nil {
    return
  }

  return
}
```

