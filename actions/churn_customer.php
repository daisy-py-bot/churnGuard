<?php

// include 'admin_check.php';
include '../db/config.php';

// check if the user is logged in
if (!isset($_SESSION['employeeID'])) {
    echo json_encode(["error" => "You need to be logged in to perform this action."]);
    exit();
}

// check request method
if ($_SERVER['REQUEST_METHOD'] !== 'POST') {
    echo json_encode(["error" => "Invalid request method. Only POST is allowed."]);
    exit();
}

try {
    // Get the raw POST data
    $input = json_decode(file_get_contents('php://input'), true);

    // Validate input
    if (!isset($input['customer_id']) || empty($input['customer_id'])) {
        echo json_encode(['success' => false, 'message' => 'Customer ID is required.']);
        exit;
    }
    if (!isset($input['reason']) || empty($input['reason'])) {
        echo json_encode(['success' => false, 'message' => 'Reason is required.']);
        exit;
    }

    // Sanitize input
    $customer_id = intval($input['customer_id']);
    $reason = htmlspecialchars($input['reason'], ENT_QUOTES, 'UTF-8');

    // Prepare and execute the SQL query
    $query = "INSERT INTO churnguard_customer_churns (customerID, reason) VALUES (?, ?)";
    $stmt = $conn->prepare($query);

    if ($stmt->execute([$customer_id, $reason])) {
        echo json_encode(['success' => true, 'message' => 'Customer successfully added to churned list.']);
    } else {
        echo json_encode(['success' => false, 'message' => 'Failed to add customer to churned list.']);
    }
} catch (Exception $e) {
    echo json_encode(['success' => false, 'message' => 'An error occurred: ' . $e->getMessage()]);
}




?>