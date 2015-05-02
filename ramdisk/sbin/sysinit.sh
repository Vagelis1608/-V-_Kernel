#!/system/bin/sh

# -V- Kernel Mods
# by Vagelis1608 @xda-developers

# Set SELinux to Permissive 
# This should take place before init.d and userinit.d
# to make sure that it won't interfere.
setenforce 0

# Fix init.d folder
mount -o rw,remount /system
if [ ! -e /system/etc/init.d ] ; then
     mkdir /system/etc/init.d
fi
chown -R root.root /system/etc/init.d
chmod -R 755 /system/etc/init.d
mount -o ro,remount /system

# Start init.d
for FILE in /system/etc/init.d/*; do
     sh $FILE >/dev/null
done;

# Start userinit.d
if [ -e /sdcard/userinit.d ]; then
     for FILE in /sdcard/userinit.d/*; do
          sh $FILE >/dev/null
     done;
fi
