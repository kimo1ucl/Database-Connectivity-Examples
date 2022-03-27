<# 
    .NOTES
    Created on: February 2022 
    Created by: kimo1@Ulc.dk 
    Filename: PSModuleDb 
    .SYNOPSIS
    From a composit of a connectionstring and a query, execute a MySql command
    .DESCRiPTION
    https://techexpert.tips/powershell/powershell-query-mysql-server/
    .INPUTS
    $CommandToken = <$Connectionstring>:<$SqlCommand>
    You can pipe Invoke-SqlCommand 
#>
Function Invoke-SqlCommand
{
    [CmdletBinding()]
    Param
    (
        [Parameter(ValueFromPipeline)]
        [string[]]$CommandToken
    )
    BEGIN
    {
        if([string]::IsNullOrWhiteSpace($CommandToken))
        {
            throw "the token must not be null, empty or whitespace: '$CommandToken'"
        }
        $token = $CommandToken -split ":"
        $connectionstring =  $token[0]
        $sqlquery = $token[1]

        $checkforwhites = $connectionstring -split(" ")
        if($checkforwhites.Length -gt 1)
        {
            throw "the token must not contain whitespace: '$CommandToken'"
        }

        $con = New-Object MySql.Data.MySqlClient.MySqlConnection($connectionstring)
        $con.Open()
        $sql = New-Object MySql.Data.MySqlClient.MySqlCommand
        $sql.Connection = $con
        $sql.CommandText = $sqlquery
    }
    PROCESS
    {
        $reader = $sql.ExecuteReader()
    }
    END
    {
        If ($?)
        {
            while($reader.Read())
            { 
                $reader.GetString(0) 
            }
            Write-Host $sqlquery
        }
        else{
            $con.Close()
            throw "something happened in Invoke-SqlCommand"
        }
        $reader.Close()
        $con.Close()
    }
} #END Function Test-ScriptBlock

Function Get-Token($sqlcommand)
{
    $connectionstring = [string]::Format("server=$env:VAR_server;port=3306;uid=$env:VAR_user;pwd=$env:VAR_pw;database=$env:VAR_db")
    $input = [string]::Format("{0}:{1}",$connectionstring,$sqlcommand)
    return $input
}
