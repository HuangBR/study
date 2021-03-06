# android 
  1. termux in android 
  2. android x86
  3. busybox
  4. [nethunter](https://build.nethunter.com/nightly/ )

  - AOSP stands for Android Open Source Project.
  - Stock Android is what Google provides in their Nexus devices.
  - CyanogenMod (pronounced /saɪ.'æn.oʊ.dʒɛn.mɒd/) is an enhanced open source firmware distribution for smartphones and tablet computers based on the Android mobile operating system. It offers features and options not found in the official firmware distributed by vendors of these devices.   
  - [Android Internal](http://newandroidbook.com/)
    - http://newandroidbook.com/files/ArtOfDalvik.pdf

# android x86 
  * [7.0_x86](http://www.osboxes.org/android-x86/#android-x86-7_0-vmware) 
    * Disable Mouse Integration for VirtualBox: 
       Run virtual machine go to menu Machine > Disable Mouse Integration or simply press Right CTRL + i to enable/disable mouse integration.
    * for VMware:
       After setting up, go to “Virtual Machine Settings” > under “Hardware” Tab > Select “Display” > Enable “Accelerate 3D graphics”

# remote debug
  * 5.1 
    1. enable debug mode 
      * touch build number for 7 times
      * enable usb debuging
    2. connect your device through usb
      * get your ip addr:
        ```
        adb shell netcfg
        ```
      * check teh connectivity
        ```
        ping 192.168.1.4
        ```
      * open debug port 
        ```
        adb tcpip 6666
        ```
    3. connect device through wifi
      ```
      adb kill-server
      adb start-server
      adb connect 192.168.1.4:6666

      adb -s emulator install test.apk
      ```
    4. test 
      ```
      adb shell
      netstat -anltp
      ```
    5. enable usb debugging
      ```
      adb disconnect 192.168.1.4
      adb kill-server
      adb usb
      adb devices -l
      ```

# package manager
  ```
  sysdump
  adb shell pm list packages
  adb shell pm path com.example.someapp

  adb pull /data/*.apk path

  export PATH=$PATH:/data/data/com.termux/files/usr/bin:/data/data/com.termux/files/usr/bin/applets
  export LD_LIBRARY_PATH=/data/data/com.termux/files/usr/lib

  #212100447155748840-00
  ```

# flash recovery img
  - [relock](https://www.emui.com/cn/plugin/unlock/detail)
    ```
    adb reboot bootloader
    fastboot oem relock xxxx
    ```
  
  - [flash twrp](https://www.howtogeek.com/240047/how-to-flash-twrp-recovery-on-your-android-phone/)
    - enable usb debugging

    - Download TWRP(https://twrp.me/)

    - boot into bootloader
      ```
      adb reboot bootloader
      ```
    - unlock oem
      ```
      fastboot oem unlock xxxx
      fastboot oem get-bootinfo
      adb reboot bootloader
      fastboot flash recovery twrp.img

      fastboot update update.zip 
      ```
    - Boot Into TWRP Recovery
      ```
      adb reboot recovery
      ```

    - push zip(https://forums.kali.org/showthread.php?27431-How-to-safely-install-Nethunter-2-0-on-any-supported-device)
      ```
      adb push Z:\Software\Android\nethunter-flounder-marshmallow-3.0.zip /data/local/tmp/

       adb reboot-bootloader
       ```

# tools
  - apktool
  - dex2jar
  - JD-ui
  - ClassyShark.jar
  - [twrp](https://forum.xda-developers.com/showthread.php?t=1943625)


# [Android system](https://source.android.com/devices/architecture/ http://elinux.org/Android_Architecture)
  - logging system
    - a kernel driver and kernel buffers for storing log messages
      - mail - mail application log
      - event - system event infomation
      - radio - radio and phone-related information
      - system - a log for low-level system message and debugging
      ```
      cat /proc/last_kmsg > /sdcard/last_kernel_message_log.txt
      dmesg > /sdcard/kernel_boot_log.tx
      
      ls -l /dev/log
      
      ```
    - API(C, C++, Java) for making log entries and accessing logging messages
    - standalone program for viewing  log messages - logcat
    - ability to view and filter the log messages from the host machine (via eclipse or ddms)

  - [JIT or AOT](https://www.ibm.com/support/knowledgecenter/en/SSSTCZ_3.0.0/com.ibm.wrt.rtlinux.doc.30/realtime/aot.html)
    - Just-In-Time (JIT) compiler runs as a high-priority SCHED_OTHER thread, running above the priority of standard Java threads, but running below the priority of real-time threads
    - Ahead-of-Time (AOT) compilation allows you to compile Java classes and methods before you run your code
      precompile your code into a shared class cache using the AOT compiler