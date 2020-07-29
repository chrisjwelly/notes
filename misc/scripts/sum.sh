#!/bin/sh
total=0

for size in $(find ./ -type f -name '*.xml' -exec ls -l {} + | awk '{print $5}') ; do
  total=$(( ${total} + ${size} ))
done

echo ${total}
