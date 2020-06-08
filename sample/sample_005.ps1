$OutoputDir = "d:"
$OutoputDateTime = Get-Date -Format "yyyyMMdd_HHmmss"
$InitialFileName ="Execute_" + $OutoputDateTime


$DiskListName =  $InitialFileName + "_DiskList"
Get-WmiObject Win32_LogicalDisk  | Select-Object DeviceID, DriveType, FreeSpace, Size, VolumeName , VolumeSerialNumber | Where-Object { $_.DriveType -eq "3" } | Export-Csv -Encoding Default $OutoputDir\$DiskListName.csv


$VolList= Get-WmiObject Win32_LogicalDisk  | Select-Object DeviceID, DriveType, FreeSpace, Size, VolumeName , VolumeSerialNumber | Where-Object { $_.DriveType -eq "3" -and ($_.DeviceID -ne "C:" -and $_.VolumeName -ne "WDC WD20EZRX-00DC0B0" ) }


if($VolList -eq $null)
{
   Write-Host '出力対象のドライブがありません。';
}
else
{
   foreach($Vol in $VolList){
       $TargetDrive = $Vol.DeviceID
       $TargetVolumeName = $Vol.VolumeName
       $FileListNames = $InitialFileName + "_" + $TargetVolumeName

       Write-Output $TargetDrive
       Write-Output $TargetVolumeName
       Write-Output $FileListNames

       Get-ChildItem $TargetDrive -Recurse | Select-Object Name, FullName, Length, LastWriteTime | Export-Csv -Encoding Default $OutoputDir\$FileListNames.csv
   }
}