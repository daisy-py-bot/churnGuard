<?php
ini_set('display_errors', 1);
ini_set('display_startup_errors', 1);
error_reporting(E_ALL);
include 'config.php';

// Start the session to check if the user is logged in
session_start();

// // Check if the user is logged in
// if (!isset($_SESSION['employeeID'])) {
//     http_response_code(401); // Unauthorized
//     echo json_encode(["error" => "User not logged in."]);
//     exit;
// }

// Ensure that the request method is GET
if ($_SERVER['REQUEST_METHOD'] != 'GET') {
    http_response_code(405); // Method Not Allowed
    echo json_encode(["error" => "Method Not Allowed"]);
    exit;
}

// Initialize response array
$response = [
    "overall" => 0,
    "byAccountType" => [],
    "byLocation" => []
];

// Query for overall churn prediction
$overallQuery = "SELECT AVG(ChurnProbability) AS averageChurnProbability FROM churnguard_churn_prediction";
$result = $conn->query($overallQuery);
if ($result && $row = $result->fetch_assoc()) {
    $response["overall"] = round($row["averageChurnProbability"], 2) * 100;
}

// Query for churn prediction by account type
$accountTypeQuery = "
    SELECT at.AccountTypeName, AVG(cp.ChurnProbability) AS averageChurnProbability
    FROM churnguard_customer_accounts ca
    JOIN churnguard_account_types at ON ca.AccountTypeID = at.AccountTypeID
    JOIN churnguard_churn_prediction cp ON ca.CustomerID = cp.CustomerID
    GROUP BY at.AccountTypeName
";
$result = $conn->query($accountTypeQuery);
if ($result) {
    while ($row = $result->fetch_assoc()) {
        $response["byAccountType"][$row["AccountTypeName"]] = round($row["averageChurnProbability"], 2) * 100;
    }
}

// Query for churn prediction by location
$locationQuery = "
    SELECT r.Country, AVG(cp.ChurnProbability) AS averageChurnProbability
    FROM churnguard_regions r
    JOIN churnguard_customers c ON r.RegionID = c.RegionID
    JOIN churnguard_churn_prediction cp ON c.CustomerID = cp.CustomerID
    GROUP BY r.Country
";
$result = $conn->query($locationQuery);
if ($result) {
    while ($row = $result->fetch_assoc()) {
        $response["byLocation"][$row["Country"]] = round($row["averageChurnProbability"], 2) * 100;
    }
}

// Close the database connection
$conn->close();

// Return the JSON response
header('Content-Type: application/json');
echo json_encode($response);
?>
