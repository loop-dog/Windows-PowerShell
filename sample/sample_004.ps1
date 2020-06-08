$OutoputDir = "f:"
$OutoputDateTime = Get-Date -Format "yyyyMMdd_HHmmss"
$InitialFileName ="Execute_" + $OutoputDateTime


$DiskListName =  $InitialFileName + "_DiskList"
Get-WmiObject Win32_LogicalDisk  | Select-Object DeviceID, DriveType, FreeSpace, Size, VolumeName , VolumeSerialNumber | Where-Object { $_.DriveType -eq "3" } | Export-Csv -Encoding Default $OutoputDir\$DiskListName.csv
