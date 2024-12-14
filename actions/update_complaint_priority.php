<?php
// Enable error reporting for debugging
ini_set('display_errors', 1);
ini_set('display_startup_errors', 1);
error_reporting(E_ALL);

include '../db/config.php';
session_start();

// Ensure the user is logged in
if (!isset($_SESSION['employeeID'])) {
    echo json_encode(["success" => false, "message" => "User is not logged in."]);
    exit();
}

// Check for POST request
if ($_SERVER['REQUEST_METHOD'] !== 'POST') {
    echo json_encode(["success" => false, "message" => "Invalid request method."]);
    exit();
}



// Get the raw POST data (JSON)
$data = json_decode(file_get_contents("php://input"), true);

// Check if the data is valid
if (!$data) {
    echo json_encode(["success" => false, "message" => "Invalid JSON data"]);
    exit;
}

// Retrieve the complaintID and newPriority from the decoded JSON
$complaintID = $data['complaintID'] ?? null; // Use null coalescing operator to avoid undefined index error
$newPriority = $data['newPriority'] ?? null; // Same as above

// Validate input
if (empty($complaintID) || empty($newPriority)) {
    echo json_encode(["success" => false, "message" => "Complaint ID and priority are required."]);
    exit();
}

// Validate priority value
$validPriorities = ['Low', 'Medium', 'High'];
if (!in_array($newPriority, $validPriorities)) {
    echo json_encode(["success" => false, "message" => "Invalid priority value."]);
    exit();
}

// Update the database
$sql = "UPDATE churnguard_customer_complaints 
        SET Priority = ? 
        WHERE ComplaintID = ?";

$stmt = $conn->prepare($sql);
$stmt->bind_param("si", $newPriority, $complaintID);

if ($stmt->execute()) {
    echo json_encode(["success" => true, "message" => "Priority updated successfully."]);
} else {
    echo json_encode(["success" => false, "message" => "Failed to update priority."]);
}

$stmt->close();
$conn->close();
?>
