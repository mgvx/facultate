<div id="header">
  <?php if(is_array($_SESSION) && array_key_exists("error", $_SESSION)) { ?>
    <p>
      Error: <?php echo $_SESSION['error'] ?>
      <?php unset($_SESSION['error'])?>
    </p>
  
  <?php } if(is_array($_SESSION) && array_key_exists("user", $_SESSION)) { ?>
    <p>
      Logged in as <?php echo $_SESSION["user"]?> <br />
      ID = <?php echo $_SESSION["user_id"]?>
    </p>
  <a href="index.php">Home</a>
  <a href="list.php">List</a>
  <a href="list_json.php">List v2</a>
  <a href="logout.php">Logout</a>
  <///?php include 'list.php'; ?>
  
  <?php } else { ?>
      <a href="login.php">Login</a>
      <a href="register.php">Register</a>
  <?php } ?>
</div>
