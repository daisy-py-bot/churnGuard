<?php

// disable error reporting for production code
ini_set('display_errors', 1);
ini_set('display_startup_errors', 1);
error_reporting(E_ALL);


// Include configuration file
include 'config.php';

// Start a session
session_start();

// check if user is logged in
if (!isset($_SESSION['employeeID'])) {
    // If the user is not logged in, return an error message
    echo json_encode(["error" => "User is not logged in.", 'redirect' => '../view/login.html']);
    exit();
}

// check rquest method
if ($_SERVER['REQUEST_METHOD'] === 'GET') {

    // SQL query to fetch customer information
    $sql = "
        SELECT DISTINCT
            c.CustomerID,
            CONCAT(c.FirstName, ' ', c.LastName) AS CustomerName,
            c.Email,
            c.PhoneNumber,
            c.Address,
            r.RegionName,
            r.Country,
            a.AccountNumber,
            a.account_status,
            cc.status as churn_status, 
            at.AccountTypeName,
            a.Balance,
            cp.ChurnProbability,
            cp.RiskLevel
        FROM churnguard_customers c
        LEFT JOIN churnguard_regions r ON c.RegionID = r.RegionID
        LEFT JOIN churnguard_customer_accounts a ON c.CustomerID = a.CustomerID
        LEFT JOIN churnguard_account_types as at ON a.AccountTypeID = at.AccountTypeID
        LEFT JOIN churnguard_churn_prediction cp ON c.CustomerID = cp.CustomerID
        LEFT JOIN churnguard_customer_churns cc ON cc.CustomerID = c.CustomerID
        GROUP BY c.CustomerID
        ORDER BY c.CustomerID;
    ";

    $result = $conn->query($sql);

    if ($result->num_rows > 0) {
        $customers = array();

        // Fetch each row and store it in the $customers array
        while ($row = $result->fetch_assoc()) {
            $customers[] = $row;
        }

        // Return the data as JSON
        header('Content-Type: application/json');
        echo json_encode($customers);
    } 
    else {
        echo json_encode(["message" => "No customer data found."]);
    }
    }
// Close the connection
$conn->close();


?>



