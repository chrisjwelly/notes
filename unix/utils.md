Some command line utilities which helped me.

## Formatting the output of `ls`
[Reference](https://unix.stackexchange.com/a/22224).

You can use `awk` as such:
```sh
ls -l | awk '{print $5, $9}'
```

This will print the file size in bytes followed by the filename, separated by a whitespace
