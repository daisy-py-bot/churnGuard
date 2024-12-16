<?php
/// disable error reporting for production code
ini_set('display_errors', 1);
ini_set('display_startup_errors', 1);
error_reporting(E_ALL);


// Include configuration file
include 'config.php';

// Start a session
session_start();

// check if user is logged in and they are an admin (role = admin)
if (!isset($_SESSION['employeeID']) || $_SESSION['role'] !== 'Admin') {
    // If the user is not logged in, return an error message
    echo json_encode(["error" => "Unauthorized"]);
    exit();
}


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


