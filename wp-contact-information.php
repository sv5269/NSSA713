<?php

//get the form elements and store them in variables

$name=$_POST["name"];

$email=$_POST["email"];

?>

<?php

//establish connection

$con = mysqli_connect("10.1.1.7","wpuser","wppass","wpdb");

//on connection failure, throw an error

if(!$con) {

die('Could not connect: '.mysql_error());

} 

?>

<?php 

$sql="INSERT INTO `wpdb`.`wp_contact` ( `name` , `email_id` ) VALUES ( '$name','$email')"; 

mysqli_query($con,$sql); 

?>
<?php

//Redirects to the specified page

header("Location: http://10.1.1.6/success/"); 

?>
