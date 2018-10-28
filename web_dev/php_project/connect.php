<?php
	/// for mysqli_query
	$conn = mysqli_connect("localhost","root","mysql","data");
	
  function connect() {
    try {
	  $con = new PDO("mysql:host=localhost;dbname=data;charset=utf8mb4", "root", "mysql");
      $con->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
	  
    } catch (PDOExceptinon $pikatchu) {
      echo "Error connecting to database " . $pikachu->getMessage();
    }

    /// database exam
    $con->query("USE data");

    return $con;
  }
?>
