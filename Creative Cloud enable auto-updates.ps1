$PSScriptRoot = Split-Path -Parent -Path $MyInvocation.MyCommand.Definition
$Source = "$PSScriptRoot\com.adobe.acc.container.default.prefs"
$Destination = "$env:LOCALAPPDATA\Adobe\OOBE\"

Copy-Item -Path $Source -Destination $Destination –Recurse -Force