# Go to the SQL execution directory (required to run invoke-sqlcommand
pushd SQLSERVER:\ 

# Variable to hold the error message from SQL
$SqlError 

# Database name to connect to
$sqlDatabase = '{SQLServerName}' 

# Folder location of the SQL scripts to run
$scriptFolder = '{Location of the script folder}'

$scripts = Get-ChildItem $scriptFolder -Filter "*.sql"

foreach($script in $scripts)
{
    invoke-sqlcmd -inputfile $scriptFolder\$script -serverinstance $sqlDatabase -ErrorAction SilentlyContinue -ErrorVariable SqlError

    if($SqlError)
    {
        Write-Host "Failed running:" $script -ForegroundColor Red

        # Stop executing any more scripts if one fails
        break 
    }
    else
    {
        Write-Host "Successfully ran:" $script -ForegroundColor Green
    }

}

popd

if($SqlError)
{
    Write-Host "`nExecution failed!" -ForegroundColor Red
    
    # Print out the error returned from SQL
    Write-Host $SqlError[0].ToString() -ForegroundColor Red 
}