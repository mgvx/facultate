<?php
session_start();
if(!array_key_exists("user", $_SESSION)) {
	$_SESSION["error"] = "Please login first!";
	header("Location: ./index.php");
	return ;
}
include './connect.php';
$sql = "SELECT * FROM cars";
$result = mysqli_query($conn,$sql);
?>
<!DOCTYPE html>
<html>
<head>
  <///?php include './layouts/scripts.php'; ?>
  
	<script>
	function filter_objects(filter) {
		console.log(filter)
		xmlhttp = new XMLHttpRequest();
		xmlhttp.onreadystatechange = function() {
			if (this.readyState == 4 && this.status == 200) {
				document.getElementById("txtHint").innerHTML = this.responseText;
			}
		};
        xmlhttp.open("GET","obj_filter.php?filter="+filter,true);
        xmlhttp.send();
    }
	</script>
  
  
</head>
<body>
  <h1>LIST</h1>
  <?php include './home.php'; ?>
  <br/>
	<h3>Car Table</h3>
	<a href="obj_add.php">Add Car</a>
	<form method="post" action="">
	<table>
		<tr>
			<td>Name</td>
			<td>Engine</td>
			<td>Power</td>
			<td>CRUD</td>
		</tr>
		<?php while($row = mysqli_fetch_array($result)) { ?>
			<tr>
				<td><?php echo $row["name"]; ?></td>
				<td><?php echo $row["engine"]; ?></td>
				<td><?php echo $row["power"]; ?></td>
				<td>
					<a href="obj_edit.php?id=<?php echo $row["id"]; ?>">Edit</a>
					<a href="obj_delete.php?id=<?php echo $row["id"]; ?>">Del</a>
				</td>
			</tr>
		<?php } ?>
	</table>
	</form>
  
  <h3>Filter:</h3>
	<select onchange="filter_objects(this.value)">
		<?php
		$sql = "SELECT distinct engine FROM cars";
		$result = mysqli_query($conn,$sql);
		while($row = mysqli_fetch_array($result)) {
		?>
		<option value="<?php echo $row["engine"]; ?>"> <?php echo $row["engine"]; ?></option>
		<?php } ?>
	</select>
	<div id="txtHint">
		Filtered OBJs will be listed here...
	</div>
  
  
</body>
</html>
