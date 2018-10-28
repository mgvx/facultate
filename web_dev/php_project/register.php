<?php
if(count($_POST)>0) {
  session_start();

  $user = $_POST['user'];
  $password = $_POST['password'];

  if(is_null($user) || empty($user)) {
    $_SESSION["error"] = "Please insert a non-empty username!";
    header("Location: ../index.php");
    return ;
  }

  if(is_null($password) || empty($password)) {
    $_SESSION["error"] = "Please insert a non-empty password!";
    header("Location: ../index.php");
    return ;
  }

  include 'connect.php';
  $con = connect();
  $stmt = $con->prepare("INSERT INTO Users(user, password) VALUES ('$user', '$password')");
  if($stmt->execute()) {
    $_SESSION["user"] = $user;
    $_SESSION["user_id"] = $con->lastInsertId();
    unset($_SESSION["error"]);
    header("Location: ../index.php");
  }
  else {
    $_SESSION["error"] = "There was an error, please insert all the fields!";
    header("Location: ../index.php");
  }
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
    <br />
    <label>Password</label>
    <input type="text" name="password" />
    <br />
    <input type="submit" value="Register" />
  </form>
</body>
</html>
