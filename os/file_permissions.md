[Setting file permissions in Mac OS](https://www.macinstruct.com/node/415)

# File Permissions and `chmod`
When you type `ls -l` in the terminal, you might encounter something like `-rw-r--r--` in the leftmost part of your file. These are file permissions. The first dash indicates whether a file is a directory or not. If it is '-', then it is a normal file, while if it is 'd', then it is a directory.

The remaining characters are actually clusters of 3. The 3 characters in a cluster represent 'r' - read, 'w' - write, and 'x' - execute. The 3 clusters represent 'owner', 'group', and 'everyone'.

You can change these file permissions by using `chmod`. For example, `chmod 644 filename` will change the permissions of that file to `-rw-r--r--`. But how is `644` interpreted?

You can imagine that every single number is mapped to a binary number. 6 is 110 and 4 is 100 in binary respectively. Where there is 1, that permission is set. So in this example, the 6 (which is 110) represents 'rw-', while 4 (which is 100) represents 'r--'.
