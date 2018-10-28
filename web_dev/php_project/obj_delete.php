<?php
include './connect.php';
$x0 = $_GET["id"];
$sql = "DELETE FROM cars WHERE id='$x0'";
mysqli_query($conn,$sql);
header("Location: ../index.php");
?>