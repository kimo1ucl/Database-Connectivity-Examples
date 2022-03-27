<!DOCTYPE html>
<html>
  <head>
    <title>View (User Interface)</title>

  </head>
  <body>
    <!-- (A) SEARCH JAVASCRIPT -->
    <script>
    function doSearch () {
      // (A1) GET SEARCH TERM
      var form = document.getElementById("mySearch"),
          data = new FormData(form);

      // (A2) AJAX - USE HTTP:// NOT FILE://
      fetch("http://localhost/Code/mvc-php-mysql/2-controller.php", { method:"POST", "body":data })
      .then(res => res.json()).then((res) => {
        let results = document.getElementById("results");
        results.innerHTML = "";
        if (res !== null) { for (let r of res) {
          results.innerHTML += `<div>${r.id} - ${r.name}</div>`;
        }}
      });
      return false;
    }
    </script>

    <!-- (B) SEARCH FORM -->
    <form id="mySearch" onsubmit="return doSearch()">
      <input type="text" name="search" required/>
      <input type="submit" value="Search"/>
    </form>

    <!-- (C) SEARCH RESULTS -->
    <div id="results"></div>
  </body>
</html>
