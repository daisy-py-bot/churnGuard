<?php
// Display errors for debugging
ini_set('display_errors', 1);
ini_set('display_startup_errors', 1);
error_reporting(E_ALL);

include '../db/config.php';
session_start();

// Check if the user is logged in
if (!isset($_SESSION['employeeID'])) {
    echo json_encode(["error" => "User is not logged in.", 'redirect' => '../view/login.html']);
    exit();
}

// Ensure the request method is POST
if ($_SERVER['REQUEST_METHOD'] !== 'POST') {
    echo json_encode(["error" => "Invalid request method. Only POST is allowed."]);
    exit();
}

// Validate and sanitize input
$complaintID = isset($_POST['complaintID']) ? intval($_POST['complaintID']) : null;
$resolvedDate = date('Y-m-d'); // Current date

if (empty($complaintID)) {
    echo json_encode(["success" => false, "message" => "Complaint ID is required."]);
    exit();
}

// Check if the complaint is already resolved
$checkSql = "SELECT ResolvedStatus FROM churnguard_customer_complaints WHERE ComplaintID = ?";
$checkStmt = $conn->prepare($checkSql);
$checkStmt->bind_param("i", $complaintID);
$checkStmt->execute();
$checkResult = $checkStmt->get_result();

if ($checkResult->num_rows > 0) {
    $row = $checkResult->fetch_assoc();
    if ($row['ResolvedStatus'] === 'Resolved') {
        echo json_encode(["success" => false, "message" => "This issue is already resolved."]);
        $checkStmt->close();
        $conn->close();
        exit();
    }
} else {
    echo json_encode(["success" => false, "message" => "Complaint ID not found."]);
    $checkStmt->close();
    $conn->close();
    exit();
}

// Proceed with marking the issue as resolved
$updateSql = "UPDATE churnguard_customer_complaints 
              SET ResolvedStatus = 'Resolved', ResolvedDate = ? 
              WHERE ComplaintID = ?";
$updateStmt = $conn->prepare($updateSql);
$updateStmt->bind_param("si", $resolvedDate, $complaintID);

if ($updateStmt->execute()) {
    echo json_encode(["success" => true, "message" => "Issue marked as resolved."]);
} else {
    echo json_encode(["success" => false, "message" => "Failed to update issue."]);
}

$updateStmt->close();
$checkStmt->close();
$conn->close();
?>
