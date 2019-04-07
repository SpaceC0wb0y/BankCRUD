<?php
session_start();
$id = $_SESSION['user_id'];

define('DB_SERVER', 'localhost:3306');
define('DB_USERNAME', 'root');
define('DB_PASSWORD', '');
define('DB_DATABASE', 'CIS421');
$db = mysqli_connect(DB_SERVER,DB_USERNAME,DB_PASSWORD,DB_DATABASE);

$username = "";
$email    = "";
$errors = array();

// REGISTER USER
if (isset($_POST['reg_user'])) {
    // receive all input values from the form
    $username = mysqli_real_escape_string($db, $_POST['username']);
    $email = mysqli_real_escape_string($db, $_POST['email']);
    $password_1 = mysqli_real_escape_string($db, $_POST['login']);
    $branch_id = mysqli_real_escape_string($db, $_POST['branch_id']);
    $firstname = mysqli_real_escape_string($db, $_POST['fname']);
    $lastname = mysqli_real_escape_string($db, $_POST['lname']);
    $age = mysqli_real_escape_string($db, $_POST['age']);
    $street = mysqli_real_escape_string($db, $_POST['street']);
    $city = mysqli_real_escape_string($db, $_POST['city']);
    $state = mysqli_real_escape_string($db, $_POST['state']);
    $ssn = mysqli_real_escape_string($db, $_POST['ssn']);

   
  
    // form validation: ensure that the form is correctly filled ...
    // by adding (array_push()) corresponding error unto $errors array
    if (empty($username)) { array_push($errors, "Username is required"); }
    if (empty($email)) { array_push($errors, "Email is required"); }
    if (empty($password_1)) { array_push($errors, "Password is required"); }
    
  
    // first check the database to make sure 
    // a user does not already exist with the same username and/or email
    $user_check_query = "SELECT * FROM CIS421.customer WHERE user='$username' LIMIT 1";
    $result = mysqli_query($db, $user_check_query);
    $user = mysqli_fetch_assoc($result);
    
    if ($user) { // if user exists
      if ($user['user'] === $username) {
        array_push($errors, "Username already exists");
        
      }
  
      
    }

    
  
    // Finally, register user if there are no errors in the form
    if (count($errors) == 0) {
        
        $query = "INSERT INTO CIS421.customer (ssn,user,pass,branch_id,firstname,lastname,age,street,city,state_1) VALUES ('$ssn','$username','$password_1','$branch_id','$firstname','$lastname','$age','$street','$city','$state')";
        
        mysqli_query($db, $query);
        //$query = "SELECT * FROM CIS421.customer WHERE user='$username'";
        //$test= mysqli_fetch_assoc($result);
        //echo $test['user'];
        //echo "WE HERE";
        $_SESSION['username'] = $username;
        $_SESSION['success'] = "You are now logged in";
        //echo "DONE!!!";
        header('location: index.php');

        
    }
  }
?>



<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Document</title>
<!--<link href="//maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css"> -->
<link href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
<link href="style.css" rel="stylesheet" id="bootstrap-css">
<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.8.1/css/all.css" integrity="sha384-50oBUHEmvpQ+1lW4y57PTFmhCaXp0ML5d60M1M7uH2+nqUivzIebhndOJK28anvf" crossorigin="anonymous">
<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>
<script src="app.js"></script>
</head>
<body>
<div class="wrapper fadeInDown">
  <div id="formContent">
    <!-- Tabs Titles -->

    <!-- Icon -->
    <div class="fadeIn first">
      <i class="fas fa-user"></i>
    <span>Register</span>
    </div>

    <!-- Login Form -->
    <form action="" method="POST">
      <select name="tr_type" class="btn dropdown-toggle selectclass">
        <option value="Deposit">Deposit</option>
        <option value="Withdraw">Withdraw</option>
      </select>
      <input type="number" id="username" min="0" class="fadeIn second" name="tr_amount" placeholder="Login">
      <input type="text" class="fadeIn third" name="tr_acc_no" id="login" placeholder="password">
      

      
      
   
      <input type="submit" class="fadeIn fourth" value=" Submit " name="reg_user">
    </form>

   

    

  </div>
</div>
</body>
</html>

<?php

?>