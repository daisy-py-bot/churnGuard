

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
    // header("HTTP/1.1 401 Unauthorized");
    echo json_encode(["error" => "User is not logged in.", 'redirect' => '../view/login.html']);
    exit();
}

// Check if the request method is GET
if ($_SERVER['REQUEST_METHOD'] !== 'GET') {
    // If the request method is not GET, return an error message
    // header("HTTP/1.1 405 Method Not Allowed");
    echo json_encode(["error" => "Invalid request method. Only GET is allowed."]);
    exit();
}


// SQL query to fetch complaints
$query = "
    SELECT 
        cc.ComplaintID AS id,
        CONCAT(c.FirstName, ' ', c.LastName) AS name,
        cc.ComplaintDate,
        cc.ResolvedDate,
        bi.IssueDescription AS description,
        cc.Priority AS priority,
        CASE cc.ResolvedStatus 
            WHEN 'Resolved' THEN true
            ELSE false
        END AS resolved
    FROM 
        churnguard_customer_complaints cc
    JOIN 
        churnguard_bank_issues bi ON cc.IssueID = bi.IssueID
    JOIN 
        churnguard_customers c ON cc.CustomerID = c.CustomerID;
";

// Execute query
$result = $conn->query($query);

// Check for errors
if (!$result) {
    echo json_encode(["error" => "Query failed: " . $conn->error]);
    $conn->close();
    exit;
}

// Fetch data and format as JSON
$complaints = [];
while ($row = $result->fetch_assoc()) {
    $complaints[] = [
        "id" => $row["id"],
        "name" => $row["name"],
        "ComplaintDate" => $row["ComplaintDate"],
        "description" => $row["description"],
        "priority" => $row["priority"],
        "resolved" => (bool)$row["resolved"],
        "ResolvedDate" =>$row["ResolvedDate"]
    ];
}

// Close connection
$conn->close();

// Output data as JSON
header('Content-Type: application/json');
echo json_encode($complaints);
