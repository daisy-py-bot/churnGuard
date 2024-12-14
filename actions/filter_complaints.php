<?php
// display errors
ini_set('display_errors', 1);
ini_set('display_startup_errors', 1);
error_reporting(E_ALL);

include '../db/config.php';

// Start the session to check if the user is logged in
session_start();

// Check if the user is logged in 
if (!isset($_SESSION['employeeID'])) {
    echo json_encode(["error" => "User is not logged in."]);
    exit();
}

// Get the raw POST data (filters)
$data = json_decode(file_get_contents("php://input"), true);

// Check if the data is valid
if (!$data) {
    echo json_encode(["success" => false, "message" => "Invalid filter data"]);
    exit();
}

// Prepare the base query
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
        churnguard_customers c ON cc.CustomerID = c.CustomerID
    WHERE 1=1
";

// Apply the resolution filter if provided
if ($data['resolution']) {
    if ($data['resolution'] === 'resolved') {
        $query .= " AND cc.ResolvedStatus = 'Resolved'";
    } else {
        $query .= " AND cc.ResolvedStatus = 'Not Resolved'";
    }
}

// Apply the priority filter if 'priority' is provided in the filter
if ($data['priority'] && in_array($data['priority'], ['High', 'Medium', 'Low'])) {
    $query .= " AND cc.Priority = '" . $conn->real_escape_string($data['priority']) . "'";
}

$orderClauses = [];

// Apply Date Sort
if ($data['dateSort']) {
    $dateOrder = $data['dateSort'] === 'recent' ? 'DESC' : 'ASC';
    $orderClauses[] = "cc.ComplaintDate " . $dateOrder;
}


// Combine all ORDER BY clauses
if (!empty($orderClauses)) {
    $query .= " ORDER BY " . implode(", ", $orderClauses);
}

// Execute the query
$result = $conn->query($query);

if ($result) {
    // Fetch and format data
    $complaints = [];
    while ($row = $result->fetch_assoc()) {
        $complaints[] = [
            "id" => $row["id"],
            "name" => $row["name"],
            "ComplaintDate" => $row["ComplaintDate"],
            "description" => $row["description"],
            "priority" => $row["priority"],
            "resolved" => (bool)$row["resolved"],
            "ResolvedDate" => $row["ResolvedDate"]
        ];
    }

    echo json_encode(["success" => true, "data" => $complaints]);
} else {
    echo json_encode(["success" => false, "message" => "Failed to fetch complaints"]);
}

// Close the MySQL connection
$conn->close();
?>
