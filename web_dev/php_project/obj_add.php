<?php
session_start();
if(!array_key_exists("user", $_SESSION)) {
	$_SESSION["error"] = "Please login first!";
	header("Location: ./index.php");
	return ;
}

if(count($_POST)>0) {
	include './connect.php';
	$x1 = $_POST["name"];
	$x2 = $_POST["engine"];
	$x3 = $_POST["power"];
	$sql = "INSERT INTO cars (name, engine, power) VALUES ('$x1','$x2','$x3')";
	mysqli_query($conn,$sql);
	header("Location: ../index.php");
	///echo $sql;
}
?>
<html>
<head>
</head>
<body>
<h2>ADD CAR</h2>
<form method="post" action="">
	<label>name</label>
    <input type="text" name="name" />
    <br/>
	<label>engine</label>
    <input type="text" name="engine" />
    <br/>
	<label>power</label>
    <input type="text" name="power" />
    <br/>
    <input type="submit" value="Submit" />
</form>
</body></html>