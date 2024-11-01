function Show-CurrentPath {
    Write-Host "Current session Path environment variables:" -ForegroundColor Cyan
    $env:Path -split ';' | ForEach-Object { Write-Host $_ -ForegroundColor Green }
}
Show-CurrentPath

$addPath = Read-Host "Please enter the directory path to add to the environment Path (e.g., C:\xampp\bin):"

# Check if Path Exist in the system
if (-Not (Test-Path -Path $addPath -PathType Container)) {
    Write-Host "'$addPath' is not a valid Path. Please input a valid path." -ForegroundColor Red
    exit
}

# Check if the Path is already assigned in the Path
if ($env:Path -split ';' -contains $addPath) {
    Write-Host "The path '$addPath' already exists in the current session's Path." -ForegroundColor Yellow
} else {
    # Modifie le Path de la session PowerShell actuelle
    $env:Path += ";$addPath"
    Write-Host "The path '$addPath' has been successfully added to the current session's Path." -ForegroundColor Green
}

# User tell the program whether he wants the option -system for all users or not
$choice = Read-Host "Do you want to add this path to the user or system Path? (enter 'user' or 'system')"

# Handle the choice
if ($choice -eq 'user') {
    $regPath = "HKCU:\Environment"
} elseif ($choice -eq 'system') {
    $regPath = "HKLM:\SYSTEM\CurrentControlSet\Control\Session Manager\Environment"
} else {
    Write-Host "Invalid choice. The script will now terminate." -ForegroundColor Red
    exit
}

# Rollback the current Path in the register
try {
    $currentRegPath = (Get-ItemProperty -Path $regPath).Path
} catch {
    Write-Host "Error retrieving the current Path from the registry: $_" -ForegroundColor Red
    exit
}

# Check if the Path has not already been added to the register
if ($currentRegPath -notlike "*$addPath*") {
    # Add the path to register
    try {
        $newRegPath = $currentRegPath + ";$addPath"
        Set-ItemProperty -Path $regPath -Name Path -Value $newRegPath
        Write-Host "The path '$addPath' has been successfully added to the system/user Path permanently." -ForegroundColor Green
    } catch {
        Write-Host "Error modifying the registry: $_" -ForegroundColor Red
    }
} else {
    Write-Host "The path '$addPath' already exists in the system/user Path." -ForegroundColor Yellow
}


$newPath = "C:\xampp\mysql\bin"
$regPath = "HKLM:\SYSTEM\CurrentControlSet\Control\Session Manager\Environment"

try {
    $currentRegPath = (Get-ItemProperty -Path $regPath).Path
    if ($currentRegPath -notlike "*$newPath*") {
        $newRegPath = $currentRegPath + ";$newPath"
        Set-ItemProperty -Path $regPath -Name Path -Value $newRegPath
        Write-Host "Successfully added the path." -ForegroundColor Green
    } else {
        Write-Host "Path already exists." -ForegroundColor Yellow
    }
} catch {
    Write-Host "Error modifying the registry: $_" -ForegroundColor Red
}


# Affiche le chemin actuel après modification
Write-Host "Updated Path after modification:" -ForegroundColor Cyan
$env:Path -split ';' | ForEach-Object { Write-Host $_ -ForegroundColor Green }
