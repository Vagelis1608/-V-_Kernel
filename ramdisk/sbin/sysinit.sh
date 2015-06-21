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
if [ -e /data/local/init.log ]; then
    rm -f /data/local/init.log
fi
touch -p /data/local/init.log
for FILE in /system/etc/init.d/*; do
    echo "Script: $FILE" >> /data/local/init.log
    sh $FILE >> /data/local/init.log
    echo "# End of $FILE" >> /data/local/init.log
    echo "" >> /data/local/init.log
done;

# Start userinit.d
if [ -e /sdcard/userinit.d ]; then
    if [ -e /data/local/userinit.log ]; then
        rm -f /data/local/userinit.log
    fi
    touch -p /data/local/userinit.log
    for FILE in /sdcard/userinit.d/*; do
        echo "Script: $FILE" >> /data/local/userinit.log
        sh $FILE >> /data/local/userinit.log
        echo "# End of $FILE" >> /data/local/userinit.log
        echo "" >> /data/local/userinit.log
    done;
fi

