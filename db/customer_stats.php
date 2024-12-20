<?php
// display errors
ini_set('display_errors', 1);
ini_set('display_startup_errors', 1);
error_reporting(E_ALL);
include 'config.php';
// Start the session to check if the user is logged in
session_start();

// Check if the user is logged in 
if (!isset($_SESSION['employeeID'])) {
    // If the user is not logged in, return an error message
    echo json_encode(["error" => "User is not logged in.", 'redirect' => '../view/login.html']);
    exit();
}

// Check if the request method is GET
if ($_SERVER['REQUEST_METHOD'] !== 'GET') {
    // If the request method is not GET, return an error message
    echo json_encode(["error" => "Invalid request method. Only GET is allowed."]);
    exit();
}


// SQL queries to get the data
$sql_total_customers = "SELECT COUNT(*) AS total_customers FROM churnguard_customers";
$sql_total_accounts = "SELECT COUNT(*) AS total_accounts FROM churnguard_customer_accounts";
$sql_avg_age = "SELECT AVG(TIMESTAMPDIFF(YEAR, DateOfBirth, CURDATE())) AS avg_age FROM churnguard_customers";
$sql_avg_churn_rate = "SELECT AVG(ChurnProbability) AS avg_churn_rate FROM churnguard_churn_prediction";
$sql_avg_tenure = "SELECT AVG(TIMESTAMPDIFF(YEAR, DateJoined, CURDATE())) AS avg_tenure FROM churnguard_customers";
$sql_total_churned_customers = "SELECT DISTINCT COUNT(*) AS total_churned_customers FROM churnguard_customer_churns";

// count the total number of employees
$sql_total_employees = "SELECT COUNT(*) AS total_employees FROM churnguard_employees";

// Execute queries and fetch data
$total_customers_result = $conn->query($sql_total_customers);
$total_accounts_result = $conn->query($sql_total_accounts);
$avg_age_result = $conn->query($sql_avg_age);
$avg_churn_rate_result = $conn->query($sql_avg_churn_rate);
$avg_tenure_result = $conn->query($sql_avg_tenure);
$total_churned_customers_result = $conn->query($sql_total_churned_customers);

// count the total number of employees
$total_employees_result = $conn->query($sql_total_employees);

// Fetch the results
$total_customers = (int)$total_customers_result->fetch_assoc()['total_customers'];
$total_accounts = (int)$total_accounts_result->fetch_assoc()['total_accounts'];
$avg_age = (int)round($avg_age_result->fetch_assoc()['avg_age']);  // Rounded to the nearest integer
$avg_churn_rate = round($avg_churn_rate_result->fetch_assoc()['avg_churn_rate'] * 100, 2);  // Convert to percentage
$avg_tenure = (int)round($avg_tenure_result->fetch_assoc()['avg_tenure']);  // Rounded to the nearest integer
$total_churned_customers = (int)$total_churned_customers_result->fetch_assoc()['total_churned_customers'];

// Fetch the total number of employees
$total_employees = (int)$total_employees_result->fetch_assoc()['total_employees'];

// Prepare the response data
$response = array(
    'total_customers' => $total_customers,
    'total_accounts' => $total_accounts,
    'avg_age' => $avg_age,
    'avg_churn_rate' => $avg_churn_rate,
    'avg_tenure' => $avg_tenure,
    'total_employees' => $total_employees,
    'total_churned_customers' => $total_churned_customers
);

// Send the response as JSON
echo json_encode($response);

// Close the connection
$conn->close();
?>
