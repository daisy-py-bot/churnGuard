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
    echo json_encode(["error" => "User is not logged in.", 'redirect' => '../view/login.html']);
    exit();
}

// Check if the request method is DELETE
if ($_SERVER['REQUEST_METHOD'] !== 'DELETE') {
    echo json_encode(["error" => "Invalid request method. Only DELETE is allowed."]);
    exit();
}

// Check if complaintID is provided as a URL parameter
$complaintID = $_GET['complaintID'] ?? null;

if ($complaintID) {
    // MySQL query to delete the complaint from the database
    $query = "DELETE FROM churnguard_customer_complaints WHERE complaintID = ?";

    // Prepare the statement
    if ($stmt = $conn->prepare($query)) {
        // Bind the complaintID parameter
        $stmt->bind_param("i", $complaintID);

        // Execute the query
        if ($stmt->execute()) {
            echo json_encode(['success' => true, 'message' => 'Complaint successfully removed.']);
        } else {
            echo json_encode(['success' => false, 'message' => 'Failed to remove complaint.']);
        }

        // Close the prepared statement
        $stmt->close();
    } else {
        echo json_encode(['success' => false, 'message' => 'Failed to prepare SQL statement.']);
    }
} else {
    echo json_encode(['success' => false, 'message' => 'Complaint ID is missing.']);
}

// Close the MySQL connection
$conn->close();
?>
