<?php
// Database configuration
ini_set('display_errors', 1);
ini_set('display_startup_errors', 1);
error_reporting(E_ALL);

include 'config.php';

// Start the session to check if the user is logged in
session_start();

// Check if the user is logged in
if (!isset($_SESSION['employeeID'])) {
    http_response_code(401); // Unauthorized
    echo json_encode(["error" => "User not logged in."]);
    exit;
}

// Ensure that the request method is GET
if ($_SERVER['REQUEST_METHOD'] != 'GET') {
    http_response_code(405); // Method Not Allowed
    echo json_encode(["error" => "Method Not Allowed"]);
    exit;
}

// Get the churnThreshold from the query parameter
$churnThreshold = isset($_GET['churnThreshold']) ? (float) $_GET['churnThreshold'] : 0.0;

// Validate the churnThreshold
if ($churnThreshold < 0 || $churnThreshold > 1) {
    http_response_code(400); // Bad Request
    echo json_encode(["error" => "Invalid churnThreshold. It must be between 0 and 1."]);
    exit;
}
// Query to fetch the required data
$query = "
    SELECT 
        CONCAT(c.FirstName, ' ', c.LastName) AS name,
        cp.ChurnProbability AS churn,
        TIMESTAMPDIFF(YEAR, c.DateJoined, CURRENT_TIMESTAMP) AS tenure,
        r.OverallSatisfaction AS satisfaction,
        rg.RegionName AS location,
        TIMESTAMPDIFF(YEAR, c.DateOfBirth, CURDATE()) AS ageGroup,
        GROUP_CONCAT(DISTINCT cat.AccountTypeName ORDER BY cat.AccountTypeName) AS service
    FROM 
        churnguard_customers c
    JOIN 
        churnguard_churn_prediction cp ON c.CustomerID = cp.CustomerID
    JOIN 
        churnguard_customer_reviews r ON c.CustomerID = r.CustomerID
    JOIN 
        churnguard_regions rg ON c.RegionID = rg.RegionID
    JOIN 
        churnguard_customer_accounts ca ON c.CustomerID = ca.CustomerID
    JOIN 
        churnguard_account_types cat ON ca.AccountTypeID = cat.AccountTypeID
    WHERE 
        cp.ChurnProbability > ?
    GROUP BY 
        c.CustomerID, cp.ChurnProbability, r.OverallSatisfaction, rg.RegionName;
";

// Execute the query
// $result = $conn->query($query);
// Prepare the statement
$stmt = $conn->prepare($query);
if (!$stmt) {
    http_response_code(500); // Internal Server Error
    echo json_encode(["error" => "Database query failed."]);
    exit;
}

// Bind the threshold parameter and execute
$stmt->bind_param("d", $churnThreshold);
$stmt->execute();
$result = $stmt->get_result();

$data = [];
if ($result) {
    while ($row = $result->fetch_assoc()) {
        $data[] = [
            "name" => $row["name"],
            "satisfaction" => (float) $row["satisfaction"],
            "tenure" => (int) $row["tenure"],
            "churn" => (float) $row["churn"],
            "service" => $row["service"],
            "ageGroup" => $row["ageGroup"],
            "location" => $row["location"]
        ];
    }
}

// Close the database connection
$conn->close();

// Return the JSON response
header('Content-Type: application/json');
echo json_encode($data);
?>
