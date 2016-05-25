﻿$movieExtensions = ".avi", ".mpg", ".mpeg", ".vob", ".mp4", ".m2ts", ".mov", ".3gp", ".mkv"

$origin = "F:\Transmission"
$destination = "F:\Raspberry_Movies"

$files = New-Object System.Collections.ArrayList

$downloadedFiles = Get-ChildItem($origin)

foreach($fileorFolder in $downloadedFiles)
{   
    $subDirectory = @(Get-ChildItem($fileorFolder.FullName))
    
    foreach($subFile in $subDirectory)
    {                
        if($movieExtensions.Contains($subFile.Extension))
        {
            $files.Add($subFile)  > $null
        }
    }            
}

if($files.Count -eq 0)
{
    Write-Host No files to move... -ForegroundColor Cyan
#    exit
}

foreach($file in $files)
{    
    Write-Host $file

    $result = test-path -path "$destination\*" -include $file
    if ($result -like "False")
    {
        Write-Host Moving: $file -ForegroundColor Yellow
        #Copy-Item -Path $file.FullName -Destination $destination
        Move-Item -Path $file.FullName -Destination $destination
        Write-Host Moved: $file -ForegroundColor Green
    }
    else
    {        
        Write-Host The file: $file is already in $destination -ForegroundColor Gray
        Remove-Item $file.FullName
        Write-Host $file has been removed from $origin -ForegroundColor Red
    }

}