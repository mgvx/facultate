<?php
include './connect.php';
$x0 = $_GET["id"];
if(count($_POST)>0) {	
	$x1 = $_POST["name"];
	$x2 = $_POST["engine"];
	$x3 = $_POST["power"];
	$sql = "UPDATE cars set name='$x1', engine='$x2', power='$x3' WHERE id='$x0'";
	mysqli_query($conn,$sql);
	header("Location: ../index.php");
	///echo $sql;
}
$select_query = "SELECT * FROM cars WHERE id='$x0'";
$result = mysqli_query($conn,$select_query);
$row = mysqli_fetch_array($result);
?>
<html>
<head>
</head>
<body>
<h2>EDIT CAR</h2>
<form method="post" action="">
	<label>name</label>
    <input type="text" name="name" value="<?php echo $row['name']; ?>"/>
    <br/>
	<label>engine</label>
    <input type="text" name="engine" value="<?php echo $row['engine']; ?>"/>
    <br/>
	<label>power</label>
    <input type="text" name="power" value="<?php echo $row['power']; ?>"/>
    <br/>
    <input type="submit" value="Submit" />
</form>
</body></html>