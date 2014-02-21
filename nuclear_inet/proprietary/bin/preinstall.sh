#!/system/bin/busybox sh

BUSYBOX="/system/bin/busybox"

if [ ! -e /data/system.notfirstrun ]; then	
    echo "do preinstall job"	
  
	/system/bin/sh /system/bin/pm preinstall /system/preinstall
	/system/bin/sh /system/bin/pm preinstall /sdcard/preinstall

	# copy android modify tool files
	#mkdir /mnt/nanda
	#mount -t vfat /dev/block/nanda /mnt/nanda
	#$BUSYBOX cp /mnt/nanda/vendor/system/build.prop /system/
	#$BUSYBOX cp /mnt/nanda/vendor/system/media/bootanimation.zip /system/media/
	#$BUSYBOX cp /mnt/nanda/vendor/system/usr/keylayout/*.kl /system/usr/keylayout/
	$BUSYBOX	mkdir  /mnt/sdcard/UserManual
	$BUSYBOX cp  /system/Azpen_Tablet_User_Guide.pdf /mnt/sdcard/UserManual
	$BUSYBOX cp  /system/Frequently_Asked_Questions.pdf /mnt/sdcard/UserManual
  $BUSYBOX cp  /system/Product_Warranty.pdf /mnt/sdcard/UserManual
	#sync
	#umount /mnt/nanda
	#rmdir /mnt/nanda
	$BUSYBOX cp /system/etc/chrome-command-line /data/local/
	$BUSYBOX chmod 777 /data/local/chrome-command-line
	

	$BUSYBOX touch /data/system.notfirstrun	
	
	 mkdir /databk
   mount -t ext4 /dev/block/nandi /databk	
   rm /databk/data_backup.tar
   umount /databk
   rmdir /databk
   echo "preinstall ok"

elif [ -e /system/data.need.backup ];then
   echo "data backup:tar /databk/data_backup.tar /data"
   mkdir /databk
   mount -t ext4 /dev/block/nandi /databk	
   
   rm /databk/data_backup.tar

   $BUSYBOX tar -cf /databk/data_backup.tar /data
   rm /system/data.need.backup
  
   umount /databk
   rmdir /databk

else 
   echo "do nothing"
fi





