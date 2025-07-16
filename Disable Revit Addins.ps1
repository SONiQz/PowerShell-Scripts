$FilesList = @()
$AddinPath = "\Autodesk\Revit\Addins"
$FullPath = "$env:ProgramData$AddinPath"
$appName = "Autodesk Revit 2023"

$installed = Get-ItemProperty HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall\* |
             Where-Object { $_.DisplayName -like "*$appName*" }

if ($installed) {
    Write-Output "$appName is installed. Taking action..."
    Get-ChildItem -Path $FullPath -Recurse -File | Where-Object { 
                                                                    $_.Name -like "bluebeamAddin*.addin" -or
                                                                    $_.Name -like "autodesk.lightinganalysis.addin" -or
                                                                    $_.Name -like "autodesk.solaranalysis.addin" -or
                                                                    $_.Name -like "autodesk.totalcarbon.analysis.addin"
                                                                 
                                                                } | ForEach-Object {
                                                                    $filesList += $($_.FullName)
                                                                }
                                                                
} else {
    Write-Output "$appName is not installed."
}

$FilesList | ForEach-Object {
    if ($_ -match "addin$") {
        $newName = $_ + ".disabled"
        Rename-Item -Path $_ -NewName $newName
    }
}