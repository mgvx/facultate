<?php
include './connect.php';
$x0 = $_GET["filter"];
$sql = "SELECT * FROM cars WHERE engine='$x0'";
$result = mysqli_query($conn,$sql);
?>

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
	