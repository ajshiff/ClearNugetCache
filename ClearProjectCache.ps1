# Package to Clear
$targetPackage = $args[0]
# Path to the .csproj that needs to be packed
$dotnetPackTargetDir = $args[1]
# The Local folder to output the .nupkg to.
$dotnetPackOutputDir = $args[2]

# Default `global-packages` location for NuGet
$pathToItem = "~/.nuget/packages/$targetPackage"

# Run `dotnet pack` if a target dir and an output dir are provided
if ($dotnetPackTargetDir -And($dotnetPackOutputDir) )
{
    if (Test-Path $dotnetPackTargetDir)
    {
        Write-Output "Starting Rebuild for $dotnetPackTargetDir"
        Write-Host "dotnet" -ForegroundColor yellow -NoNewLine; Write-Host " pack $dotnetPackTargetDir -c Release" -NoNewLine; 
        Write-Host " --output " -ForegroundColor darkgray -NoNewLine; Write-Host $dotnetPackOutputDir;
        dotnet pack $dotnetPackTargetDir --output $dotnetPackOutputDir -c Release
        clear
        Write-Output "Starting Rebuild for $dotnetPackTargetDir"
        Write-Host "dotnet" -ForegroundColor yellow -NoNewLine; Write-Host " pack $dotnetPackTargetDir -c Release" -NoNewLine; 
        Write-Host " --output " -ForegroundColor darkgray -NoNewLine; Write-Host $dotnetPackOutputDir;
        Write-Output "Rebuild Complete..."
    }
    else
    {
        Write-Output "$dotnetPackTargetDir doesn't exist. Continuing..."
    }
}
else
{
    Write-Output "Skipping dotnet pack process"
}

# If Refit folder exists in NuGet `global-cache`, delete it.
if (Test-Path $pathToItem)
{
    Write-Output "Attempting to Remove $pathToItem"
    Remove-Item $pathToItem -recurse
    if (!(Test-Path $pathToItem))
    {
        Write-Output "Deletion Successful"
    }
    else
    {
        Write-Output "Deletion Failed"
    }
}
else
{
    Write-Output "$pathToItem doesn't exist. Continuing..."
}

# Run the Program Regardless
# Write-Host "dotnet" -ForegroundColor yellow -NoNewLine; Write-Output " run";
# dotnet run