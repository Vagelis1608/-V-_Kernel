#!/system/bin/sh

# -V- Kernel Mods
# by Vagelis1608 @xda-developers

# Set SELinux to Permissive 
# This should take place before init.d and userinit.d
# to make sure that it won't interfere.
setenforce 0
