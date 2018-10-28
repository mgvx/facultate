<?php
if(count($_POST)>0) {
  session_start();

  $user = $_POST['user'];
  $password = $_POST['password'];

  include './connect.php';
  $con = connect();
  $stmt = $con->prepare("SELECT * FROM Users WHERE user='$user' and password='$password'");
  $stmt->execute();
  if($stmt->rowCount() > 0) {
    $uObj = $stmt->fetch(PDO::FETCH_OBJ);
    $_SESSION["user"] = $uObj->user;
    $_SESSION["user_id"] = $uObj->id;
    unset($_SESSION["error"]);
  }
  else {
    $_SESSION["error"] = "User and/or password are incorrect";
  }
  header("Location: ../index.php");
}
?>
<html>
<head>
  <///?php include './layouts/scripts.php'; ?>
</head>
<body>
  <form action="" method="post">
    <label>Username</label>
    <input type="text" name="user" />
    <br/>
    <label>Password</label>
    <input type="text" name="password" />
    <br/>
    <input type="submit" value="Login" />
  </form>
</body>
</html>
