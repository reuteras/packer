Invoke-WebRequest https://raw.githubusercontent.com/fireeye/flare-vm/master/install.ps1 -OutFile C:\install.ps1
Unblock-File C:\install.ps1
C:\install.ps1 -password vagrant
