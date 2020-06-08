## Continuous Ping Test
When I was configuring my VPN client, there was a problem where the connection doesn't persist. It will just run for a good minute before failing on me and ocassionally succeeding again. 

A senior assisting me told me to run a continuous ping test to check for packet losses, and to do so we can type in `ping 8.8.8.8` or `ping www.google.com` in the terminal. This will ping to the Google DNS.

[Reference](https://support.siteserver.com/kb/a85/how-to-perform-a-ping-test.aspx)

## Downloading files from remote URL
You can use `wget` (might not be installed yet):
```
wget http://somerepo.example.org/something.jar
```

There is also a way to use cURL, but it seems a bit more verbose.

[Reference](https://stackoverflow.com/questions/30195670/how-to-curl-a-jar-from-remote-url)
