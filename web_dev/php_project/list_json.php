<?php
session_start();
if(!array_key_exists("user", $_SESSION)) {
	$_SESSION["error"] = "Please login first!";
	header("Location: ./index.php");
	return ;
}
?>

<!DOCTYPE html>
<html>
<head>
  <///?php include './layouts/scripts.php'; ?>
	<script src="../scripts/jquery-3.2.1.js"></script>

  <script>
    var user = "<?php echo $_SESSION["user"] ?>";
    $(document).ready(function() {
      setInterval(function () {
        $.get("list_json_get.php", {"user": user}, function(data) {
          $("#to_be_filled").empty();
          var arr = JSON.parse(data);
          for(var i = 0; i < arr.length; ++ i) {
            $("#to_be_filled").append(createMessage(arr[i]));
          }
        });
      }, 2000);
	  
      function createMessage(obj) {
        var li = $("<li></li>");
        li.append(createItem("Sender", "sender", obj));
        li.append(createItem("Message", "text", obj));
        li.append(createItem("Receivers", "receivers", obj));
        li.append(createItem("Views", "views", obj));
		
        li.append($("<button>Delete</button>")
                    .addClass("deleteBtn")
                    .attr("id", obj.id));
        return li;
      }
	  
      function createItem(dt, dd, obj) {
        var dl = $("<dl></dl>");
        dl.append($("<dt>" + dt + "</dt>"));
        dl.append($("<dd>" + obj[dd] + "</dd>"));
        return dl;
      }
    });
	
    $(document).on('click', '.deleteBtn', function() {
      console.log("deletbnt");
      console.log($(this).attr("id"));
      $(this).parent().fadeOut();
      $.get("./functions/delete.php", {id: $(this).attr("id")}, function(data) {
          loadData();
      });
    });
  </script>
</head>
<body>
  <h1>List v2</h1>
  <?php include './home.php'; ?>
  <div id="content">
    <ol id="to_be_filled"></ol>
  </div>
</body>
</html>
