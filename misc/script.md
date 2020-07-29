Notes on scripting.

# Running a script
[Reference](https://www.javatpoint.com/steps-to-write-and-execute-a-shell-script)

1. Create a file using `.sh` extension

2. Make the script executable with command:
```
chmod +x <fileName>
```

3. Run the script using:
```
./<fileName>
```

# Unzipping many zip files into directories
[Reference](https://stackoverflow.com/questions/2374772/unzip-all-files-in-a-directory)

You can use this script to unzip all zip files in a directory, into a directory of the same name. E.g. you have `file1.zip` and `file2.zip`. Running this script will create a `file1/` and `file2/` directory where the contents will be unzipped into.

unzip.sh:
```
#!/bin/sh
for zip in *.zip
do
  dirname=`echo $zip | sed 's/\.zip$//'`
  if mkdir "$dirname"
  then
    if cd "$dirname"
    then
      unzip ../"$zip"
      cd ..
      # rm -f $zip # Uncomment to delete the original zip file
    else
      echo "Could not unpack $zip - cd failed"
    fi
  else
    echo "Could not unpack $zip - mkdir failed"
  fi
done
```

To change this script to suit other kinds of zipped file extensions, just change `*.zip` and `'s/\.zip$//'` (2nd and 4th line) into the corresponding extension.
