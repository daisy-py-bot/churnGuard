<?php

include '../db/config.php'; // Ensure this file sets up the $conn variable for the mysqli connection

if ($_SERVER['REQUEST_METHOD'] !== 'GET') {
    echo json_encode(["error" => "Invalid request method. Only GET is allowed."]);
    exit();
}

// Get the customer ID from the query string
if (!isset($_GET['customer_id']) || empty($_GET['customer_id'])) {
    echo json_encode(['success' => false, 'message' => 'Customer ID is required.']);
    exit();
}

$customer_id = intval($_GET['customer_id']);

// Fetch data from all relevant tables
$data = [];

try {
    // Fetch customer data
    $customer_query = "SELECT * FROM churnguard_customers WHERE CustomerID = $customer_id";
    $customer_result = mysqli_query($conn, $customer_query);

    if (!$customer_result || mysqli_num_rows($customer_result) === 0) {
        echo json_encode(['success' => false, 'message' => 'Customer not found.']);
        exit();
    }

    $data['customer'] = mysqli_fetch_assoc($customer_result);

    // Fetch related data from other tables
    $related_queries = [
        'accounts' => "SELECT * FROM churnguard_customer_accounts WHERE CustomerID = $customer_id",
        'churns' => "SELECT * FROM churnguard_customer_churns WHERE customerID = $customer_id",
        'transactions' => "SELECT * FROM churnguard_transactions WHERE CustomerID = $customer_id",
        'complaints' => "SELECT * FROM churnguard_customer_complaints WHERE CustomerID = $customer_id",
        'reviews' => "SELECT * FROM churnguard_customer_reviews WHERE CustomerID = $customer_id",
        'demographics' => "SELECT * FROM churnguard_customer_demographics WHERE CustomerID = $customer_id"
    ];

    foreach ($related_queries as $key => $query) {
        $result = mysqli_query($conn, $query);
        if ($result) {
            $data[$key] = mysqli_fetch_all($result, MYSQLI_ASSOC);
        } else {
            $data[$key] = [];
        }
    }

    echo json_encode(['success' => true, 'data' => $data]);
} catch (Exception $e) {
    echo json_encode(['success' => false, 'message' => 'An error occurred: ' . $e->getMessage()]);
}

?>
