
<?php
if (isset($_GET['customerID'])) {
    $customerID = $_GET['customerID'];
    // Fetch customer details from the database using the customerID
    // Use $customerID to query the database and display customer information
} else {
    echo "Customer ID is missing!";
}
?>
