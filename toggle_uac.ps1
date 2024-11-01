param ([string] $parameter1)

#This command verify the key of register `EnableLUA`, controling activation and desactivation of UAC
if($parameter1)
{
    Write-Host("the UAC has been disactivated")
    Set-ItemProperty -Path "HKLM:\Software\Microsoft\Windows\CurrentVersion\Policies\System" -Name "EnableLUA" -Value 0
}
else
{
    Write-Host("the UAC has been reactivated")
    Set-ItemProperty -Path "HKLM:\Software\Microsoft\Windows\CurrentVersion\Policies\System" -Name "EnableLUA" -Value 1
}
