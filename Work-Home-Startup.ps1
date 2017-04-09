# To use this script:
# 1) Save it to a place on your local drive. C:\Scripts for example.
# 2) Go to the startup directory: C:\Users\{YOUR USER NAME}\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup
# 3) Create a new file named "customStartup.bat", or whatever as long as it's a .bat or .cmd file type
# 4) Add the following line to that .bat or .cmd file
# 4a) powershell C:\Location\Of\This\Script.ps1
# 4b) if you have a space in a folder name, be sure to wrap it in single quotes:
# 4c) powershell 'C:\Location\Of\My Custom\Script.ps1'

$networkName = Get-NetConnectionProfile | Select-Object -ExpandProperty Name

function WorkItems() {
    # Open common applications
    Invoke-Item "C:\Program Files (x86)\Microsoft Office\Office14\OUTLOOK.EXE"
    Invoke-Item "C:\Program Files (x86)\Microsoft Visual Studio 14.0\Common7\IDE\devenv.exe"
}

function HomeItems() {
    # Open a webpage directly using the default browser
    Start-Process -FilePath "https://mail.google.com"
}

if($networkName.Contains("WorkNetwork")) {
    WorkItems
} else {
    HomeItems
}
