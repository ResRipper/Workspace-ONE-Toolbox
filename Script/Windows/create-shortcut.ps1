# Create Application shortcut for all users
#   - Modified from answer on Stack Overflow
#     https://stackoverflow.com/questions/9701840/how-to-create-a-shortcut-using-powershell

$name = "Application"
$exe_path = "$env:ProgramFiles\...\Application.exe"
$icon = "$env:ProgramFiles\...\Application.ico"

if (Test-Path $exe_path) {
    $WshShell = New-Object -ComObject WScript.Shell
    $Shortcut = $WshShell.CreateShortcut("$env:ProgramData\Microsoft\Windows\Start Menu\Programs\$name.lnk")
    $Shortcut.TargetPath = $exe_path
    $Shortcut.IconLocation = $icon
    $Shortcut.Save()
}
else {
    exit 1
}