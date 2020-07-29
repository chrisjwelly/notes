Some command line utilities which helped me.

## Formatting the output of `ls`
[Reference](https://unix.stackexchange.com/a/22224).

You can use `awk` as such:
```sh
ls -l | awk '{print $5, $9}'
```

This will print the file size in bytes followed by the filename, separated by a whitespace

## Getting disk usage of directory
NOTE: Disk Usage does not necessary reflect the 'true' file size. Due to the way the Operating System might allocate 'blocks' and the file might not occupy the whole block, the `du` command is likely to give an overestimate.
```sh
du -hd 1 | sort -rh | head -6
```

## Recursively getting the total size of files with a certain extension:
```sh
find ./ -type f -name '*.xml' -exec du -ch {} + | grep total
```
