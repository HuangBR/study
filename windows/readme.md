# reference
    Windows NT File System Internals : OSR Classic Reprints
    Troubleshooting with the Windows Sysinternals Tools          
    https://msdn.microsoft.com/en-us/windows/hardware/drivers/gettingstarted/index
    https://msdn.microsoft.com/en-us/windows/hardware/drivers/network/roadmap-for-developing-ndis-protocol-drivers

# windows tools:
  - package
    - sysinternals
    - windows resource kits
    - unxutil
    - SUA 
    - cygwin
    - mingwin
    - support tools
    - sdk
    - ddk
    - ida
    - Explorer Suite CFF
    - resource hacker
    - winhex / hex workshop
    - everything
    - listrary
    - IObit unlocker
    - firefox / chrome

  - others
    - API monitor
    - astah community
    - utralISO
    - 7-zip
    - office
    - foxreader
    - jisupdf
  
  * appwiz.cpl
  * inetcpl.cpl
  * resmon
  * perfmon
  * taskmgr
  * control.exe system
  * evenvwr.exe
  * msra.exe    remote assistant
  * rstrui.exe
  * winver.exe
  * msinfo32
  * UserAccoutControlSettings
  * wscui.exe       windows action center
  * control.exe /name Microsoft.Troubleshooting
  * compmgmt.msc services.msc diskmgmt.msc devmgmt.msc evenvwr.exe
      gpedit.msc
  * schdtasks.exe
    ```
    schtasks /run /tn “TASKNAMEINQUOTES”
    C:\WINDOWS\SchedLgU.txt

    schtasks.exe /query /tn "start-up"
    schtasks.exe /change /TN "start-up" /enable

    schtasks /create -ru 
    ```
  * optionalfeatures.exe

  * secedit /analyze 

  *  network tools
      ```
      ncpa.cpl
      arp
      hostname
      ipconfig
      nbtstat
      netsh
      netstat
      nslookup
      ping
      route
      tracert
      pathping

      arp -d *

      ipconfig /flushdns
      ipconfig /registerdns
      nbtstat -R 
      nbtstat -RR

      ipconfig /all
      netsh interface ip show config
      netsh -r remoteip interface ip show config 
      netsh interface ip show dns
      ipconfig /displaydns

      dhcp:
          ipconfig /release
          ipconfig /renew 
          ipconfig /showclassid
          ipconfig /setclassid
      ```
  
  * winmgmt.exe

  * [winrs](https://msdn.microsoft.com/en-us/library/dd163506.aspx)
    ```https://support.microsoft.com/en-us/help/555966
    winrm quickconfig 

    winrs -r:SEA-SC2 cscript %WINDIR%\system32\scregedit.wsf /ar 0
    ```
    

  * wmic:
    ```
    SERVICE WHERE CAPTION='TELNET' CALL STARTSERVICE

    ENVIRONMENT CREATE NAME="TEMP"; VARIABLEVALUE="NEW"

    PROCESS WHERE NAME="CALC.EXE" DELETE

    process get name,processid, executablepath
    
    product   --list all installed software

    wmic process get commandline | grep java

    WMIC /OUTPUT:C:\Process.txt path win32_process get Caption,Processid,Commandline

    wmic:root\cli>context
    NAMESPACE             : root\cimv2
    ROLE                  : root\cli
    NODE(S)               : DOBLY-PC
    IMPLEVEL              : IMPERSONATE
    [AUTHORITY            : N/A]
    AUTHLEVEL             : PKTPRIVACY
    LOCALE                : ms_409
    PRIVILEGES            : ENABLE
    TRACE                 : OFF
    RECORD                : N/A
    INTERACTIVE           : ON
    FAILFAST              : OFF
    OUTPUT                : STDOUT
    APPEND                : STDOUT
    USER                  : N/A
    AGGREGATE             : ON
    ```

  * slmgr : software licensing service
      /dli
      /dlv
      /xpr

  * check exe is 32-bits or 64-bits
    * check executable file header: 0x14C for x86 or 0x8664 for x64
      ```
      dumpbin /HEaders stdcall_x64.exe | grep machine
            14C machine (x86)
                  32 bit word machine
      ```
  
  * wf.msc # windows firewall
    firewall.cpl
    ```ps
    get-command -module netsecurity

    Get-NetFirewallApplicationFilter

    Get-NetFirewallRule -Name "*ssdp*" | Set-NetFirewallRule -Action Block
    ```
  
  * main.cpl
    desk.cpl
    sysdm.cpl

  * net
    ```
    net share admin$ /users:3
    net share
    net use

    net user administrator /active:yes
    net user administrator <passwd>
    net user administrator /active:no
    ```
    net use can't resolve a computer name but can use its ip address
    System error 53 has occurred.
    The network path was not found.

    - ping win7x64_test # can get return message 
    - nbtstat -a win7x64_test # can resolve the name
    - sc \\win7x64_test\ qeury # can resolve the name
    - set netbios over tcp/ip

    * net use *  \\127.0.0.1
      System error 67 has occurred.

      The network name cannot be found.

    * wireshark
      ```
      net use \\DOLPHIN7-PC\admin$

      # filter
      ip.host==192.168.2.146
      3	4.858162	192.168.2.1	54313	224.0.0.252	5355	71	LLMNR	Standard query 0x5e06 A dolphin7-pc
      212	1237.304663	192.168.2.146	137	192.168.2.255	137	92	NBNS	Name query NB DOLPHIN7-PC<1c>
      192.168.2.1	65059	192.168.2.146	80	74	TCP	65059 → 80 [SYN] Seq=0 Win=8192 Len=0 MSS=1460 WS=256 SACK_PERM=1 TSval=3209213 TSecr=0

      net use port 80(WebDav) after get ip addr instead of 445(NetBIOS over tcp)
      ```

    * solution
      - Open Network Connections
        ```
        ncpa.cpl
        ```
      - ensure you network adapter properties had "Client for Microsotf Network" installed

      - Advanced menu ->  Advanced settings... ->   Provider Order tab
        Ensure Microsoft Windows Network is higher than Web Client Network

      - disable network adapter and eable it agian (reboot is perferred)
        ```
        net use \\dolphin7-pc\IPC$
        The password or user name is invalid for \\dolphin7-pc\IPC$.

        Enter the user name for 'dolphin7-pc': administrator
        Enter the password for dolphin7-pc:
        The command completed successfully.
        ```

    - net share registry
      ```
      regjump HKEY_CURRENT_USER\Network
      reg query HKEY_CURRENT_USER\Network /s
      ```

  * netsh
    ```
    netsh firewall set opmode disable

    netsh advfirewall firewall add rule name="Allow port range" dir=out protocol=udp localport=5000-5020 action=allow
    netsh advfirewall firewall Set rule name="Allow port range" new description="test" action=block
    netsh advfirewall firewall show rule name="allow port range"
    netsh advfirewall firewall del rule name="allow port range"
    ```

  * sc
    ```
    https://forum.sysinternals.com/topic15919.html
    http://stackoverflow.com/questions/828432/psexec-access-denied-errors/14103682#14103682
    windows xp sp3
    sc query type= all state= inactive | findstr /I "remote"
    sc config remoteaccess start= auto
    [SC] ChangeServiceConfig SUCCESS

    sc start remoteaccess
    SERVICE_NAME: remoteaccess
      TYPE               : 20  WIN32_SHARE_PROCESS
      STATE              : 2  START_PENDING
                              (NOT_STOPPABLE,NOT_PAUSABLE,IGNORES_SHUTDOWN)
      WIN32_EXIT_CODE    : 0  (0x0)
      SERVICE_EXIT_CODE  : 0  (0x0)
      CHECKPOINT         : 0x0
      WAIT_HINT          : 0x7d0
      PID                : 1420
      FLAGS              :

    sc query lanmanworkstation
    SERVICE_NAME: lanmanworkstation
      TYPE               : 20  WIN32_SHARE_PROCESS
      STATE              : 4  RUNNING
                              (STOPPABLE,PAUSABLE,ACCEPTS_SHUTDOWN)
      WIN32_EXIT_CODE    : 0  (0x0)
      SERVICE_EXIT_CODE  : 0  (0x0)
      CHECKPOINT         : 0x0
      WAIT_HINT          : 0x0

    sc query lanmanserver
    SERVICE_NAME: lanmanserver
      TYPE               : 20  WIN32_SHARE_PROCESS
      STATE              : 4  RUNNING
                              (STOPPABLE,PAUSABLE,ACCEPTS_SHUTDOWN)
      WIN32_EXIT_CODE    : 0  (0x0)
      SERVICE_EXIT_CODE  : 0  (0x0)
      CHECKPOINT         : 0x0
      WAIT_HINT          : 0x0

    sc query sharedaccess

    cmdkey /add:192.168.2.128 /user:dolphin /pass:
    Enter the password for 'dolphin' to connect to '192.168.2.128':

    cmdky /list

    secpol.msc security-setting -> local policies -> security options -> "network access: sharing and security mode for local account"
      set it to "classical local user loggin as themselves"

    net use \\192.168.2.128\admin$ /user:dolphin-xp-sp3\dolphin
    ```

  * doskey
    ```
    doskey /histroy 
    where ls
    C:\Windows\SUA\common\ls.exe
    doskey /overstrike ll=C:\Windows\SUA\common\ls -l
    ll 
  
  * vs code
    ```
    Ctrl+D

    Ctrl+Shift+L  mutil to one line 

    Ctrl+Shift+P show command
    ```
  
  * control panel tools
    ```
      Control panel tool             Command
    -----------------------------------------------------------------
    Accessibility Options          control access.cpl
    Add New Hardware               control sysdm.cpl add new hardware
    Add/Remove Programs            control appwiz.cpl
    Date/Time Properties           control timedate.cpl
    Display Properties             control desk.cpl
    FindFast                       control findfast.cpl
    Fonts Folder                   control fonts
    Internet Properties            control inetcpl.cpl
    Joystick Properties            control joy.cpl
    Keyboard Properties            control main.cpl keyboard
    Microsoft Exchange             control mlcfg32.cpl
        (or Windows Messaging)
    Microsoft Mail Post Office     control wgpocpl.cpl
    Modem Properties               control modem.cpl
    Mouse Properties               control main.cpl
    Multimedia Properties          control mmsys.cpl
    Network Properties             control netcpl.cpl      
                                    NOTE: In Windows NT 4.0, Network
                                    properties is Ncpa.cpl # network control panel applet
    Password Properties            control password.cpl
    PC Card                        control main.cpl pc card (PCMCIA)
    Power Management (Windows 95)  control main.cpl power
    Power Management (Windows 98)  control powercfg.cpl
    Printers Folder                control printers
    Regional Settings              control intl.cpl
    Scanners and Cameras           control sticpl.cpl
    Sound Properties               control mmsys.cpl sounds
    System Properties              control sysdm.cpl

    file share     fsmgmt.msc
    ```

  * download using command
    - Powershell:
      1. Invoke-WebRequest:iwr, wget, curl
        ```
        wget -Uri http://www.winhelponline.com/blog/wp-content/uploads/reg/copypath.reg -OutFile copypath.reg
        ```
      2. Start-BitsTransfer:
        ```
        Start-BitsTransfer -Source http://www.winhelponline.com/blog/wp-content/uploads/reg/copypath.reg
        ```

    - cmd:
      1. bitsadmin.exe
      ```
      bitsadmin.exe /transfer regdownload /download /priority high ^
        http://www.winhelponline.com/blog/wp-content/uploads/reg/copypath.reg C:\Users\Dobly\Downloads\cmd_download\bits_copypath.reg
      ```

  - windows update
    ```
    wuauclt.exe /deletenow /updatenow

    wusa.exe /uninstall /kb:123456 /quiet /norestart
    wusa.exe Windows6.1-KB123456-x86.msu /quiet /norestart


    powershell
    Install-Module PSWindowsUpdate
    Get-WindowsUpdate
    Install-WindowsUpdate
    ```
  
  - powershell
    - execution policy and scope
      - [Set-ExecutionPolicy](https://technet.microsoft.com/library/hh847748.aspx)
        - Restricted: No Script either local, remote or downloaded can be executed on the system.
        - AllSigned: All script that are ran require to be digitally signed.
        - RemoteSigned: All remote scripts (UNC) or downloaded need to be signed.
        - Unrestricted: No signature for any type of script is required.
      
      - [scope](https://www.darkoperator.com/blog/2013/3/5/powershell-basics-execution-policy-part-1.html)
        - MachinePolicy: The execution policy set by a Group Policy for all users.
        - UserPolicy: The execution policy set by a Group Policy for the current user.
        - Process: The execution policy that is set for the current Windows PowerShell process.
        - CurrentUser: The execution policy that is set for the current user.
        - LocalMachine: The execution policy that is set for all users.

      - usage
        ```
        Get-ExecutionPolicy -List | ft -AutoSize 

        Set-ExecutionPolicy Restricted -Force 

        if (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) { Start-Process powershell.exe "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs; exit }

        ```
    
    - package management
      ```
      @powershell -NoProfile -ExecutionPolicy Bypass -Command "iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))" && SET "PATH=%PATH%;%ALLUSERSPROFILE%\chocolatey\bin"

      choco upgrade chocolatey
      ```

    - version
      ```
      get-host

      $PSversionTable
      ```

    - windows update
      ```
      control.exe /name Microsoft.WindowsUpdate

      Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
      Install-Module PSWindowsUpdate
      import-module PSWindowsUpdate

      Get-wulist
      Install-windowsupdate
      ```

    - diskinfo
      ```ps
      $disk = ([wmi]"\root\cimv2:Win32_logicalDisk.DeviceID='c:'")
      "C: has {0:#.0} GB free of {1:#.0} GB Total" -f ($disk.FreeSpace/1GB),($disk.Size/1GB)
      ```

    - registry
      ```
      Get-Item -Path "Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows Search"
      ```

    - [ACL](https://ss64.com/ps/set-acl.html)(https://msdn.microsoft.com/en-us/library/system.security.accesscontrol.filesystemaccessrule%28v=vs.110%29.aspx)
      ```
      $acl = Get-Acl -Path "d:\github"
      $perm = $env:USERNAME, 'Read,Modify', 'ContainerInherit, ObjectInherit', 'None', 'Allow'
      $rule = New-Object -TypeName System.Security.AccessControl.FileSystemAccessRule -ArgumentList $perm
      $acl.SetAccessRule($rule) 
      Set-Acl -Path "d:\github" -AclObjec $acl
      ```

    - pipe usage
      ```
      Get-Process -Name zeal | ForEach-Object  {Get-NetTCPConnection -OwningProcess $_.Id}
      ```

  * [Event Tracing for Windows (ETW)](https://msdn.microsoft.com/en-us/magazine/ee412263.aspx)
    ```
    xperf.exe
    C:\etl> xperf -help start
    C:\etl> xperf -help stop

    xperf -on LATENCY+FOOTPRINT+VIRT_ALLOC+MEMINFO+VAMAP+REFSET+MEMINFO_WS+ALL_FAULTS -stackwalk VirtualAlloc+VirtualFree+PROFILE+HardFault+PagefaultTransition+PagefaultDemandZero+PagefaultCopyOnWrite+PagefaultGuard+PagefaultHard+PagefaultAV -buffersize 2048 -MaxFile 2048 -FileMode Circular && timeout -1 && xperf -d C:\MemoryUsage.etl
    ```

    - logman

    - tracerpt(trace report)

  * systrace
    - logger.exe
    - wt(trace and watch data) in windbg

  * assoc and ftype
    ```
    C:\>assoc .pcap
    .pcap=wireshark-capture-file

    C:\>ftype wireshark-capture-file
    wireshark-capture-file="C:\Program Files\Wireshark\Wireshark.exe" "%1"

    C:\>assoc .dump
    File association not found for extension .dump

    C:\>assoc .dump=wireshark-capture-file
    .dump=wireshark-capture-file

    Type:
      ASSOC .pl=PerlScript FTYPE PerlScript=perl.exe %1 %* 

    To invoke the Perl script, type:
      script.pl 1 2 3 

    To eliminate the need to type the extensions, type:
      set PATHEXT=.pl;%PATHEXT% 
    ```

  - packege
    ```
    pkgmgr
    ```
    - msiexec
      ```
      msiexec /a D:\test\windows\msi\help3_vs_net.msi TARGETDIR=D:\test\windows\msi\out\

      msiexec /a D:\test\windows\msi\help3_vs_net.msi VS_SETUP=1 /log install.log
      ```
  - cmd 
    ```
    setx - Set environment variables permanently, SETX can be used to set Environment Variables for the machine (HKLM) or currently logged on user (HKCU).
    setx /M PATH "%PATH%;<your-new-path>"
    subst - Substitute a drive letter for a network or local path.

    pathman

    # return a value
    exit /B 1
    ```

  - cacls
    ```
    cacls c:\windows /G guest:RW
    icacls
    findstr /m /l tag *.sys 
    ```

  - fliter driver unload
    ```
    fltmc.exe unload device
    ```

  - query
    ```
    query session
    net session
    query user
    ```

  - fsutil
    ```
    fsutil handlink list read.txt
    ```

  - vss(Volume Shadow Copy Service)[https://technet.microsoft.com/en-us/library/ee923636.aspx]
    ```https://technet.microsoft.com/en-us/library/cc754968.aspx
    vssadmin list shadows
    vssadmin list shadowstorage
    vssadmin list volumes
    vssadmin list writers

    vssadmin create shadow /for=c:

    vssadmin delete Shadows /shadow={xxx}

    gwmi Win32_ShadowCopy | select -Property DeviceObject
    ```

  - mklink
    - A junction (also called a soft link) 
      - differs from a hard link in that the storage objects it references are separate directories
      - a junction can link directories located on different local volumes on the same computer. 
      - junctions operate identically to hard links. Junctions are implemented through reparse points.
    ```
    mklink /J c:\dir d:\dir
    mklink /H file.txt f.txt

    fsutil hardlink list <file>
    dir /al /s 

    dir 'd:\Temp' -recurse -force | ?{$_.LinkType} | select FullName,LinkType,Target

    fsutil reparsepoint query b\b.txt
    ```

  - attrib
    ```
    R = READONLY
    H = HIDDEN
    S = SYSTEM
    A = ARCHIVE 
    C = COMPRESSED
    N = NOT INDEXED
    L = Reparse Points
    O = OFFLINE
    P = Sparse File
    I = Not content indexed
    T = TEMPORARY
    E = ENCRYPTED
    ```

  - robocopy
    ```
    robocopy C:\Users\Dobly\AppData\Local\Temp\{0A95B1D1-A2A2-4F5A-82ED-7D6DC301A5A3} d:\test\ WebToolsAzureVS14.R
    ```

  - [rundll32.exe](https://support.microsoft.com/en-us/help/164787/info-windows-rundll-and-rundll32-interface)
    ```
    RUNDLL.EXE <dllname>,<entrypoint> <optional arguments>
     
    cl testdll.c /MDd /c
    link /dll testdll.obj  user32.lib
    rundll32.exe testdll.dll,dllmain
    ```
    Rundll performs the following steps:
      - parses the command line.
      - loads the specified DLL via LoadLibrary().
      - obtains the address of the <entrypoint> function via GetProcAddress().
      - calls the <entrypoint> function, passing the command line tail which is the <optional arguments>.
      - When the <entrypoint> function returns, Rundll.exe unloads the DLL and exits.

  - regsvr32.exe
    ```
    regsvr32.exe /u /n /s /i:http://xxx:80/file.sct scrobj.dll
    ```

  - reg
    ```
    reg query "HKEY_CURRENT_USER\Software\Classes\Local Settings\Software\Microsoft\Windows\CurrentVersion\AppModel\Repository\Packages\Microsoft.MicrosoftEdge_40.15063.0.0_neutral__8wekyb3d8bbwe\MicrosoftEdge\Capabilities\FileAssociations" /s

    .htm    REG_SZ    AppX4hxtad77fbk3jkkeerkrm0ze94wjf3s9
    .html    REG_SZ    AppX4hxtad77fbk3jkkeerkrm0ze94wjf3s9
    .pdf    REG_SZ    AppXd4nrz8ff68srnhf9t5a8sbjyar1cr723
    .svg    REG_SZ    AppXde74bfzw9j31bzhcvsrxsyjnhhbq66cs
    .xml    REG_SZ    AppXcc58vyzkbjbs4ky0mxrmxf8278rk9b3t
    .epub    REG_SZ    AppXvepbp3z66accmsd0x877zbbxjctkpr6t

    reg query HKEY_CURRENT_USER\SOFTWARE\Classes\AppXd4nrz8ff68srnhf9t5a8sbjyar1cr723 /s

    reg add HKEY_CURRENT_USER\SOFTWARE\Classes\AppXd4nrz8ff68srnhf9t5a8sbjyar1cr723 /v NoOpenWith /t REG_SZ /v ""

    reg add HKEY_CURRENT_USER\SOFTWARE\Classes\AppXd4nrz8ff68srnhf9t5a8sbjyar1cr723 /v NoOpenWith /t REG_SZ

    reg query HKEY_CURRENT_USER\SOFTWARE\Classes\AppXd4nrz8ff68srnhf9t5a8sbjyar1cr723
      HKEY_CURRENT_USER\SOFTWARE\Classes\AppXd4nrz8ff68srnhf9t5a8sbjyar1cr723
      NoOpenWith    REG_SZ
    ```

  - SubInAcl.exe
    ```
    subinacl.exe /verbose /file acctinfo.dll /display
    ```

  - timeout
    ```
    timeout /t 10
    ```

# sysinternals
  * use
    ```
    \\live.sysinternals.com\tools\sigcheck.exe -m c:\Windows\notepad.exe
    net use Y: \\live.sysinternals.com\tools\
    ```
  * get open files 
    - handle -u Administrator
    - handle -p cmd
    - close
      ```
      handle hookssdt.pdb

      windbg.exe         pid: 4820   type: File           180: C:\Users\Dobly\Documents\Visual Studio 2013\Projects\HookSSDT\Win7Debug\HookSSDT.pdb

      handle -c 180 -y -p 4820
      ```

  * [handle](https://forum.sysinternals.com/howto-enumerate-handles_topic18892.html)
    ```
    handle -p cmd
    ```

  * procexp
    - run as administrator
      ```bat
      "C:\Program Files\SysInternals\procexp.exe" /e /t
      ```

    - registry
      ```
      Windows Registry Editor Version 5.00

      [HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\taskmgr.exe]
      "Debugger"="\"C:\\PROGRAM FILES\\SYSINTERNALS\\PROCEXP.EXE\" /e"
      ``

  - regjump
    ```
    regjump HKLM\SOFTWARE\MICROSOFT\WINDOWS NT\CURRENTVERSION\DIGITALPRODUCTID
    reg query "HKLM\SOFTWARE\MICROSOFT\WINDOWS NT\CURRENTVERSION" /v DIGITALPRODUCTID
    ```

  - sysmon
    - config.xml
      ```xml
      <?xml version="1.0"?>
      <Sysmon schemaversion="3.20">
      <EventFiltering>
          <!-- <HashAlgorithms>*</HashAlgorithms> -->
      <NetworkConnect onmatch="include">
          <Image condition="contains">chrome.exe</Image>
          <Image condition="contains">iexplore.exe</Image>
          <Image condition="contains">firefox.exe</Image>
          <Image condition="contains">MicrosoftEdgeCP.exe</Image>
          <Image condition="contains">MicrosoftEdge.exe</Image>
          <Image condition="contains">explorer.exe</Image>
          <DestinationPort condition="is">80</DestinationPort>
          <DestinationPort condition="is">443</DestinationPort>
          <DestinationPort condition="is">8080</DestinationPort>
      </NetworkConnect>

      <ProcessCreate onmatch="include">
          <Image condition="contains">procexp.exe</Image>
      </ProcessCreate>
      <ProcessTerminate onmatch="exclude">
      </ProcessTerminate>

      </EventFiltering>
      </Sysmon>
      ```

    - Management 
      ```shell 
      # install
      sysmon -i -accepteula config.xml
      # update
      sysmon -c config.xml
      # uninstall
      sysmon -u
      ```

    - query event log
      ```bat
      wevtutil qe Microsoft-Windows-Sysmon/Operational /f:text
      eventvwr.msc
      ```

  - sigcheck
    - extract manifest info
    ```
    \\live.sysinternals.com\tools\sigcheck.exe -m notepad.exe
    
    # manifest tool
    mt.exe /?
    ```

    - [authentication of signature](http://www.exploit-monday.com/2017/08/application-of-authenticode-signatures.html)
      ```
      C:\WinDDK\7600.16385.1\bin\amd64\signtool.exe /a /v  'C:\Windows\System32\kernel32.dll' 

      Get-AuthenticodeSignature -FilePath 'C:\Windows\System32\kernel32.dll'

      http://www.harmj0y.net/blog/redteaming/pass-the-hash-is-dead-long-live-localaccounttokenfilterpolicy/ 
      ```


# common useful gui 
  - godmod
    ```
    mkdir .{ED7BA470-8E54-465E-825C-99712043E01C}
    rmdir ".{ED7BA470-8E54-465E-825C-99712043E01C}"
    ```

* [hook](https://en.wikipedia.org/wiki/Hooking)
     hooking covers a range of techniques used to alter or augment the behavior of an operating system, 
     of applications, or of other software components by intercepting function calls or messages or events passed between
      software components. Code that handles such intercepted function calls, events or messages is called a "hook".

      ILT: import lookup table
      IAT: import address table

* assembly
  1. windbg
    * [set windbg as postmortem debugger](https://msdn.microsoft.com/en-us/library/windows/hardware/ff542967(v=vs.85).aspx)
      ```
      C:\Program Files (x86)\Windows Kits\8.1\Debuggers\x64\windbg.exe –I
      C:\Program Files (x86)\Windows Kits\8.1\Debuggers\x86\windbg.exe –I

      HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\AeDebug
      Debugger = "C:\Program Files (x86)\Windows Kits\8.1\Debuggers\x64\windbg.exe" -p %ld -e %ld -c ".dump /j %p /u d:\debug\AeDebug.dmp; qd" 
      Auto = 1

      HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\Microsoft\Windows NT\CurrentVersion\AeDebug
      Debugger = "C:\Program Files (x86)\Windows Kits\8.1\Debuggers\x86\windbg.exe" -p %ld -e %ld –g -c ".jdinfo 0x%p"

      Debugger = "C:\Windows\system32\vsjitdebugger.exe" -p %ld -e %ld
      ```

    * dependency walker
      1. executables are just sequences of bytes
      2. symbols help debugger to:
          * map raw address to source code
          * analyze internal layout and size of app
      3. pdb -> program database
          * newest debug info format coff and codeview are deprecated
          * pdbs are stored separately from executables
          * pdb format undocumented
          * special apis work with it: dbghelp.dll MsDiaxy.dll
      
    * [fpo](https://msdn.microsoft.com/en-us/library/2kxx5t2c.aspx)

      cl /Oy(-) enable/disable frame pointer ommition, can free one register called EBP
        The /Ox (Full Optimization) and /O1, /O2 (Minimize Size, Maximize Speed) options imply /Oy. 
        Specifying /Oy– after the /Ox, /O1, or /O2 option disables /Oy, whether it is explicit or implied.
      
    * debug info
      1. linker:/pdbstripped:
          * Public functions and variables
          * FPO information
      2. Private functions and variables
      3. Source file and line information
      4. Type information
      
    * options for debug 
      * Compiler options: /Z7, /Zi, /ZI
      * Linker options: /debug, /pdb, /pdbstripped
  
    * match debug info
      * signature in executables and pdb files during building:
        1. timestamp (pdb v2.0)
        2. guid (pdb v7.0) 
      * debugger match the signature and they must be same
      * algorithm to search pdb files:
          1. try module path
          2. try name and path specified in PE header 
              ( NB10 or rsds debug header)
          3. set _NT_SYMBOLS_PATH or _NT_ALT_SYMBOLS_PATH environment variables
  
  * attach mode
    1. invasive
    2. noninvasive is usefull if:
      * app is debugging by vs, can still use windbg for debugging
      * the target application is completely frozen and 
          can't lauch the break-in thread neccessary for a true attach
  
  * dbg command
    * .dbgdbg
      ```
      ctrl+alt + v # verbose
      .dbgdbg   # debug windbg
      ```
      
    * regular cmd used to __debug process__
      ```
      k lm g
      ```

    * mata or dot-commands __control the behavior of debugger__
      ```
      .sympath  .cls  .lastevent  .detach  .if
      ```
  
    * extention cmd 
      - implemented as export functions in extension dlls
      - large part of what makes windbg such a powerfull debugger
      - lots of preinstalled dlls: exts.dll, ntsdexts.dll, uext.dll,wow64exts.dll, kdexts.dll, ..
      - can write our own extension dll
      - !analyze !address !handle, !ped 
  
    * _NT_SOURCE_PATH environment variable
      ```
      .srcpath
      .srcpath+ xy
      .srcpath+ c:\symblos\
      ```

    * processed and thread on nt
      * each process is represented by executive process block(EPROCESS) in kernel-mode in system address space
      * each process has one or more thread represented by executables thread block(ETHREAD) in kernel-mode in system address space
      * EPROCESS points to related structs such as ETHREAD
      * EPROCESS points to PEB(process environment block) in process address space
      * ETHREAD points to TEB(thread environment block) in process address space

      * PEB = Process Environment Block
        - basic image information (base address, version numbers, module list)
        - process heap information
        - environment variables
        - command-line parameter
        - DLL search path
        - Display it: !peb, dt nt!_PEB
      * TEB = Thread Environment block
        - stack information (stack-base and stack-limit)
        - TLS (Thread Local Storage) array
        - Display it: !teb, dt nt!_TEB
  
  * common usage
    - module and sysmbols
      ```
      .reload /f
      .reload /f /s ntdll

      # ignore mismatch
      .reload /f /s /i ntdll  

      # force reload a module with pdb file
      ld ntdll /f ntdll.pdb

      .reload /u hal
      ```
    - remote debugging through tcp
      - server:
        ```
        .server tcp:port=5555

        dbgsvc -t tcp:port=5555
        ```
      
      - client:
        ```
        windbg -remote tcp:port=5555,server=192.168.1.1
        ```

  * breakpoints 
    - Viewing Set Breakpoints
      ```
      To view each of the breakpoints that have been set, you can use the bl (Breakpoint List) command.

      0:000> bl
      0 e 00523689 e 1 0001 (0001)  0:**** notepad!WinMainCRTStartup

      Here we have one breakpoint defined, the entry is broken into a few columns:

          0 - Breakpoint ID
          e - Breakpoint Status - Can be enabled or disabled.
          00523689 - Memory Address
          e 1 - Memory address access flags (execute) and size - For hardware breakpoints only
          0001 (0001) - Number of times the breakpoint is hit until it becomes active with the total passes in parentheses (this is for a special use case)
          0:**** - Thread and process information, this defines it is not a thread-specific breakpoint
          notepad!WinMainCRTStartup - The corresponding module and function offset associated with the memory address
      ```

    - break on access

      – bl – List existing breakpoints. Each breakpoint listed has a number in the list.
      – bc * : Clear all breakpoints.
      – bc number : Clear breakpoint identified by number.
      – be number : Enable breakpoint identified by number.
      – bd number : Disable breakpoint identified by number.
      – bp `module!source.c:20` : Set breakpoint at source.c line 20 in module.
      – bm module!pattern* : Set a breakpoint on symbols starting with pattern in module.
      – bu module!function : Set a breakpoint on function as soon as module is loaded.
      – ba r4 variable : Set a breakpoint for read access on 4 bytes of variable.
      – ba w4 address : Set a breakpoint for write access on 4 bytes at address.
      – bp @@(class::method) : Break on method defined in class. Useful if the same method is overloaded and thus present on several addresses.
      – bp module!function /1 : Trigger only once a breakpoint at function in module.
      – bp module!function k : Hit breakpoint at function in module after k-1 passes.
      – ba w4 address “k;g” : Display call stack every write access on 4 bytes at address.
      – bu module!function “.dump C:\Dump.dmp; g” : Create a dump in C:\Dump.dmp every time breakpoint at function in module is hit.
      – bp /t thread : Set a kernel mode breakpoint that only triggers when hit in the context of the associated thread.
      – bp /p process : Set a kernel mode breakpoint that only triggers when hit in the context of the associated process.
      - .logopen FilePath; .bpcmds; .logclose : Save breakpoints to FilePath.
      – $<FilePath : Reload breakpoints from FilePath.

      ```
      ba e 1 0x7c234ef

      be 
      bd
      bc
      ```

  * excpetions: sx
    - [control excepion or event](https://msdn.microsoft.com/en-us/library/windows/hardware/ff539287(v=vs.85).aspx)
      - Using the Debugger to Analyze an Exception
        ```
        gh (Go with Exception Handled)
        gn (Go with Exception Not Handled) 
        ```

    - breaking on module load
      ```
      sxe ld IMM32.dll
      ```
    - ignore exceptions enabled
      ```
      sxi ld IMM32.dll
      ```

    - Display Exception Record
      ```
      .exr -1
      ```

  *  trace and stepping
    - go
      – g : Start executing the given process or thread.
      – g `:number`; ? poi(variable); g : Executes the current program to source line number, print the value of variable then resume execution.
      – gc : Resume execution from a conditional breakpoint.
      – gu : Execute until the current function is complete.
      – gh : Go with Exception Handled.
      – gn : Go with Exception Not Handled.

    - step into
      ```
      tc
      tt
      tr
      ```
    - step over
      – pr : Toggle displaying of registers.
      – p count “kb” : Step through count source lines then execute “kb”.
      – pc : Step to next CALL instruction.
      – pt – Steps through until the next return instruction.
      – pa address : Step until address is reached.

    - step out
      ```
      gu # go util functions return
      ```

  * Call stack
    – k : Display call stack.
    – kn : Display call stack with frame numbers.
    – kb : Display call stack with first three parameters passed to each function.
    – kb FrameCount : Display first FrameCount frames only.
    – kp : Display all of the parameters for each function that is called in the stack trace.
    – kn : Display frame numbers.

    – !findstack symbol 2 : Display all stacks that contain symbol.

    – .frame : Show current frame.
    – .frame FrameNumber : Set frame FrameNumber for the local context.
    – .frame /r FrameNumber : Display registers in frame FrameNumber.

    – !running -ti : Dump the stacks of each thread that is running on all processors.
    – !stacks : Give a brief summary of the state of every thread.

  * Heap
    – dt ntdll!_HEAP : Dump _HEAP structure.
    – !heap : List all heaps with index and Heap address.
    – !heap -h : List all of the current process heap with start and end addresses.
    – !heap -h HeapIndex : Display detailed heap information for heap with index HeapIndex.
    – !heap -s 0 : Display summary for all heaps including reserved and committed memory …
    – !heap -flt s 0x50 : Display all of the allocations of size 0x50.
    – !heap -stat -h address : Display heap usage statistics for HeapHandle is equal to address.
    – !heap -b alloc tag HeapIndex : Breakpoint in heap with index HeapIndex on HeapAlloc calls with TAG equal to tag.
    – !heap -p -all : Display details of all allocations in all heaps in the process.
    – !heap -l : Make the debugger detect leaked heap blocks.

  * registers
    – rm ? : Show possible Mask bits.
    – rm 1 : Enable integer registers only.
    – r : Display the integer registers.
    – r eax, edx : Display only eax and edx.
    – r eax=5, edx=6 : Assign new values to eax and edx.
    – r eax:1ub : Display only the first byte from eax.
    – rF : Display the floating-point register.

  * variables 
    – dv /t /i /V : Dump local variables with type information, addresses and EBP offsets and classify them into categories.
    – dt module!pattern* -v -s Length : List with verbose output all variables that begin with pattern in module that have Length bytes size.

    – dt ntdll!_PEB : Dump _PEB structure.
    – dt module!struct : Show fields of the structure struct defined in module with their offsets and types.
    – dt module!struct -rCount : Dump fields of the structure struct defined in module recursively for Count levels.

    – dt module!struct var. : Dump var defined in strcut in module and expand its subfields.
    – dt module!struct var.. : Expand subfields of var defined in strcut in module for 2 levels.

  * memory
    – dd address : Display double-words at address.
    – dd address LLength: Display Length double-words at address.
    – du address : Display unicode chars at address.
    – du address LLength : Display Length unicode chars at address.
    – !mapped_file address : Display name of file that contains address.
    – !address : Show all memory regions of our process.
    – !address address : Retreive inforamation about a region of memory at address.

    – eb address value : Set byte at address to value.
    – ew address value : Set word at address to value.
    – ed address value : Set double-word at address to value.

    – ds /c width address : Display width chars at address.
    – dS /c width address : Display width unicode chars at address.

    – c address1 LLength address2 : Compare Length bytes at address1 with address2.
    – m address1 LLength address2 : Move Length bytes at address1 to address2.
    – f address LLength ‘A’ ‘B’ ‘C’ – Fill memory location from address to address + Length – 1 with the pattern “ABC”, repeated as many times as necessary.

    – s -a address LLength “pattern” : Search memory location from address to address + Length – 1 for pattern.
    – s -wa address LLength “pattern” : Search only writable memory from address to address + Length – 1 for pattern.

    – !poolused : Display memory use summaries, based on the tag used for each pool allocation.
    – !vm : Display summary information about virtual memory use statistics on the target system.

    – u address : Unassemble code at address.

  * Memory dump
    – .dump FileName : Dump small memory image into FileName.
    – .dump /ma FileName : Dump complete memory image into FileName.

  * Locks
    – !locks : Display all kernel mode locks held on resources by threads.
    – !qlocks : Display the state of all queued spin locks.

  * Extension DLLs
    – .load ExtensionDLL : Load the extension DLL ExtensionDLL into the debugger.
    – .unload ExtensionDLL : Unload the extension DLL ExtensionDLL.
    
    – .chain : List all extensions that the debugger has loaded.
    – .unloadall : Unload all extension DLLs from the debugger.
    – .setdll ExtensionDLL : Change the default extension DLL to ExtensionDLL for the debugger

  * Application Verifier
    – !avrf : Display a variety of output produced by Application Verifier. If a Stop has occurred, reveal the its nature and what caused it.
    – !verifier 0xf : Display the status of Driver Verifier and its actions.
    – !verifier 0x80 address : Display log associated with the specified address within the kernel pool Allocate and Free operations.
    – !verifier 0x100 address : Display log associated with the IRP at address.

  * calculator
    ```
    ?bc28 + cdf234e * 2
    ```

  * analyze
    – !analyse -v : Display verbose information about the current exception or bug check.
    – !analyze -show BugCheckCode : Display information about BugCheckCode bug check code.
    - !analyze -v -hang

  * module info
    ```
    lm 
      start    end        module name
      00f50000 00f9e000   create_file C (private pdb symbols)  d:\test\windows\create_file.pdb
      755b0000 755f7000   KERNELBASE   (pdb symbols)          c:\windows\symbols\wkernelbase.pdb\E2ED940FA8B44386BECE7660544D12B31\wkernelbase.pdb
      76460000 76570000   kernel32   (pdb symbols)          c:\windows\symbols\wkernel32.pdb\8637E33E087D453EA4D662D28322AF802\wkernel32.pdb
      779e0000 77b60000   ntdll      (pdb symbols)          c:\windows\symbols\wntdll.pdb\611AE48A538F4C0B82726D75DE80A6A92\wntdll.pdb

    !lmi create_file
      Loaded Module Info: [create_file] 
              Module: create_file
        Base Address: 00f50000
          Image Name: d:\test\windows\create_file.exe
        Machine Type: 332 (I386)
          Time Stamp: 58d37860 Thu Mar 23 00:25:20 2017
                Size: 4e000
            CheckSum: 0
      Characteristics: 102  
      Debug Data Dirs: Type  Size     VA  Pointer
                  CODEVIEW    38, 465b0,   455b0 RSDS - GUID: {DD230232-B8FC-48F9-ABD3-496C2717E650}
                    Age: 1, Pdb: d:\test\windows\create_file.pdb
                        ??    14, 465e8,   455e8 [Data not mapped]
          Image Type: FILE     - Image read successfully from debugger.
                      d:\test\windows\create_file.exe
          Symbol Type: PDB      - Symbols loaded successfully from image path.
                      d:\test\windows\create_file.pdb
            Compiler: C - front end [19.0 bld 24215] - back end [19.0 bld 24215]
          Load Report: private symbols & lines, not source indexed 
                      d:\test\windows\create_file.pdb

    !dh -f create_file  # !dh -stat
          File Type: EXECUTABLE IMAGE
          FILE HEADER VALUES
              14C machine (i386)
                7 number of sections
          58D37860 time date stamp Thu Mar 23 00:25:20 2017

                0 file pointer to symbol table
                0 number of symbols
                E0 size of optional header
              102 characteristics
                      Executable
                      32 bit word machine
            ......
          00f50000 image base
              1000 section alignment
              200 file alignment
                3 subsystem (Windows CUI)
              6.00 operating system version
              0.00 image version
              6.00 subsystem version
            4E000 size of image
              400 size of headers
                0 checksum
    ```

  * debug info
    ```
    # a unofficial undocumented command
    .dumpdebug 

    !ready
    # create dumpfile
    .crash
    [Forcing a System Crash from the Keyboard](https://msdn.microsoft.com/en-us/library/windows/hardware/ff545499(v=vs.85).aspx)
    https://channel9.msdn.com/Shows/Defrag-Tools/DefragTools-137-Debugging-kernel-mode-dumps
    
    PS/2 Keyboard
      HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\i8042prt\Parameters
      DWORD CrashOnCtrlScroll 1

    USB Keyboard
      HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\kbdhid\Parameters
      DWORD CrashOnCtrlScroll 1

     Right Ctrl + Scroll Lock + Scroll Lock will generate a nice looking real blue screen. 
    ```

  * pde(Prototype Debugger Extension)
    ```
    !pde.help
    # grep filter
    !grep exe !peb
    ```

  * debug with src
    ```
    cl set_hotkey.c /debug
    windbg set_hotkey.exe
    lsf set_hotkey.c 
    # set source debug mode
    .lines        enable source line information
    bp main       set initial breakpoint
    l+t           stepping will be done by source line
    l+s           source lines will be displayed at prompt
    g             run program until "main" is entered
    pr            execute one source line, and toggle register display off
    p             execute one source line 
    ```

  - system hang
    ```
    .echocpunum  # enable cpu number show up
    !cpuid
    !cpuinfo
    ~0s     #change to cpu0
    !running it 
    !analyze -v -hang
    !locks
    !qlocks

    .process 0 0 
    .process 0 0 sc.exe

    !devnode 1 # lists all pending removals of device objects.
    !devnode 2 # lists all pending ejects of device objects.

    !devnod 0 1  # show entire device tree

    !drvobj hookssdt 7
    !devstack 
    lmv m HookSSDT

    ```

  * Controlling the User-Mode Debugger from the Kernel Debugger
    - redirect the input and output from a user-mode debugger to a kernel debugger

    - start the debugging session 
      - Start NTSD or CDB on the target computer as the user-mode debugger, with the -d command-line option. 
        ```
        ntsd -d [-y UserSymbolPath] -p PID

        ntsd -d [-y UserSymbolPath] ApplicationName

        If you are installing this as a postmortem debugger, you would use the following syntax.

        ntsd -d [-y UserSymbolPath]
        ```

      - Start WinDbg or KD on the host computer as the kernel debugger
        ```
        windbg [-y KernelSymbolPath] [-k ConnectionOptions]
        ```

      - Switching Modes
        ```                           g
           User-mode debugging    ----------------->  target application execution
                             +      !bpid 
                  |           +                               |
            .wake | .sleep      +   .breakin                  | Ctrl+C
                  |               +----------->               |
                  |                           ++++           \ /
              Sleep mode ---------------------->    kernel-mode debugging
              
        ```

    * logger
      ```
      !logexts.logo e|d d|t|v # eable/disable debug/text/verbose

      !logo e|d d|t|v

      .effmach x86
      ```
      - [mix x86 and x64](https://blogs.msdn.microsoft.com/msdnforum/2010/03/14/how-do-i-switch-to-32bit-mode-when-i-use-windbg-to-debug-a-dump-of-a-32bit-application-running-on-an-x64-machine/)
        ```
        # using 64-bit cdb to debug 32-bit application in x64 system
        "C:\Program Files (x86)\Windows Kits\8.1\Debuggers\x86\cdb.exe"  "C:\Program Files (x86)\Microsoft Visual Studio 12.0\Common7\Tools\errlook.exe"

        .load wow64exts
        .effmatch
        # switch to x86 mode
        !wow64exts.sw      !sw      .effmatch x86
        .effmatch

        .load logexts
        !loge    # .logexts.loge #
        .logexts.logi
        .logo e d
        .logo e t
        .logo e v

        logviewer
        ```
  
  * set remote debug using vmware
    1. [Installation](http://www.microsoft.com/whdc/devtools/debugging/installx86.mspx)

    2. Setting the symbol file path
        ```
        _NT_SYMBOL_PATH=srv*C:\Windows\Symbols*https://msdl.microsoft.com/download/symbols

        # If you want to observe the process of symbol matching, you can enable verbose symbol matching by executing the command
        !sym noisy 

        # Afterwards, you can force windbg to reload the symbols by typing
        .reload /f
        ```
    3. configure environment in vmware
        * windows xp:
        ```
        c:\boot.ini               

        [boot loader]
        timeout=30
        default=multi(0)disk(0)rdisk(0)partition(1)\WINDOWS
        [operating systems]
        multi(0)disk(0)rdisk(0)partition(1)\WINDOWS=”Microsoft Windows XP Professional” /fastdetect
        multi(0)disk(0)rdisk(0)partition(1)\WINDOWS=”Microsoft Windows XP Professional Debug Mode” /fastdetect /debug /debugport=COM2 /baudrate=115200 
        ```
        
        * vista and above:
        ```
        Administrator (using runas) and execute bcdedit. The format of the command is:

        bcdedit /dbgsettings DebugType [debugport:Port] [baudrate:Baud]

        1. serial debugging (using COM1 at 115200bps) it is:

            bcdedit /dbgsettings serial debugport:1 baudrate:115200

        2. 1394 (using channel 32) it is:

            bcdedit /dbgsettings 1394 CHANNEL:32

        3. USB (using “debugging” as the target name) it is:

            bcdedit /dbgsettings USB targetname:debugging

        After that, you need to enable debugging by typing:

            bcdedit /debug on

        In order to disable it later, you can type:

            bcdedit /debug off
        ```

        * create a serial port on vmware workstation:
            
            * The name of the named pipe is \\.\pipe\com_port (you can use whatever you want after \\.\pipe\)
            * The COM port number is 2 (see in the picture where it is mentioned "Serial Port 2" on the left pane)
            * The two dropboxes with this end is the server and the other end is an application.
            * According to the documentation, about "Yield CPU on Poll":
            ```
            This configuration option forces the affected virtual machine to yield processor time if the only task it
              is trying to do is poll the virtual serial port.
            ```

    4. use debugging tools:
        windbg -k com:pipe,port=\\.\pipe\com_port,resets=0,reconnect
        kd -k com:pipe,port=\\.\pipe\com_port,resets=0,reconnect

        * reference:
            http://stackoverflow.com/questions/33820520/kernel-debug-with-a-vmware-machine
            https://blogs.msdn.microsoft.com/iliast/2006/12/11/windbg-tutorials/
  
  * enable local kernel debug 
    - add a new boot entry
      ```
      bcdedit /v
        Windows Boot Loader
        -------------------
        identifier              {b8b48bdb-0c8d-11e6-9f5f-b012a345769a}
        device                  partition=C:
        path                    \Windows\system32\winload.exe
        description             Windows 7 Enterprise
        locale                  en-US
        inherit                 {6efb52bf-1766-41db-a6b3-0ee5eff72bd7}
        recoverysequence        {2acc94f3-0d0c-11e6-a124-936c4ff2683c}
        recoveryenabled         Yes
        osdevice                partition=C:
        systemroot              \Windows
        resumeobject            {b8b48bda-0c8d-11e6-9f5f-b012a345769a}
        nx                      OptIn
        bootlog                 Yes
        sos                     Yes

      bcdedit /copy {b8b48bdb-0c8d-11e6-9f5f-b012a345769a} -d "Windows 7 Enterprise With Debug On"
        The entry was successfully copied to {9ee65318-1029-11e6-bdc5-d24cbb4066ca}.

      bcdedit /v
        Windows Boot Loader
        -------------------
        identifier              {9ee65318-1029-11e6-bdc5-d24cbb4066ca}
        device                  partition=C:
        path                    \Windows\system32\winload.exe
        description             Windows 7 Enterprise With Debug On
        locale                  en-US
        inherit                 {6efb52bf-1766-41db-a6b3-0ee5eff72bd7}
        recoverysequence        {2acc94f3-0d0c-11e6-a124-936c4ff2683c}
        recoveryenabled         Yes
        osdevice                partition=C:
        systemroot              \Windows
        resumeobject            {b8b48bda-0c8d-11e6-9f5f-b012a345769a}
        nx                      OptIn
        bootlog                 Yes
        sos                     Yes
      ```

    - set debug on new boot entry and make it as default boot entry
      ```
      bcdedit /debug  {9ee65318-1029-11e6-bdc5-d24cbb4066ca} on
      # windows 10
      bcdedit /set {9ee65318-1029-11e6-bdc5-d24cbb4066ca} local 
      
      bcdedit /default {9ee65318-1029-11e6-bdc5-d24cbb4066ca}
      bcdedit /timeout 16

      bcdedit /v
      ```

    - [enable boot debug](https://msdn.microsoft.com/en-us/library/windows/hardware/ff542183(v=vs.85).aspx)
        target computer will break into the debugger three times: 
        - Windows Boot Manager loads
        - when the boot loader loads
        - when the operating system starts up. 
        ```
        bcdedit /bootdebug {bootmgr} on 
        bcdedit /bootdebug {9ee65318-1029-11e6-bdc5-d24cbb4066ca} on 
        bcdedit /debug {9ee65318-1029-11e6-bdc5-d24cbb4066ca} on
        ```
    
    - hypervisor configure
      ```
      bcdedit /set hypervisorlaunchtype off

      bcdedit /set hypervisorlaunchtype auto
      ```

    - restart computer
      ```
      shutdown /g
      ```
    
    - start local debugging
      ```
      windgb -kl
      kd -kl      
      ```

    - referrence
      http://www.microsoft.com/whdc/system/platform/firmware/bcd.mspx
      Local Kernel-Mode Debugging - windbg help documentation

  * use windbg debug a process in kernel debug [https://blogs.msdn.microsoft.com/iliast/2008/02/01/debugging-user-mode-processes-using-a-kernel-mode-debugger/]
      * !process 0 0
          ```
          PROCESS 81ddd220  SessionId: 3  Cid: 0724    Peb: 7ffdf000  ParentCid: 0200
              DirBase: 0e013000  ObjectTable: e1272418  HandleCount: 148.
              Image: winlogon.exe

          PROCESS 81ab43a8  SessionId: 0  Cid: 065c    Peb: 7ffdf000  ParentCid: 0258
              DirBase: 0f65a000  ObjectTable: e1ac6750  HandleCount:  88.
              Image: rdpclip.exe

          PROCESS 81b0c370  SessionId: 3  Cid: 06dc    Peb: 7ffdf000  ParentCid: 0724
              DirBase: 1019b000  ObjectTable: e1288098  HandleCount: 136.
              Image: logonui.exe

          PROCESS 81ea9da8  SessionId: 0  Cid: 02c8    Peb: 7ffdf000  ParentCid: 0710
              DirBase: 10cd4000  ObjectTable: e1639768  HandleCount:  21.
              Image: calc.exe
          ```

      * .process /i 81ea9da8  # After you press “g”, you have to wait for the windows scheduler to do the context switch.
          .process /r /p 85709738 #  the debugger does the context switch immediately (as opposed to the windows scheduler) and there is no waiting time.  

      * lm v m calc*
      
      * x calc!gpsz*
        01014db0 calc!gpszNum = <no type information>
      * dd calc!gpszNum l1
        01014db0  00098f38
      * du 98f38 # unicode characters
        00098f38  "58746921."
      * r eip=40103a
      * tr # step in
      * pr # step over
      * pc, pt, pct # step to next call or return
      * q, qd # quit, detach
  
  - BSOD debugging using windbg
    - set windows to enable full memory dump on crash
      ```
      sysdm.cpl
      advanced -> startup and recovery ->  settings 
        automate restart 
        kernel memory dump
        dump file :%SystemRoot%\MEMORY.DMP
      ```

    - set _NT_SYMBOLS_PATH
      ```
      setx /m _NT_SYMBOL_PATH "srv*C:\Windows\Symbols*https://msdl.microsoft.com/download/symbols"
      ```
    
    - open dump file in windbg

    - analyze
      ```
      2: kd> !analyze -v
        *******************************************************************************
        *                                                                             *
        *                        Bugcheck Analysis                                    *
        *                                                                             *
        *******************************************************************************
        
        SYSTEM_THREAD_EXCEPTION_NOT_HANDLED (7e)
        This is a very common bugcheck.  Usually the exception address pinpoints
        the driver/function that caused the problem.  Always note this address
        as well as the link date of the driver/image that contains this address.
        Arguments:
        Arg1: ffffffffc0000005, The exception code that was not handled
        Arg2: fffff880034422bf, The address that the exception occurred at
        Arg3: fffff8801ad237c8, Exception Record Address
        Arg4: fffff8801ad23020, Context Record Address
        
        Debugging Details:
        ------------------
        DUMP_CLASS: 1
        DUMP_QUALIFIER: 401
        BUILD_VERSION_STRING:  7601.23572.amd64fre.win7sp1_ldr.161011-0600
        DUMP_TYPE:  1
        BUGCHECK_P1: ffffffffc0000005
        BUGCHECK_P2: fffff880034422bf
        BUGCHECK_P3: fffff8801ad237c8
        BUGCHECK_P4: fffff8801ad23020
        EXCEPTION_CODE: (NTSTATUS) 0xc0000005 - The instruction at 0x%08lx referenced memory at 0x%08lx. The memory could not be %s.
        FAULTING_IP: 
        nm3!NetmonOidRequestComplete+53
        fffff880`034422bf 894734          mov     dword ptr [rdi+34h],eax
        
        EXCEPTION_RECORD:  fffff8801ad237c8 -- (.exr 0xfffff8801ad237c8)
        ExceptionAddress: fffff880034422bf (nm3!NetmonOidRequestComplete+0x0000000000000053)
          ExceptionCode: c0000005 (Access violation)
          ExceptionFlags: 00000000
        NumberParameters: 2
          Parameter[0]: 0000000000000000
          Parameter[1]: ffffffffffffffff
        Attempt to read from address ffffffffffffffff
        
        CONTEXT:  fffff8801ad23020 -- (.cxr 0xfffff8801ad23020)
        rax=0000000000000000 rbx=fffffa801d577fb0 rcx=0000000073656c74
        rdx=fffffa801d577fb0 rsi=00000000c000000d rdi=7665442820352066
        rip=fffff880034422bf rsp=fffff8801ad23a00 rbp=fffffa8014a1aa10
        r8=00000000c000000d  r9=0000000000000000 r10=fffff88002257fa0
        r11=0000000000000000 r12=fffffa80162411c0 r13=00000000c0000001
        r14=0000000000000000 r15=fffff88001ac9110
        iopl=0         nv up ei pl nz na po nc
        cs=0010  ss=0018  ds=002b  es=002b  fs=0053  gs=002b             efl=00010206
        nm3!NetmonOidRequestComplete+0x53:
        fffff880`034422bf 894734          mov     dword ptr [rdi+34h],eax ds:002b:76654428`2035209a=????????
        Resetting default scope
        
        CPU_COUNT: 4
        CPU_MHZ: 9be
        CPU_VENDOR:  GenuineIntel
        CPU_FAMILY: 6
        CPU_MODEL: 3a
        CPU_STEPPING: 9
        CPU_MICROCODE: 6,3a,9,0 (F,M,S,R)  SIG: 12'00000000 (cache) 12'00000000 (init)
        DEFAULT_BUCKET_ID:  WIN7_DRIVER_FAULT
        PROCESS_NAME:  System
        CURRENT_IRQL:  0
        ERROR_CODE: (NTSTATUS) 0xc0000005 - The instruction at 0x%08lx referenced memory at 0x%08lx. The memory could not be %s.

        EXCEPTION_CODE_STR:  c0000005
        EXCEPTION_PARAMETER1:  0000000000000000
        EXCEPTION_PARAMETER2:  ffffffffffffffff

        FOLLOWUP_IP: 
        nm3!NetmonOidRequestComplete+53
        fffff880`034422bf 894734          mov     dword ptr [rdi+34h],eax
        READ_ADDRESS:  ffffffffffffffff 
        
        STACK_TEXT:  
        fffff880`1ad23a00 fffff880`0344224c : 00000000`00000103 00000000`105469a0 fffffa80`14a1aa10 fffff880`1ad23a60 : nm3!NetmonOidRequestComplete+0x53
        fffff880`1ad23a30 fffff880`01aee582 : fffffa80`1d577fb0 fffffa80`14a71c80 00000000`0001010e fffffa80`14b4f870 : nm3!NetmonOidRequest+0x124
        fffff880`1ad23a60 fffff880`01a6d44c : fffffa80`00000000 fffff880`01ac9110 fffffa80`14b4f870 fffffa80`14a71c80 : ndis!ndisFDoOidRequest+0x222
        fffff880`1ad23b30 fffff800`01ece355 : fffff880`01a6d400 fffff800`0206e280 fffffa80`11985460 fffffa80`00000002 : ndis!ndisDoOidRequests+0x4c
        fffff880`1ad23b70 fffff800`02160236 : 00000000`00000000 fffffa80`11985460 00000000`00000080 fffffa80`0cdceb10 : nt!ExpWorkerThread+0x111
        fffff880`1ad23c00 fffff800`01eb6706 : fffff880`02257180 fffffa80`11985460 fffffa80`11cecb50 fffff880`1c91e380 : nt!PspSystemThreadStartup+0x5a
        fffff880`1ad23c40 00000000`00000000 : fffff880`1ad24000 fffff880`1ad1e000 fffff880`1ad238a0 00000000`00000000 : nt!KxStartSystemThread+0x16
        
        
        SYMBOL_STACK_INDEX:  0
        
        SYMBOL_NAME:  nm3!NetmonOidRequestComplete+53
        
        FOLLOWUP_NAME:  MachineOwner
        
        MODULE_NAME: nm3
        
        IMAGE_NAME:  nm3.sys
        
        DEBUG_FLR_IMAGE_TIMESTAMP:  4c102c5f
        
        STACK_COMMAND:  .cxr 0xfffff8801ad23020 ; kb
        
        FAILURE_BUCKET_ID:  X64_0x7E_nm3!NetmonOidRequestComplete+53
        
        BUCKET_ID:  X64_0x7E_nm3!NetmonOidRequestComplete+53
        
        PRIMARY_PROBLEM_CLASS:  X64_0x7E_nm3!NetmonOidRequestComplete+53
    ```
  
  # get thread info
    ```
    2: kd> !thread
      THREAD fffffa8011985460  Cid 0004.1828  Teb: 0000000000000000 Win32Thread: 0000000000000000 RUNNING on processor 2
      Not impersonating
      DeviceMap                 fffff8a000008540
      Owning Process            fffffa800cdceb10       Image:         System
      Attached Process          N/A            Image:         N/A
      Wait Start TickCount      176719         Ticks: 0
      Context Switch Count      440176         IdealProcessor: 1             
      UserTime                  00:00:00.000
      KernelTime                00:00:05.397
      Win32 Start Address nt!ExpWorkerThread (0xfffff80001ece244)
      Stack Init fffff8801ad23c70 Current fffff8801ad238a0
      Base fffff8801ad24000 Limit fffff8801ad1e000 Call 0000000000000000
      Priority 13 BasePriority 13 PriorityDecrement 0 IoPriority 2 PagePriority 5
      Child-SP          RetAddr           : Args to Child                                                           : Call Site
      fffff880`1ad227f8 fffff800`0223bf24 : 00000000`0000007e ffffffff`c0000005 fffff880`034422bf fffff880`1ad237c8 : nt!KeBugCheckEx
      fffff880`1ad22800 fffff800`021f9745 : fffff800`0206e298 fffff800`01ebae42 000067ef`269255d6 fffffa80`11985460 : nt!PspUnhandledExceptionInSystemThread+0x24
      fffff880`1ad22840 fffff800`01ef0cb4 : 00000000`00000000 00000000`00000000 fffffa80`14dea000 fffff800`02058580 : nt! ?? ::NNGAKEGL::`string'+0x21dc
      fffff880`1ad22870 fffff800`01ef072d : fffff800`0202b3d0 fffff880`1ad23c00 00000000`00000000 fffff800`01e55000 : nt!_C_specific_handler+0x8c
      fffff880`1ad228e0 fffff800`01eef505 : fffff800`0202b3d0 fffff880`1ad22958 fffff880`1ad237c8 fffff800`01e55000 : nt!RtlpExecuteHandlerForException+0xd
      fffff880`1ad22910 fffff800`01f00a05 : fffff880`1ad237c8 fffff880`1ad23020 fffff880`00000000 76654428`00000007 : nt!RtlDispatchException+0x415
      fffff880`1ad22ff0 fffff800`01ec4a82 : fffff880`1ad237c8 fffffa80`1d577fb0 fffff880`1ad23870 00000000`c000000d : nt!KiDispatchException+0x135
      fffff880`1ad23690 fffff800`01ec338a : 00000000`00000005 fffff880`01aee7c1 fffffa80`14b4e820 00000000`00000005 : nt!KiExceptionDispatch+0xc2
      fffff880`1ad23870 fffff880`034422bf : ffff0000`1b7ea80e 00000000`00000001 00000000`00000000 fffffa80`14a1aa10 : nt!KiGeneralProtectionFault+0x10a (TrapFrame @ fffff880`1ad23870)
      fffff880`1ad23a00 fffff880`0344224c : 00000000`00000103 00000000`105469a0 fffffa80`14a1aa10 fffff880`1ad23a60 : nm3!NetmonOidRequestComplete+0x53
      fffff880`1ad23a30 fffff880`01aee582 : fffffa80`1d577fb0 fffffa80`14a71c80 00000000`0001010e fffffa80`14b4f870 : nm3!NetmonOidRequest+0x124
      fffff880`1ad23a60 fffff880`01a6d44c : fffffa80`00000000 fffff880`01ac9110 fffffa80`14b4f870 fffffa80`14a71c80 : ndis!ndisFDoOidRequest+0x222
      fffff880`1ad23b30 fffff800`01ece355 : fffff880`01a6d400 fffff800`0206e280 fffffa80`11985460 fffffa80`00000002 : ndis!ndisDoOidRequests+0x4c
      fffff880`1ad23b70 fffff800`02160236 : 00000000`00000000 fffffa80`11985460 00000000`00000080 fffffa80`0cdceb10 : nt!ExpWorkerThread+0x111
      fffff880`1ad23c00 fffff800`01eb6706 : fffff880`02257180 fffffa80`11985460 fffffa80`11cecb50 fffff880`1c91e380 : nt!PspSystemThreadStartup+0x5a
      fffff880`1ad23c40 00000000`00000000 : fffff880`1ad24000 fffff880`1ad1e000 fffff880`1ad238a0 00000000`00000000 : nt!KxStartSystemThread+0x16
    
    #display words and symbos
    - dds displays double-word (4 byte) values like the dd command. 
    - dqs displays quad-word (8 byte) values like the dq command. 
    - dps displays pointer-sized values (4 byte or 8 byte, depending on the target computer's architecture) like the dp command.

    # Base fffff8801ad24000 Limit fffff8801ad1e000 Call 0000000000000000
    dps fffff8801ad1e000 fffff8801ad24000
    ```

  - usage:
    - debugging enable?
      ```
      0:000> uf kernel32!IsDebuggerPresent
        KERNELBASE!IsDebuggerPresent:
        75161f8f 64a118000000    mov     eax,dword ptr fs:[00000018h]
        75161f95 8b4030          mov     eax,dword ptr [eax+30h]
        75161f98 0fb64002        movzx   eax,byte ptr [eax+2]
        75161f9c c3              ret

        0:000> dd fs:[18h]
        003b:00000018  7ffdf000 00000000 00000e04 00000264
        003b:00000028  00000000 7ffdf02c 7ffd9000 00000000

      0:000> dd 7ffdf000+30
        7ffdf030  7ffd9000 00000000 00000000 00000000

      0:000> !peb
        PEB at 7ffd9000
            InheritedAddressSpace:    No
            ReadImageFileExecOptions: No
            BeingDebugged:            Yes

      0:000> dt nt!_PEB   ; eax,byte ptr [eax+2]
        ntdll!_PEB
          +0x000 InheritedAddressSpace : UChar
          +0x001 ReadImageFileExecOptions : UChar
          +0x002 BeingDebugged    : UChar
          +0x003 BitField         : UChar
          +0x003 ImageUsesLargePages : Pos 0, 1 Bit

      0:000> dt nt!_PEB 7ffd9000
        ntdll!_PEB
          +0x000 InheritedAddressSpace : 0 ''
          +0x001 ReadImageFileExecOptions : 0 ''
          +0x002 BeingDebugged    : 0x1 ''
      ```
      - IsDebuggerPressent() to verify
        - modify peb.BeingDebugged

      - NTQueryInformationProcess() to verify
        - modify EPROCESS.DebugPort in kernel mode
        ```
        0:000> dt _EPROCESS -y Debug
          ntdll!_EPROCESS
            +0x0ec DebugPort : Ptr32 Void
        ```

      - use SEH, when debugged exceptions will be handled by debugger rather than the app
        ```c
        bool isDebugged = TRUE;

        __try{
          __asm int 0x03
        } __except(EXCEPTION_EXECUTE_HANDLER) {
          isDebugged = FALSE;
        }
        ```

      - kernel mode
        ```
        if( KdRefreshDebuggerNotPresent() == FALSE){
          /* debugger is attached */
        }

        KD_DEBUGGER_NOT_PRESENT == FALSE /* debugger is ataching */
        ```

      - EFLAGS TF(Trap Flag)
        ```
        __try {
          __asm {
            pushfd;
            pop flagsReg;
          }
          /* set TF */
          flagsReg = flagsReg | 0x00000100;
          __asm {
            push flagsReg;
            popfd;
          }
        } __except (EXCEPTION_EXECUTE_HANDLER) {
          /* debbuger not pressent */
        }
        ```
      - GetThreadContext

* software debugging
    * catagory
        1. target environment 
            windows, linux, macOS, etc
            for language run in vm such as java and .net
        2. taget code 
            * native debugging
            * inter-op debugging (混合)
            * script debugging
        3. target excute mode
            * user mode debugging
            * kernel mode debugging
        4. debugger and target location
            * local debugging
            * remote debugging
        5. target activity
            * live target debugging
            * dump file debbugging
        6. debugging tools
    * break point:
        1. set space 
            * code bk
            * data bk
            * I/O bk
        2. set method
            * software break: IA32 INT 3 , only for code breakpoint
            * hardware break: debugging registers: DR0-DR7
        3. others
            * tracepoint
            * condition breakpoint 
    * step by step:
        1. a assembly instruction:
            * IA32: set trap flag to genarate INT 1
        2. a phrase in src code: 
        3. a branch:
            set dbgctl msr btf(branch trap flag), set tf 
        4. a task:
            set TSS(task status segment) T to 1
    * method    
        * print
        * log
        * event trace
        * dump
        * stack backtrace
        * disassemble
        * watch and modify data
        * control the process and thread debugging on

    * basic procedure
       1. replay fault
       2. locate the root cause
       3. explore and implement a solution
       4. verify the solution
    * tools
       bugzilla
    * cost 
       period          | cost
       ------          | ----
       requirement     | 2
       design          | 5
       coding          | 10
       developing test | 20
       acceptance test | 50
       run             | 150
    * debug and test 
       * test: find defect
       * debug: find root cause
    * cpu debug support 
        1. INT 3
        2. EFLAGS TF
        3. DR0-DR7
        4. breakpoint exception(#BP): INT 3
        6. debugpoint exception(#DP): deubgging events cause by others except int 3
        7. tss T flag: task trap flag 
        8. branck record: record address of branch, interrupts or exceptions before
        9. performance monitor: monitor and optimize cup and software
        10. JTAG:  Joint Test Action Group 
    * IA32
        1. 4GB
        2. flat memory model
        3. paging
        4. debugging registers
        5. virtual 8086
        6. SMM: system management mode include power management, hardware control and other firmware
        7. MMX: multimedia extention, SIMD
        8. APIC: local and io
        9. msr: model specific registers, rdmsr  wrmsr
        10. mtrr: memory type and range register: UC(unreachable), WC(write-combine), WT(write-throght), WP(write-protect)
        11. SSE: Stream SIMD extentio
    
    * int 3: software breakpoint
      - breakpoint on code, not suitable for data or I/O.
      - can't add breakpoint to ROM, use hard interrupt
      - can't work when IDT or IVT being destroyed, use hard level debugging tools
    
    * hardware breakpoint
      - IA32 debug registers dr0-dr7
        - dr4, dr5 are reserved, when debug extension enables(cr4 DE=1), access dr4 or dr5 cause 
          undefined instruction(#UD), when disabled, dr4 and dr5 are alias of dr6 and dr7 seperately
        
        - 4 32-bit address regester dr0-dr3: 
          - 64bit on 64-bit system
          - Specifies the addresses of up to 4 breakpoints
          - 
        - 1 32-bit status  register dr6: high 32 reserved on 64-bit system
        - 1 32-bit control register dr7: high 32 reserved on 64-bit system

(3b34.294c): Access violation - code c0000005 (!!! second chance !!!)


# registry
  * structures
    1. https://blogs.technet.microsoft.com/ganand/2008/01/05/internal-structures-of-the-windows-registry/
    2. https://technet.microsoft.com/library/cc750583.aspx
    3. https://support.microsoft.com/en-us/help/256986/windows-registry-information-for-advanced-users
  
  * location
    * %SystemRoot%\System32\Config folder on Windows NT 4.0, Windows 2000, Windows XP, Windows Server 2003, and Windows Vista.
    * HKEY_CURRENT_USER are in the %SystemRoot%\Profiles\Username folder
      ```
      Registry hive	Supporting files
      HKEY_LOCAL_MACHINE\SAM	Sam, Sam.log, Sam.sav
      HKEY_LOCAL_MACHINE\Security	Security, Security.log, Security.sav
      HKEY_LOCAL_MACHINE\Software	Software, Software.log, Software.sav
      HKEY_LOCAL_MACHINE\System	System, System.alt, System.log, System.sav
      HKEY_CURRENT_CONFIG	System, System.alt, System.log, System.sav, Ntuser.dat, Ntuser.dat.log
      HKEY_USERS\DEFAULT	Default, Default.log, Default.sav
      ```

  * [add ida association](https://msdn.microsoft.com/en-us/library/windows/desktop/cc144171(v=vs.85).aspx)
    ```
    Windows Registry Editor Version 5.00

    [HKEY_CLASSES_ROOT\exefile\shell\IDA_pro_x86]
    @="Open with IDA pro(x&86)"

    [HKEY_CLASSES_ROOT\exefile\shell\IDA_pro_x86\Icon]
    @="\"C:\\Program Files (x86)\\IDA 6.8\\idaq.exe\",0"

    [HKEY_CLASSES_ROOT\exefile\shell\IDA_pro_x86\command]
    @="\"C:\\Program Files (x86)\\IDA 6.8\\idaq.exe\" \"%1\" "


    [HKEY_CLASSES_ROOT\exefile\shell\IDA_pro_x64]
    @="Open with IDA pro(x&64)"

    [HKEY_CLASSES_ROOT\exefile\shell\IDA_pro_x64\Icon]
    @="\"C:\\Program Files (x86)\\IDA 6.8\\idaq64.exe\",0"

    [HKEY_CLASSES_ROOT\exefile\shell\IDA_pro_x64\command]
    @="\"C:\\Program Files (x86)\\IDA 6.8\\idaq64.exe\" \"%1\" "
    ```
  
  - [registry string redirection](https://msdn.microsoft.com/en-us/library/windows/desktop/dd374120(v=vs.85).aspx)
    - format
      ```
      "@<PE-path>,-<stringID>[;<comment>]"
      
      @%SystemRoot%\system32\input.dll,-5020
      ```
      - PE-path specifies the path of executable, can use %Programfiles%
      - stringID specifies the numeric resource identifier of the relevant string resource
      - comment specifies optional information for debugging or readability of the registry value

  - usage
    - don't display user name

    - permission
      - regini.exe
        ```

        ```


# [network tracing in windows](https://msdn.microsoft.com/en-us/library/windows/desktop/dd569136(v=vs.85).aspx)
  - network tracing architecture
    - ![architecture](img/network_tracing_architecture.png)

  - start trace
    ```
    # trace
    netsh trace show scenarios 
    netsh trace show providers (show all including ones not relevant to network)
    netsh trace show scenarios internetclient
    netsh trace start scenarios=FileSharing scenarios=DirectAccess
    netsh trace start scenarios=wlan provider=Microsoft-Windows-Dhcp-client
    ```
    # two files are generated by default: 
      - an Event Trace Log (ETL) file (default nettrace.etl)

        - Trace events are collected in the ETL file, which can be viewed using tools such as Network Monitor
        
        - tracefile=filename.etl # set filename

      - a .cab file.(default nettrace.cab): report.etl, report.html

        - rich information about the software and hardware on the system such as the adapter information, 
          build, operating system, and wireless settings. 

        - Report.etl is another copy of the same information included in nettrace.etl. 

        - report.html file includes additional information about the trace events and the other information collected.

        - recieve most info avalaible , set 
          report=yes
    
    # using filter
      ```
      netsh trace start InternetClient provider=Microsoft-Windows-TCPIP level=5 keywords=ut:ReceivePath,ut:SendPath.
      ```
      Level	|    Setting	     |  Description
      ----- |    -------       |  ----------
      1	    |    Critical	     |  Only critical events will be shown.
      2	    |    Errors	       |  Critical events and errors will be shown.
      3	    |    Warnings	     |  Critical events, errors, and warnings will be shown.
      4	    |    Informational |	Critical events, errors, warnings, and informational events will be shown.
      5	    |    Verbose	     |  All events will be shown.

      - show provider filter
        ```
        # specific provider can be found by typing netsh trace show provider 
        netsh trace show provider Microsoft-Windows-TCPIP
        ```

      - packet filtering capability
        ```
        netsh trace start capture = yes ipv4.address 
        netsh trace show capturefilterHelp
        ```

    # stop trace
      ```
      netsh trace stop
      ```
  # tools
    - Service Trace Viewer Tool (SvcTraceViewer.exe)
    - Windows and SQL Server Network Monitor Parsers 

# [software tracing](https://msdn.microsoft.com/en-us/windows/hardware/drivers/devtest/survey-of-software-tracing-tools)
  1. tracing related concept
    - trace provider: a user-mode application or kernel-mode driver that uses Event Tracing for Windows (ETW) technology to 
      generate trace messages or trace events

    - trace log: event trace log(.etl) stores the trace message generated during one or more trace sessions

    - trace session:  a period during which a trace provider is generating trace messages
      - three basic types 
        - trace log sessions: shared, standard and default type of trace session
          ```
          trace message ---> strace buffers --------> log file
          ```
        - real-time trace sessions: shared
          ```
          trace messages -------> trace consumer(traceview, tracefmt)
                |________________ log file
          ```
        - buffered trace sessions: exclusive
          ```
          trace messages ---------> trace buffer(when full newest override old messages in the buffer)

          # to log file
          tracelog -flush 
          start a buffered trace session
          # reset the registry entries, use the following command
          tracelog -start -buffering
          ```

      - private trace sessions(user-mode trace sessions or process trace sessions) and reserved trace sessions
         one private trace session <------------> one process
        - NT Kernel Logger trace session: trace windows kernel events, reserved trace session that is built into Windows
        
        - Global Logger trace session : trace kernel events during system boot to an NT Kernel Logger trace session
          - only one Global Logger session at a time.
          - not send enable notification to providers.
          ```
          tracelog -start GlobalLogger
          tracelog -stop GlobalLogger
          # reset the registry entries, use the following command
          #  HKLM\SYSTEM\CurrentControlSet\Control\WMI\GlobalLogger
          tracelog -remove GlobalLogger
          ```

  2. tools in Windows driver kits or windows software kits
    - controlling trace sessions(trace controller)
      - traceview.exe is GUI-base __trace-controller__ and __trace-consumer__ especially for real-time display of trace messages,
        It enables, configures, starts, updates, and stops trace session. This tool also formats, filters, and displays trace messages 
        from real-time trace sessions and trace logs.

      - tracelog.exe is command-line __trace controller__ that enables, configures, starts, updates, and stops real-time and log sessions and supports :
        - user-mode sessions
        - kernel-mode trace sessions
        - NT Kernel Logger trace sessions 
        - the Global Logger (boot) trace session. 
        - tracing to measure time spent in deferred procedure calls (DPCs) and interrupt service routines (ISRs).
      
      - Logman (Logman.exe) is a fully functional, command-based trace controller that is designed especially to control the logging of 
        performance counters and event traces.

    - creating tmf files
      - Tracepdb (Tracepdb.exe) is a command-line support tool that creates trace message format (TMF) files from the trace message 
        formatting instructions in PDB symbol files.

      - Tracefmt can create TMF files from PDB symbol files.

    - formating and display trace messages(trace consummers)
      - Tracefmt:
        - command-line trace consumer
        - formats real-time __trace sessions__ or __trace logs__
        - writes them to files or displays them in the Command Prompt window.
      
      - Tracerpt (Tracerpt.exe) 
        - command-line trace consumer 
        - formats __trace events (TraceEvent)__ and __performance counters__
        - writes them to CSV or XML files. 
        - analyzes the events and generates summary reports.

      - traceview 
        - GUI-based tool, both trace controller and trace consumer
        - formats and displays  real-time trace sessions or trace logs
        - displays in a tabular form, easier to filter and browse.

    - Viewing trace events in a debugger
      - !wmitrace: debugger extension displays the trace message in trace session buffer before write to log files or delivery for display
      
      - tracelog -kd to redirect trace message to KD

      - traceview -kd redirect trace message to Windbg

    - Analyzing DPC and ISR execution times
      - windows xp sp2 or later 
        - tracelog to log DPC or ISR in the NT kernel log session;
        - tracerpt to create summery from logs;

    - usage
      - watch HookSSDT driver event 
        - using traceview: Locate the PDB symbol file for the source code that includes the provider or providers
          ```
          HookSSDK.pdb
          ```

        - locate 
          "C:\WinDDK\7600.16385.1\tools\tracing\i386\tracepdb.exe -f HookSSDK.pdb -o HookSSDK.tmf"
        


# Troubleshooting technics
  - perfmon 
    cpu not accurate

  - resmon
    cannot save file
    Registry path
    ```
    # cpu high write thumbcache_xxx.db file
    [HKEY_CURRENT_USER\Software\Policies\Microsoft\Windows\Explorer]

    "DisableThumbsDBOnNetworkFolders"
    Type:REG_DWORD
    Value:1
    ```

  - WPA(windows performance analyzer)
    - windows performance recorder:
      wprui: UI
      wpr.exe: command-line-based


  - windbg
    - crash dmp file
    - sysmbols path set 

  - poolmon
    ```
    P - Sorts tag list by Paged, Non-Paged, or mixed. Note that P cycles through each one.
    B - Sorts tags by max byte usage.
    M - Sorts tags by max byte allocation.
    T - Sort tags alphabetically by tag name.
    E - Display Paged, Non-paged total across bottom. Cycles through.
    A - Sorts tags by allocation size.
    F - Sorts tags by "frees".
    S - Sorts tags by the differences of allocs and frees.
    E - Display Paged, Non-paged total across bottom. Cycles through.
    Q - Quit.
    ```

  - verifier.exe (driver verifier)
    - remember to turn off when not needed

    crash and hangs --> memory, driver

  - kernel or application
    kernel  -> blue screen -> get crash
    hangs -> force crash -> blue screen

  - 

# windows detail
  1. fork code
  2. download book
  3. windows via c/c++
    - [character set](https://www.ibm.com/developerworks/library/ws-codepages/)
      - Character sets: characters with numbers

        - Baudot was designed for 5-bit units

        - ASCII for 7 bits: The American Standard Code for Information Interchange
          128: 33 control, 95 printable
        
        - EBCDIC for 8 bits: The Extended Binary-Coded Decimal Interchange Code

      - design a character set

        - decide how many and which characters(Abstract Character Repertoire) you need , set the upper limit for your integer values

        - give each character a number

        - you've got a character set. The result is called a Coded Character Set

      - catagory
        - SBCS(single byte character set)
          - ANSI/ISO-8859-1 8-bit

        - DBCS(double byte character set)

        - MBCS(mutiple byte character set)
          - A multibyte character set may consist of both one-byte and two-byte characters. 

      - UTF-8
        ```
        1 	7 	U+0000 	  U+007F 	  0xxxxxxx 			
        2 	11 	U+0080  	U+07FF 	  110xxxxx 	10xxxxxx 		
        3 	16 	U+0800  	U+FFFF 	  1110xxxx 	10xxxxxx 	10xxxxxx 	
        4 	21 	U+10000 	U+10FFFF 	11110xxx 	10xxxxxx 	10xxxxxx 	10xxxxxx

        # cmd
        @ECHO OFF
        REM change CHCP to UTF-8
        CHCP 65001
        CLS

        # Reg file
        Windows Registry Editor Version 5.00
        [HKEY_CURRENT_USER\Console]
        "CodePage"=dword:fde9

        # Command Prompt
        REG ADD HKCU\Console /v CodePage /t REG_DWORD /d 0xfde9

        # PowerShell
        sp -t d HKCU:\Console CodePage 0xfde9

        # Cygwin
        regtool set /user/Console/CodePage 0xfde9
        ```

      - ANSI and Unicode in windows
        - ANSI: 8bit
        
        - Unicode : UTF-16
          - wchar_t 16bit

        ```c
        /* WinNT.h */
        typedef char CHAR;        // 8-bit character
        typedef wchar_t WCHAR;    // 16-bit character

        typedef CHAR *PCHAR, *PSTR;
        typedef const CHAR *PCSTR;

        typedef WCHAR *PWCHAR, *PWSTR;
        typedef CONST WCHAR *PCWSTR;
        ```
        
        - TCHAR
          ```c
          /* WinNT.h */
          #ifdef  UNICODE

          typedef WCHAR TCHAR, *PTCHAR;
          #define __TEXT(quote) L##quote 

          #else  /* UNICODE */  
          
          typedef char TCHAR, *PTCHAR;
          #define __TEXT(quote) quote
          
          #endif  /* UNICODE */  
          #define TEXT(quote) __TEXT(quote)
          ```

        - string len
          ```c
          /* tchar.h */
          #ifdef  UNICODE  
          #define _tcslen         wcslen
          #else
          #define _tcslen     strlen
          #endif
          ```

    # [kernel object](https://msdn.microsoft.com/en-us/library/windows/desktop/ms724515(v=vs.85).aspx)
      * The system provides three categories of objects: user, graphics device interface (GDI), and kernel
        - user objects support window management:
          - Accelerator: table	Keyboard Accelerators
          - Caret
          - Cursor
          - DDE conversation: Dynamic Data Exchange Management Library
          - Hook
          - Icon
          - Menu
          - windows
            - Window
            - Window position
        - gdi objects support graphics
          - bitmap
          - brush
          - pen and extend pen
          - colors
          - font
          - device contexts
            - DC (device context)
            - Memory DC
          - region
          - metafiles
            - Enhanced metafile
            - Enhanced metafile DC
            - metafile

        - kernel objects support memory management, process execution, and interprocess communications (IPC)        
          - Access: token	Access Control
          - Change: notification	Directory Change Notifications
          - Communications device
          - Applications
            - Console input	Character-Mode 
            - Console screen buffer	Character-Mode 
          - Desktop	
          - Event	Synchronization
          - Event log	Event Logging
          - File	Files and Clusters
          - File mapping	File Mapping
          - Heap	Memory Management
          - Job	
          - Mailslot	Mailslots
          - Module	Dynamic-Link Libraries
          - Mutex	Synchronization
          - Pipe	Pipes
          - Process	Processes and Threads
          - Semaphore	Synchronization
            - Semaphore	Synchronization
            - Timer	Synchronization
            - Timer queue	Synchronization
            - Timer-queue timer	Synchronization
          - Socket	Windows Sockets 2
          - Thread	Processes and Threads
          - Update resource	Resources
          - Window station	Window Stations             
        
      * kernel object has SECURITY_ATTRIBUTES in parameters when created;

      * kernel object is managed by handle table created by os;

        index | pointer to kernel object | access mask | sign
        [handle table entry](http://www.alex-ionescu.com/?p=196)
        # get handle using procexp
          Ctrl+h #show object handles
          ```
          explore.exe  pid: 1952
          0xD50	Mutant	\Sessions\1\BaseNamedObjects\DBWinMutex	0x00160001	0xFFFFFA8012063FC0		READ_CONTROL | SYNCHRONIZE | WRITE_DAC | QUERY_STATE

        # livekd:
          - show object info
            ```
            0: kd> !object \Sessions\1\BaseNamedObjects\DBWinMutex
            Object: fffffa8012063fc0  Type: (fffffa800cde53c0) Mutant
                ObjectHeader: fffffa8012063f90 (new version)
                HandleCount: 17 PointerCount: 18
                Directory Object: fffff8a0012b2230  Name: DBWinMutex
            ```

          - show handle info
            ```
            # !handle [Handle [KMFlags [Process [TypeName]]]]
            # Bit 0 (0x1) :Displays handle type information.
            # Bit 1 (0x2): Displays basic handle information.
            # Bit 2 (0x4): Displays handle name information.
            # Bit 3 (0x8): Displays object-specific handle information, when available.
            # handle_index: 0xd50 kmflags: 0x2 pid: 1952 
            # 0x prefix (hexadecimal), the 0n prefix (decimal), the 0t prefix (octal), or the 0y prefix (binary).
            0: kd> !handle 0xd50 2 0n1952 
            PROCESS fffffa8010f0b2f0
                SessionId: 1  Cid: 07a0    Peb: 7fffffde000  ParentCid: 0630
                DirBase: 3e053b000  ObjectTable: fffff8a0030984e0  HandleCount: 1439.
                Image: explorer.exe

            Handle table at fffff8a0030984e0 with 1439 entries in use

            0d50: Object: fffffa8012063fc0  GrantedAccess: 00160001 Entry: fffff8a004cd2540
            Object: fffffa8012063fc0  Type: (fffffa800cde53c0) Mutant
                ObjectHeader: fffffa8012063f90 (new version)
                    HandleCount: 17 PointerCount: 18
                    Directory Object: fffff8a0012b2230  Name: DBWinMutex
            ```

          - show handle table
            ```
            dt nt!_HANDLE_TABLE fffff8a0030984e0
            +0x000 TableCode        : 0xfffff8a0`039cd001
            +0x008 QuotaProcess     : 0xfffffa80`10f0b2f0 _EPROCESS
            +0x010 UniqueProcessId  : 0x00000000`000007a0 Void
            +0x018 HandleLock       : _EX_PUSH_LOCK
            +0x020 HandleTableList  : _LIST_ENTRY [ 0xfffff8a0`030ea540 - 0xfffff8a0`0301d7d0 ]
            +0x030 HandleContentionEvent : _EX_PUSH_LOCK
            +0x038 DebugInfo        : (null)
            +0x040 ExtraInfoPages   : 0n0
            +0x044 Flags            : 0
            +0x044 StrictFIFO       : 0y0
            +0x048 FirstFreeHandle  : 0x104c
            +0x050 LastFreeHandleEntry : 0xfffff8a0`05500ff0 _HANDLE_TABLE_ENTRY
            +0x058 HandleCount      : 0x59f
            +0x05c NextHandleNeedingPool : 0x1c00
            +0x060 HandleCountHighWatermark : 0x689
            ```

          - show table entry
            ```
            0: kd> dt nt!_HANDLE_TABLE_ENTRY  fffff8a004cd2540
            +0x000 Object           : 0xfffffa80`12063f91 Void
            +0x000 ObAttributes     : 0x12063f91
            +0x000 InfoTable        : 0xfffffa80`12063f91 _HANDLE_TABLE_ENTRY_INFO
            +0x000 Value            : 0xfffffa80`12063f91
            +0x008 GrantedAccess    : 0x160001
            +0x008 GrantedAccessIndex : 1
            +0x00a CreatorBackTraceIndex : 0x16
            +0x008 NextFreeTableEntry : 0x160001
            ```

            dt nt!_KMUTANT <addr> will show you the layout of the mutex itself. 
            There's also an nt!_OBJECT_HEADER that precedes it
          (!object displays the address of the header).

      * thread, file, metux, filemapping
        CreateXXX
        return:
           NULL(0) error, but CreateFile needs to check for INVALID_HANDLE_VALUE(-1)
      
      * terminal service namespace
        * session 0(inactive terminal service)
        * Global
        * Local
        * Private

      - process
        * Environments
          ```
          HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Environment

          HKEY_CURRENT_USER\Environment

          SendMessage(HWND_BROADCAST, WM_SETTINGCHANGE, 0, (LPARAM)_T("Environment"));
          ```

      - FileMapping
        ```
        * HANDLE hFile = CreateFile();
        * HANDLE hFileMapping = CreateFileMapping(hFile, ...);
          CloseHandle(hFile);
        * PVOID pvFile = MapViewOfFile(hFileMapping, ...); 
          // increase ref count of file object and filemapping object
          CloseHandle(hFileMapping);
        * UnmapViewOfFile(pvFile, ...);
          // CloseHandle(hFileMapping);
          // CloseHandle(hFile);

        - memory-mapped file
          - mapped (i.e., not copied) into virtual memory such that it looks as though it has been loaded into memory
          - not actually being copied into virtual memory
          - a range of virtual memory addresses are simply marked off for use by the file.

  - user-mode
    - UI
      - [dialogbox](https://msdn.microsoft.com/en-us/library/windows/desktop/ms644995(v=vs.85).aspx)
        - WM_INITDIALOG
        - WM_COMMAND
        - WM_PARENTNOTIFY
        - Control-Color
          ```
          WM_CTLCOLORBTN
          WM_CTLCOLORDLG
          WM_CTLCOLOREDIT
          WM_CTLCOLORLISTBOX
          WM_CTLCOLORSCROLLBAR
          WM_CTLCOLORSTATIC
          ```

    - security
      C:\ProgramData\Microsoft\Microsoft Security Client\Support    
      ```
      dir/o/s | findstr/r " Directory | bytes" >> folder_list.txt
      ```      

# windows internal
  1. subsystem
    * csrss - client/server runtime subsystem
      
    * conhost - console window host

  - namespace
    - NT namespaces: designed to be the lowest level namespace on which other subsystems and namespaces could exist
      - Win32 subsystem, Win32 namespaces
      - POSIX
      - Early versions of Windows still supported in current versions of Windows for backward compatibility
        - communications (serial and parallel) ports 
        - the default display console 
    - Win32 namespaces: 
      ```
       use with the Windows API functions, do not all work with Windows shell applications such as Windows Explorer
       should use the "\\.\" prefix to access devices only and not files.
       \ or root -->NT namespace begins
          |
          |_____"Global??" -->Win32 namespace
          |
          |_____"Device" --->Named device objects 
      ```

      - Win32 File Namespaces
        - File I/O: the "\\?\" prefix to a path string 
          - the Windows APIs disable all string parsing
          - send the string that follows it straight to the file system

        -  "\\?\" prefix also allows the use of ".." and "." in the path names as relative path specifiers 

        -  not all file I/O APIs support "\\?\"
      
      - Win32 Device Namespaces: "\\.\" prefix
        - access the Win32 device namespace instead of the Win32 file namespace, 

        - access to physical disks and volumes directly, without going through the file system

      - NT Namespaces
        - winobjs: NT namespace beginning at the root, or "\". 

        - To make these device objects accessible by Windows applications
          -  the device drivers create a symbolic link (symlink) in the Win32 namespace("Global??")
            ```
            COM0 and COM1 under the "Global??" subdirectory are simply symlinks to Serial0 and Serial1
            "C:" is a symlink to HarddiskVolume1, "Physicaldrive0" is a symlink to DR0
            ```

        - Without a symlink, a specified device can't be accessed by any Windows application using Win32 namespace convention
          
        - a handle could be opened to that device using any APIs that support the NT namespace absolute path of the format "\Device\Xxx".

        - multi-user support via Terminal Services and virtual machines, virtualize the system-wide root device within the Win32 namespace
          ```
          \\?\GLOBALROOT
           /-+
             |
             |___ Global?? +
                           |
                           |___ GLOBALROOT
          ```

      - [path convention](https://googleprojectzero.blogspot.com/2016/02/the-definitive-guide-on-win32-to-nt.html)

    - prevent being killed 
      RtlSetProcessIsCritical 
        
  - [shutdown](http://forum.thewindowsclub.com/windows-tips-tutorials-articles/33170-how-does-shutdown-boot-work-windows-7-a.html)
    1.The user initiates a shutdown by selecting “shut down” from the Start menu, or by pressing the power button; or an application initiates shutdown by calling an API such as ExitWindowsEx() or InitiateShutdown().
    2.Windows broadcasts messages to running applications, giving them a chance to save data and settings. Applications can also request a little extra time to finish what they’re doing.
    3.Windows closes the user sessions for each logged on user.
    4.Windows sends messages to services notifying them that a shutdown has begun, and subsequently shuts them down. It shuts down ordered services that have a dependency serially, and the rest in parallel. If a service doesn’t respond, it is shut down forcefully.
    5.Windows broadcasts messages to devices, signaling them to shut down.
    6.Windows closes the system session (also known as “session 0”).
    7.Windows flushes any pending data to the system drive to ensure it is saved completely.
    8.Windows sends a signal via the ACPI interface to the system to power down the PC.

  - svchost
    - [isolate a serivce for debug ](https://docs.microsoft.com/en-us/windows-hardware/drivers/debugger/preparing-to-debug-the-service-application) 
      - query config
        ```
        sc qc ServiceName 

        HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet \Services\
        HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Windows\AppInit_DLLs
        ```

      - locate registry path
        ```
        regjump HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\WindowsNT\CurrentVersion\SvcHost 
        ```

    - list
      ```
      tlist -s | findstr svchost

      tasklist /SVC /FI "IMAGENAME eq svchost.exe" 
      ```

    - [init process](http://sysforensics.org/2014/01/know-your-windows-processes/)
      - MBR
        - os write boot sector(MBR) to disk including file system boot code(part of the boot sector) to a 100-MB bootable partition of the disk marked as hidden
        - boot code in boot sector to load bootmgr from file system
      - bootmgr
        - concatenation of startup.com and bottmgr.exe

        - begin in x86 real mode  ---> protect mode (no paging) ---> create page tables below 16M ---> PE
        
        - may switch back to real mode when using BIOS interface functions to access IDE-based system, boot disks and display
        
        - read BCD(boot configuration database) file(C:\Boot\BCD) using built-in file system code
          - lightweight NTFS file system library
          - FAT, CDFS, UDFS  Universal Disk Format (UDFS) File System
          - WIM and VHD files
        
        - clear the screen
          - if BCD setting to info Bootmgr of hibernation resume 
            - luanching Winresume.exe which reads hiberfil.sys in system into memory 
            - transfer control to code in the kernel that resumes a hibernated system
              - restarting drivers that were active when the system was shut down

          - if boot-selection entry > 1 in BCD show boot-selection menu, else bypasses the menu
            - selection entries in BCD direct Bootmgr to partition on which Windows system direcotry(\Windows) of the selection resides
              - if updating from old version, this partion might be same as the system partition
              - clean install, it will always be the 100-MB hidden partition
            - BCD includes optional argument for Bootmgr, Winload, and other components involved in the boot process interpret

          - Bootmgr loads the boot loader with the select entry which will be Winload.exe for windows installations 

      - Winload(Windows boot loader)
        - contains code that queries the system's ACPI BIOS to retrieve basic device and configuration information 
          - time and date information stored in the system's CMOS(nonvalotile memory)
          - number, size and type of disk drivers in the system
          - legacy（传统） device information ,such as  buses(ISA, PCI, EISA, Micro Channel Architecture(MCA)), mice, parallel ports, and video adaptors are not queried and instead faked out

        - store this info into HKLM\HARDWARE\DESCRIPTION

        - begins loading the files from boot volume(including Kernel Mode Code Signing(KMCS))
          - loads appropriate kernel and HAL images(Ntoskrnl.exe and Hal.dll) and their dependencies

          - reads in VGA font file(C:\Windows\Fonts\vgaoem.fon)

          - reads in NLS(National Language Support)files used for internationalization. By default(l_intl.nls, c_1252.nls, nd c_437.nls
          
          - reads in the SYSTEM registry hive,(c:\windows\system32\config\system, so it can determine which device drivers nead to be loaded to accomplish the boot.

          - scans the in-memory SYSTEM registery hive and locates all the boot device drivers.
            - start value 0(SERVICE_BOOT_START) in HKLM\SYSTEM\CurrentControlSet\Services
              ```(https://docs.microsoft.com/en-us/windows-hardware/drivers/ifs/what-determines-when-a-driver-is-loaded)
              sc query type= driver
              sc qc <name>
              autoruns
              ```
          
          - add file system drivers

          - loads the boot drivers

          - prepares CPU registers for the execution of Ntoskrnl.exe
      
        - calls the main function in Ntoskrnl.exe(KiSystemStartup)

    - core parking
      ```
      regjump HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Power\PowerSettings\54533251-82be-4824-96c1-47b60b740d00\0cc5b647-c1df-4637-891a-dec35c318583

      # cpuid.com
      powercfg

      Get-WmiObject -list "*power*" | format-table -AutoSize

      Get-WmiObject -class Win32_Tpm -namespace root\CIMV2\Security\MicrosoftTpm
      ```
# MS15-050
  - 

# visual studio
  - compile option
    - /ENTRY:function
      - mainCRTStartup (or wmainCRTStartup): 
        - An application using /SUBSYSTEM: CONSOLE;
        - calls main (or wmain)

      - WinMainCRTStartup (or wWinMainCRTStartup): 
        - An application using /SUBSYSTEM: WINDOWS; 
        - calls WinMain (or wWinMain), which must be defined with __stdcall

      - DllMainCRTStartup:
        - A DLL 
        - calls DllMain, which must be defined with __stdcall, if it exists

      - usage
        - C Run-Time Libraries (CRT)[https://msdn.microsoft.com/en-us/library/abx4dbyh.aspx]
          - libucrt.lib	
            - Statically links the UCRT into your code.
            -	/MT	  # cl option
            - _MT   # Preprocessor directives
          - libucrtd.lib
            - Debug version of the UCRT for static linking. Not redistributable.	
            - /MTd	        
            - _DEBUG, _MT   
          - ucrt.lib
            -	ucrtbase.dll	DLL import library for the UCRT.	
            - /MD	
            - _MT, _DLL
          - ucrtd.lib	
            - ucrtbased.dll	DLL import library for the Debug version of the UCRT. Not redistributable.	
            - /MDd	
            - _DEBUG, _MT, _DLL
        ```
        cl /c /D _X86_=1 /D i386=1 /D _WIN32_WINNT=0x0601 /D WINVER=0x0601 /D WINNT=1 /Od /MTd /Fo /Fa /EHsc /nologo create_file.c  

        # link /VERBOSE[:{ICF|INCR|LIB|REF|SAFESEH|UNUSEDLIBS}]
        link /Entry:mainCRTStartup create_file.obj libucrt.lib /OUT:create_file.exe /DEBUG /PDB:create_file.pdb /MACHINE:x86 /SUBSYSTEM:CONSOLE /NOLOGO /MANIFEST /MANIFESTUAC:"level='requireAdministrator' uiAccess='false'" /manifest:embed
        /RELEASE (Set the Checksum)

        # get preprocess output
        cl /EP struct_padding.c
        ```

  - Format of a C decorated name
    - A decorated name for a C++ function contains the following information:
      - function name
      - The class that the function is a member of
      - The namespace the function belongs to, if it is part of a namespace.
      - The types of the function parameters.
      - The calling convention.
      - The return type of the function.
      ```
      Calling convention |        	Decoration
      ---------------- - | -----------------------
          __cdecl	       |  Leading underscore (_)
          __stdcall	     |  Leading underscore (_) and a trailing at sign (@) followed by the number of bytes in the parameter list in decimal
          __fastcall	   |  Leading and trailing at signs (@) followed by a decimal number , the number of bytes in the parameter list
          __vectorcall	 |  Two trailing at signs (@@) followed by a decimal number of bytes in the parameter list
      ```

  - create project from sources
    // Disable warning messages 4507 and 4034.  
    #pragma warning( disable : 4507 34 )  
      
    // Issue warning 4385 only once.  
    #pragma warning( once : 4385 )  
      
    // Report warning 4164 as an error.  
    #pragma warning( error : 164 )  

  - error scheme definition
    https://social.msdn.microsoft.com/Forums/en-US/31f52b76-b0de-406d-9c25-2f329dd7cf1c/microsoftcommontargetserrors-and-over-a-hundred-warnings?forum=Vsexpressvb
    close all opened text editor in vs

  - error open hlpviewer
    - open procmon
      ```
      include PrcessName hlpviewer.exe
      
      monitor registry and file
      ```
    - result
      ```
      8:51:57.0637073	9296	HlpViewer.exe	9324	CreateFile	C:\Users\Dobly\AppData\Local\Microsoft\HelpViewer2.1\VisualStudio12_en-US\catalogType.xml	__NAME NOT FOUND__	Desired Access: Read Attributes, Disposition: Open, Options: Open Reparse Point, Attributes: n/a, ShareMode: Read, Write, Delete, AllocationSize: n/a
      ```
      catalogType.xml 

    - install catalog
      ```
      C:\ProgramData\Microsoft\HelpLibrary2\Catalogs\VisualStudio12\

      hlpctntMgr /operation install /catalogName VisualStudio12 /locale en-US /sourceUri C:\Users\Dobly\AppData\Local\Microsoft\HelpViewer2.1\VisualStudio12_en-US\helpcontentsetup.msha
      ```

    - open catelog
      ```
      "C:\Program Files (x86)\Microsoft Help Viewer\v2.2\HlpViewer.exe" /catalogName VisualStudio14 /helpQuery method=f1&query=msdnstart /locale en-US /sku 1800 /launchingApp Microsoft,VisualStudio,14.0

      HlpCtntMgr.exe /operation uninstall /catalogName VisualStudio14 /locale en-US

      "C:\Program Files (x86)\Microsoft Help Viewer\v2.2\hlpctntMgr.exe" /operation install /catalogName VisualStudio14 /locale en-US /sourceUri C:\Users\Dobly\AppData\Local\Microsoft\HelpViewer2.2\VisualStudio14_en-US\helpcontentsetup.msha

      # restart updateCommand
      "C:\Program Files (x86)\Microsoft Help Viewer\v2.2\HlpCtntMgr.exe" "/operation" "restart" "/catalogName" "VisualStudio14" "/restart" "UpdateCommand" "/locale" "en-US" "/E"
      ```

    - [driver sign](https://technet.microsoft.com/en-us/library/dd919238(v=ws.10).aspx)
      - create a digital certificate for signing
        ```
        C:\WinDDK\7600.16385.1\bin\x86\makecert -$ individual -r -pe -n "CN=Dobly - for test use only" -ss "self-signing store" -sr LocalMachine "DDK.cer"
        ```

      - Add the certificate to the Trusted Root Certification Authorities store
        This step is required for locally created certificates, such as those created by using MakeCert, which are not directly traceable to a Trusted Root Certification Authority certificate.
        ```
        C:\WinDDK\7600.16385.1\bin\x86\CertMgr.Exe /add "DDK.cer" /s /r localMachine root
        ```

      - Add the certificate to the per machine Trusted Publishers store
        To use your new certificate to confirm the valid signing of device drivers, it must also be installed in the per computer Trusted Publishers store.
        ```
        C:\WinDDK\7600.16385.1\bin\x86\CertMgr /add "DDK.cer" /s /r localMachine trustedpublisher
        ```
      
      - Enable the Kernel-Mode Test-Signing Boot Configuration Option
        ```
        bcdedit /set testsigning on
        ```

      - Sign the device driver package with the certificate
        ```
        C:\WinDDK\7600.16385.1\bin\x86\signtool.exe sign /a /v /s "self-signing store" /n "Dobly" /t http://timestamp.verisign.com/scripts/timestamp.dll "protector.sys"

        C:\WinDDK\7600.16385.1\bin\x86\signtool.exe verify /pa /v "protector.sys"
        ```

      - [Viewing Code Integrity Events](https://msdn.microsoft.com/en-us/windows/hardware/drivers/install/enabling-the-system-event-audit-log)
        - Enable Security Audit Policy
          ```
          Auditpol /set /Category:System /failure:enable
          ```
        - Enable Verbose Logging of Code Integrity Diagnostic Events
          ```
          eventvwr.msc  
            Applications and Services Logs -> Microsoft -> Windows ->  CodeIntegrity
          ```
    - create kernel driver service and start it
      ```
      sc create genport type= kernel binpath= "c:\driver\genport.sys" start= auto
      sc start protectorservice 
      ```

  - driver
    - driver support routines
      - Object Manager Routines

    - trace log 
      ```
      trace message header (TMH) 
      trace level
      trace flags
      ```

    - WPP(windows software trace processor)[https://msdn.microsoft.com/en-us/windows/hardware/drivers/devtest/wpp-software-tracing]
      - DoTraceMessage 
        %!ntstatus! [https://msdn.microsoft.com/en-us/library/cc704588.aspx]

    - test
      - verifier
        ```
        bit 0  - special pool checking
        bit 1  - force irql checking
        bit 2  - low resources simulation
        bit 3  - pool tracking
        bit 4  - I/O verification
        bit 5  - deadlock detection
        bit 6  - unused
        bit 7  - DMA verification
        bit 8  - security checks
        bit 9  - force pending I/O requests
        bit 10 - IRP logging
        bit 11 - miscellaneous checks

        verifier /standard /driver HookSSDT.sys
        verifier /flags FF /driver HookSSDT.sys

        # Start or Stop the Verification of a Driver without Rebooting
        verifier /volatile /adddriver DriverName.sys
        verifier /volatile /removedriver DriverName.sys

        # Activate or Deactivate Options without Rebooting
        verifier /valotile /flags 0x02

        # Deactivate All Driver Verifier Options
        verifier /valotile /flags 0x0

        # Deactivate Driver Verifier, after next reboot
        verifier /reset         

       ```

      - windbg
        ```
        !verifier 
        ```

    - deploy driver
      - set test environment in vmware
      - Provision a computer for driver deployment and testin (Visual Studio help documentation)

      - driver install in comand line
        ```
        [devcon](http://www.robvanderwoude.com/devcon.php)
        C:\WinDDK\7600.16385.1\tools\devcon\i386\devcon -r install hookssdk.ini root\hookssdt
          : Install driver package onto device
          - Query("HardwareIDs='Root\HookSSDK' OR CompatIDs='Root\HookSSDK'")
                  Target: ROOT\SAMPLE\0000
          - GetInterfaces("DriverSetup")
                  Target: ROOT\SAMPLE\0000

        "C:\Program Files (x86)\Windows Kits\8.1\Tools\x64\devcon" classes * | grep -i non
        LegacyDriver        : Non-Plug and Play Drivers  

        devcon hwids =LegacyDriver | grep -i iobit -A 4
          ROOT\LEGACY_IOBITUNLOCKER\0000
          Name: IObitUnlocker
          No hardware/compatible IDs found for this device.

        devcon listclass LegacyDriver | grep -i iobit
          ROOT\LEGACY_IOBITUNLOCKER\0000                              : IObitUnlocker

        devcon driverfiles =LegacyDriver ROOT\LEGACY_IOBITUNLOCKER\0000

        "C:\WinDDK\7600.16385.1\tools\devcon\i386\devcon.exe"  install HookSSDK.inf Root\HookSSDK
        ```

    - debug
      ```
      .lines        enable source line information
      bu HookSSDK!DriverEntry       set initial breakpoint
      bp `driver.c:31` 
      l+t           stepping will be done by source line
      l+s           source lines will be displayed at prompt
      g             run program until "main" is entered
      pr            execute one source line, and toggle register display off
      p             execute one source line
      g
      ```
  
  - kernel api
    prefix  | description
    ------  | ------------
    Aux     | Auxiliary Library
    Clfs    | Common Log File System
    Cc      | Cache Manager
    Cm      | Configuration Manager
    Ex      | Executive (Memory Allocation wrappers, etc)
    Flt     | Filter Manager
    Hal     | Hardware Abstraction Layer
    Io      | I/O Manager
    Ke      | Kernel Core
    Mm      | Memory Manager
    Nt      | Native Services (User Mode)
    Ob      | Object Manager
    Po      | PnP/Power Manager
    Ps      | Processes and Threads
    Rtl     | Run Time Library
    Se      | Security Reference Monitor
    Wmi     | Windows Management Instrumentation
    Zw      | Kernel Mode Wrappers for Nt*

    [NTxxx vs Zwxxx](https://msdn.microsoft.com/en-us/library/ff559860(VS.85).aspx)

    wrappers:
    Csq     | Cancel-Safe IRP Queue
  
  - concepts
    - Paged pool and Nonpaged pool 
      - user space
        all physical memory pages can be paged out to a disk file as needed
      
      - system space
        - paged pool 
          can be paged out to a disk file as needed
        - nonpaged pool
          can never be paged out to a disk file

    - user mode and kernel mode
      - user mode
        - The process provides the application with a private virtual address space and a private handle table
        - application runs in isolation
        - application's virtual address space is private, one application cannot alter data that belongs to another
        - the virtual address space of a user-mode application is limited

      - kernel mode 
        - All code running shares a single virtual address space
        - kernel-mode driver is not isolated from os or other driver
        - kernel-mode driver accidentally writes to the wrong virtual address, data belongs to os or driver will be damaged
        - kernel-mode driver crashes, the entire operating system crashes.

    - Device objects and device stacks
      - A device object is an instance of a DEVICE_OBJECT structure
      - Each device node in the PnP device tree has an ordered list of device objects associated with a driver
      - ordered list of device objects, along with their associated drivers, is called the device stack for the device node.

    - IRQL(Interrupt Request Lever)[IRQ_thread.doc]
       
      - PASSIVE_LEVEL             
        - None                         
        - DriverEntry, AddDevice, Reinitialize, Unload routines, most dispatch routines, driver-created threads, worker-thread callbacks
        - can be suspended

      - APC_LEVEL             
        - APC_LEVEL interrupts            
        - dispatch routines 
        - cannot be suspended

      - DISPATCH_LEVEL   
        - DISPATCH_LEVEL and APC_LEVEL interrupts  
        - StartIo, AdapterControl, AdapterListControl, ControllerControl, IoTimer, Cancel (while holding the cancel spin lock), DpcForIsr, CustomTimerDpc, CustomDpc routines
        - cannot be suspended
      
      - DIRQL
        - All interrupts at IRQL<= DIRQL of driver's interrupt object. a higher DIRQL value can occur, along with clock and power failure interrupts.
        - InterruptService, SynchCritSection routines.
        - cannot be suspended

      - APC_LEVEL and PASSIVE_LEVEL
        - a process executing at APC_LEVEL cannot get APC interrupts
        - both imply a thread context 
        - both imply the code can be paged out
        - threads scheduled by system runs bellow APC_LEVEL and systme schduler runs in DISPATCH_LEVEL

    - Device Extensions
      - why
        - Device driver execute in an arbitrary thread context,
        - A device extension is each driver's primary place to 
          - maintain device state
          - all other device-specific data the driver needs.

      - what 
        - Maintain device state information.
        - Provide storage for any kernel-defined objects or other system resources, such as spin locks, used by the driver.
        - Hold any data the driver must have resident and in system space to carry out its I/O operations.

      - how
        - Every driver that has an ISR must provide storage for a pointer to a set of kernel-defined interrupt objects
        - most device drivers store this pointer in a device extension

      - when
        - when it creates a device object, each driver defines the contents and structure of its own device extensions.

      - The I/O manager's IoCreateDevice and IoCreateDeviceSecure routines 
          allocate memory for the device object and extension from the __nonpaged memory pool__.

    - I/O Transfer Types
      - Buffered I/O operates on a copy of the user's data.
      - Direct I/O directly accesses the user's data through memory descriptor lists (MDLs) and kernel-mode pointers.
      - Neither buffered nor direct I/O-called "neither I/O" or METHOD_NEITHER-accesses the user's data 
        - a security risk, I/O manager cannot validate the input and output buffer lengths, thus leaving the driver
          open to attack.
        - through user-mode pointers.

    - Buffer Descriptions for I/O Control Codes
      - METHOD_BUFFERED :Irp->AssociatedIrp.SystemBuffer
        - represents both the input buffer and the output buffer that are specified in calls to DeviceIoControl and IoBuildDeviceIoControlRequest. The driver transfers data out of, and then into, this buffer.
        - buffer size is specified by Parameters.DeviceIoControl.InputBufferLength or Parameters.DeviceIoControl.OutputBufferLength
      
      - METHOD_IN_DIRECT or METHOD_OUT_DIRECT 
        - supply a pointer to a buffer at Irp->AssociatedIrp.SystemBuffer

          buffer size is specified by __Parameters.DeviceIoControl.InputBufferLength__

        - supply a pointer to an MDL at Irp->MdlAddress
          - METHOD_IN_DIRECT: MDL describes an input buffer, and specifying METHOD_IN_DIRECT ensures that the executing thread has read-access to the buffer.

          - METHOD_OUT_DIRECT: MDL describes an output buffer, and specifying METHOD_OUT_DIRECT ensures that the executing thread has write-access to the buffer.

          For both, __Parameters.DeviceIoControl.OutputBufferLength__ specifies buffer size described by the MDL.

    - using remove locks
      - what 
        - provide a way to track the number of outstanding I/O operations on a device
        - to determine when it is safe to detach and delete a driver's device object

      - when
        - ensure that the driver's DispatchPnP routine will not complete an IRP_MN_REMOVE_DEVICE request while the 
          lock is held (for example, while another driver routine is accessing the device).

        - To count the number of reasons why the driver should not delete its device object, and to set an event 
          when that count goes to zero.

      - how 
        - a driver should allocate an IO_REMOVE_LOCK structure in its device extension
        - call IoInitializeRemoveLock
        - call IoAcquireRemoveLock each time it __starts__ an I/O operation, increments the count
        - call IoReleaseRemoveLock each time it __finishes__ an I/O operation, decrements the count
        - call IoAcquireRemoveLock when it passes out a reference to its code (for timers, DPCs, callbacks, and so on)
        - call IoReleaseRemoveLock when the event has returned
        - dispatch code for IRP_MN_REMOVE_DEVICE, the driver must acquire the lock once more and then 
          call IoReleaseRemoveLockAndWait, it returns after all outstanding acquisitions of the lock have been released
        - To allow queued I/O operations to complete, each driver should call IoReleaseRemoveLockAndWait after it passes 
          the IRP_MN_REMOVE_DEVICE request to the next-lower driver, and before it releases memory, calls IoDetachDevice, or calls IoDeleteDevice.

      - note
        - calls IoReleaseRemoveLockAndWait, it is ready to be removed and cannot perform I/O operations   
        - calls IoInitializeRemoveLock to re-initialize the remove lock

    - [driver to driver communication](http://www.osronline.com/article.cfm?id=24)
      - IoGetDeviceObjectPointer 

      - IoRegisterPlugPlayNotification

      - Callbacks
        ExCreateCallback

    - driver files
      - %SystemRoot%\Driver Cache\i386\drivers.cab
      - %SystemRoot%\Driver Cache\i386\service_pack.cab
      - .inf files under %windir%inf
      - .sys files under %SystemRoot%\System32\Drivers
      - Support DLLs under %SystemRoot%\System32

    - common routines
      - DriverEntry

      - AddDevice

      - DispatchXXX
        - OpenClose

      - Cleanup and close
        - app call CloseHandle 
        - IO manager decrease handle count 
        - handle counts==0 --> IO manager calls Cleanup request
        - in response to the cleanup request, driver cancles all outstanding I/O request for the file object
          (outstanding references might still exist on the file object, such as those caused by a pending IRP)
        - object's reference count == 0, all I/O completes --> IO manager send close request to driver 
        
      - Unload

    - get device object
      - IoGetDeviceObjectPointer:
        works by sending an IRP_MJ_CREATE.
        ```
        # when calling it Access vailation in RtlEqualUnicodeString


      - [IoGetDeviceObjectByName](https://www.osronline.com/showthread.cfm?link=166794)
        - undocumented
          ```
          extern POBJECT_TYPE* IoDriverObjectType; 

          POBJECT_TYPE ObGetObjectType(PVOID Object); 
          
          POBJECT_TYPE TypeObjectType = ObGetObjectType(*IoDriverObjectType);

          ObReferenceObjectByName("\ObjectTypes\TypeName", TypeObjectType, ...);
          ```

    - [target application](https://msdn.microsoft.com/en-us/library/windows/desktop/dn481241(v=vs.85).aspx)

    - [reboot or not](https://msdn.microsoft.com/en-us/library/windows/hardware/dn653568(v=vs.85).aspx)

    - [Driver-Driver and Driver-application communication](https://blogs.msdn.microsoft.com/iliast/2007/10/06/driver-driver-and-driver-application-communication/)



  - hook SSDT
    - call procedure
      ```                 ntdll
      ReadFile()  ----> NtReadFile
      kernel32.dll      KiFastSysytemCall                         ntoskrnl.exe
                        SYSENTER  --------------------------> KiSystermService()
                                             ntoskrnl.exe       SSDT
                      ntfs.sys <----------->I/O manager  <--  NtReadFile() 
                      disk.sys <----------->
                        |
                      disk

      .foreach /ps 1 /pS 1 ( offset {dd /c 1 nt!KiServiceTable L poi(nt!KeServiceDescriptorTable+10)}){ .printf "%y\n", ( offset >>> 4) + nt!KiServiceTable }

      dd SharedUserData!SystemCallStub
      7ffe0300  772d64f0 772d64f4 00000000 00000000

      uf 772d64f0 
      ntdll!KiFastSystemCall:
      772d64f0 8bd4            mov     edx,esp
      772d64f2 0f34            sysenter
      772d64f4 c3              ret
      ```

    - disable write protect
      - CR0
        clear CR0.WP
      - MDL(Memory Descriptor List)
        map ssdt memory to our own mdl and change the permission

    - hook ssdt
      - get the function index need to be hooked
        index = function addr + 1b 
      - write new function address to the index in ssdt

    - in our new function
      - get the info we want
      - call orignal function
  
    - Unhook ssdt
      - mov original function address to the ssdt

    - pragma
      alloc_text limitations are as follows:
        - It is applicable only to functions declared with C linkage 
        - It cannot be used inside a function.
        - It must be used after the function has been declared, but before the function has been defined.
      ```
      #pragma alloc_text(PAGE, Initialization)
      #pragma alloc_text(INIT, InitializationDiscard)
      ```

    - DeviceControl
      - handle IRQ

    - PatchGuard
      - SSDT (System Service Descriptor Table)
      - GDT (Global Descriptor Table)
      - IDT (Interrupt Descriptor Table)
      - System images (ntoskrnl.exe, ndis.sys, hal.dll)
      - Processor MSRs (syscall)

- [64-bit application](https://msdn.microsoft.com/en-us/library/hb5z4sxd.aspx)
  ```
  Inline ASM is not supported for x64. Use MASM or compiler intrinsics (x64 Intrinsics).
  intrin.h __lidt
  ```

  - pcr prcb
    - prcb  processor control block 
      ```
      !prcb
      0: kd> !prcb
        PRCB for Processor 0 at 81b7fd20:
        Current IRQL -- 28
        Threads--  Current 81b89280 Next 842c2a90 Idle 81b89280
        Processor Index 0 Number (0, 0) GroupSetMember 1
        Interrupt Count -- 00007e3a
        Times -- Dpc    000000bf Interrupt 0000004a 
                Kernel 00002b67 User      000000d4 
      ```

    - Processor Control Region (PCR)
      ```
      !pcr
      0: kd> !pcr
        KPCR for Processor 0 at 81b7fc00:
            Major 1 Minor 1
          NtTib.ExceptionList: 81b7c32c
              NtTib.StackBase: 00000000
            NtTib.StackLimit: 00000000
          NtTib.SubSystemTib: 801b1000
                NtTib.Version: 000368d7
            NtTib.UserPointer: 00000001
                NtTib.SelfTib: 00000000

                      SelfPcr: 81b7fc00
                        Prcb: 81b7fd20
                        Irql: 0000001f
                          IRR: 00000000
                          IDR: ffffffff
                InterruptMode: 00000000
                          IDT: 817b7400
                          GDT: 817b7000
                          TSS: 801b1000

                CurrentThread: 81b89280
                  NextThread: 842c2a90
                  IdleThread: 81b89280

                    DpcQueue: 
      ```

# kernel
  - CreateFile and NtCreateFile

# terms
  - MUI(Multilingual User Interface)(https://msdn.microsoft.com/en-us/library/windows/desktop/dd317706(v=vs.85).aspx)
    - provides users a localized user interface for globalized applications and user interface language resource management in the Windows operating system
    -  separate the storage of localizable resources from application source code
