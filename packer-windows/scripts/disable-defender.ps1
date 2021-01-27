Set-MpPreference -DisableRealtimeMonitoring $true
sc config WinDefend start= disabled
sc stop WinDefend
Uninstall-WindowsFeature -Name Windows-Defender

