<!DOCTYPE html>
<html>
  <head>
    <title>Not really a good design</title>
  </head>
  <body>
    <!-- (A) SEARCH FORM -->
    <form method="post">
      <input type="text" name="search" required/>
      <input type="submit" value="Search"/>
    </form>

    <!-- (B) SEARCH + SHOW RESULTS -->
    <div id="results"><?php
      if (isset($_POST["search"])) {
        // (B1) DATABASE SETTINGS - CHANGE TO YOUR OWN!
        define("DB_HOST", "localhost");
        define("DB_NAME", "test");
        define("DB_CHARSET", "utf8");
        define("DB_USER", "root");
        define("DB_PASSWORD", "");

        // (B2) CONNECT TO DATABASE
        $pdo = new PDO(
          "mysql:host=".DB_HOST.";dbname=".DB_NAME.";charset=".DB_CHARSET,
          DB_USER, DB_PASSWORD, [
            PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION,
            PDO::ATTR_DEFAULT_FETCH_MODE => PDO::FETCH_ASSOC
          ]
        );

        // (B3) SEARCH
        $stmt = $pdo->prepare("SELECT * FROM `users` WHERE `name` LIKE ?");
        $stmt->execute(["%{$_POST["search"]}%"]);
        $results = $stmt->fetchAll();

        // (B4) OUTPUT
        if (count($results)>0) { foreach ($results as $r) {
          echo "<div>{$r["id"]} - {$r["name"]}</div>";
        }}
      }
    ?></div>
  </body>
</html>
