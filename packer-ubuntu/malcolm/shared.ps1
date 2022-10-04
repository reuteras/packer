. ../../defaults.ps1

$VM = "Malcolm"

Start-VM $VM | Out-Null

Enable-SharedFolders $VM

Add-SharedFolder $VM $SHARED_RO_NAME $SHARED_RO_PATH | Out-Null
Add-SharedFolder $VM $SHARED_RW_NAME $SHARED_RW_PATH | Out-Null

Stop-VM $VM | Out-Null