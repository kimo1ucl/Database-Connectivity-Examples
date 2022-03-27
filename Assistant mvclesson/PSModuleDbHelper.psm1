
Function Invoke-SetupDatabase(){
    $env:VAR_server = "localhost"
    $env:VAR_user = "kimo1"
    $env:VAR_pw = "secret"
    $env:VAR_db = "test" 
    
    $sqlcommand = "DROP TABLE IF EXISTS sports" 
    
    $token = Get-Token($sqlcommand)
    Invoke-SqlCommand -CommandToken $token
    
    $sqlcommand = @"
    CREATE TABLE sports(
    id int NOT NULL PRIMARY KEY AUTO_INCREMENT ,
    category varchar(50),
    name varchar(50),
    id_msg varchar(50),
    category_msg varchar(50),
    name_msg varchar(50)
    )ENGINE=InnoDB DEFAULT CHARSET=utf8;
"@
    $token = Get-Token($sqlcommand)
    Invoke-SqlCommand -CommandToken $token

    $sqlcommand = @"
    INSERT INTO sports (category, name, id_msg, category_msg, name_msg)
    VALUES
        ('category A','name A','id_msg A','category_msg A','name_msg A'),
        ('category B','name B','id_msg B','category_msg B','name_msg B');   
"@
    $token = Get-Token($sqlcommand)
    Invoke-SqlCommand -CommandToken $token
}
