#https://www.c-sharpcorner.com/article/mysql-php-mvc-crud-without-framework/
[void][system.reflection.Assembly]::LoadFrom("C:\Program Files (x86)\MySQL\MySQL Connector Net 8.0.28\Assemblies\v4.8\MySql.Data.dll")
Clear-Host

Get-Module MySqlClient #-Verbose
Import-Module -Name .\PSModuleDb.psm1
Import-Module -Name .\PSModuleDbHelper.psm1
Import-Module -Name .\PSModuleAssistantRunner.psm1

[bool] $deployDb = $true
[bool] $deployWebsite = $true
[bool] $openTools = $true

Clear-Host

$sourcefoldername = "mvclessonList"
$comparefoldername= ".\source\mvclesson\mvclesson"
$filesOfInterest = @(
    './Model/sportsModel.php',
    './Model/sports.php',
    './controller/sportsController.php',
    'config.php',
    'Index.php',
    './View/list.php')
    $filesOfInterest = $null
#Invoke-Runner $sourcefoldername $comparefoldername $deployDb $deployWebsite $openTools $filesOfInterest

$sourcefoldername = "mvclessonInsert"
$comparefoldername= "mvclessonList"
$filesOfInterest = @(
    './Controller\sportsController.php',
    'View\insert.php',
    'View\list.php')
    $filesOfInterest = $null
#Invoke-Runner $sourcefoldername $comparefoldername $deployDb $deployWebsite $openTools $filesOfInterest

$sourcefoldername = "mvclessonDelete"
$comparefoldername= "mvclessonInsert"
$filesOfInterest = @(
    './Controller\sportsController.php',
    'View\list.php')
    $filesOfInterest = $null
#Invoke-Runner $sourcefoldername $comparefoldername $deployDb $deployWebsite $openTools $filesOfInterest

$sourcefoldername = "mvclessonUpdate"
$comparefoldername= "mvclessonDelete"
$filesOfInterest = @(
    './Controller\sportsController.php',
    'View\list.php')
    $filesOfInterest = $null
Invoke-Runner $sourcefoldername $comparefoldername $deployDb $deployWebsite $openTools $filesOfInterest



