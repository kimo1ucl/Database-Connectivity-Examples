<# 
    .NOTES
    Created on: March 2022 
    Created by: kimo1@Ulc.dk 
    .SYNOPSIS
    Runs the operations set
    .DESCRiPTION
    https://techexpert.tips/powershell/powershell-query-mysql-server/
    .INPUTS

#>

Function Invoke-Runner
{
    [CmdletBinding()]
    Param
    (
        [string] $sourcefoldername,   
        [string] $comparefoldername,
        [bool] $deployDb,
        [bool] $deployWebsite,
        [bool] $openTools,
        $filesOfInterest
    )
    BEGIN
    {
        $sourcefolder = ".\$sourcefoldername"
        $destinationfolder = "C:\xampp\htdocs\Code"

    }
    PROCESS
    {
        if($deploydb){  
            Invoke-SetupDatabase
        }
        if($deployWebsite){
            
            $destinationfolderexisting ="$destinationfolder\$sourcefoldername"
            Remove-Item $destinationfolderexisting -Recurse -Force -EA SilentlyContinue -Verbose
            Copy-Item -Path $sourcefolder -Destination $destinationfolder -Recurse -Force
            Write-Host "files ready in webserver $sourcefolder -> $destinationfolder"
         }
         if($openTools){
               [system.Diagnostics.Process]::Start("msedge","https://localhost/Code/$sourcefoldername/index.php")
               [system.Diagnostics.Process]::Start("code","$destinationfolder\$sourcefoldername\")
        }
        if($filesOfInterest.count -gt 0){
        
            foreach($f in $filesOfInterest){    
                
                # #compare files
                # $comparesourcefile = ".\mvclessonList\Model\sportsModel.php"
                # $comparedestinationfile = ".\mvclessonComplete\Model\sportsModel.php"
                # $filecontentdiff = Compare-Object -ReferenceObject $(Get-Content $comparesourcefile) -DifferenceObject $(Get-Content $comparedestinationfile)
                # $filecontentdiff |  Out-Gridview -Title  "$comparesourcefile vs. $comparedestinationfile"

                $comparesourcefile = ".\$sourcefoldername\$f"
                $comparedestinationfile = "$comparefoldername\$f"
                $filecontentdiff = Compare-Object -ReferenceObject $(Get-Content $comparesourcefile) -DifferenceObject $(Get-Content $comparedestinationfile)
                $filecontentdiff |  Out-Gridview -Title  "$comparesourcefile vs. $comparedestinationfile"
            }
        }
    }
    END
    {
        If ($?)
        {
            
        }
        else{
            
            throw "something happened in Invoke-SqlCommand"
        }
    }
}



