<?php
/// disable error reporting for production code
ini_set('display_errors', 1);
ini_set('display_startup_errors', 1);
error_reporting(E_ALL);


// Include configuration file
include 'config.php';

// check user role***

// check rquest method
if ($_SERVER['REQUEST_METHOD'] === 'GET') {

    $query = "SELECT EmployeeID, CONCAT(FirstName, ' ', LastName) as name, email, role, createdAt, lastLogin FROM churnguard_employees";
    $result = $conn->query($query);

    if ($result) {
        $users = [];
        while ($row = $result->fetch_assoc()) {
            $users[] = $row;
        }

        echo json_encode(['success' => true, 'data' => $users]);
    } else {
        echo json_encode(['success' => false, 'message' => 'Error fetching users: ' . $conn->error]);
    }

    // Close the connection
$conn->close();
} 
else{
    echo json_encode(['success' => false, 'message' => 'Unauthorized']);
}


