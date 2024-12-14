<?php
// Enable error reporting for debugging
ini_set('display_errors', 1);
ini_set('display_startup_errors', 1);
error_reporting(E_ALL);

// Include database connection
include '../db/config.php';

// Check if the request method is GET
if ($_SERVER['REQUEST_METHOD'] !== 'GET') {
    echo json_encode(["error" => "Invalid request method. Only GET is allowed."]);
    exit();
}

// Retrieve filter values from query string
$filters = [
    'name' => isset($_GET['name']) ? trim($_GET['name']) : '',
    'account_status' => isset($_GET['account_status']) ? trim($_GET['account_status']) : '',
    'risk' => isset($_GET['risk']) ? trim($_GET['risk']) : '',
    'region' => isset($_GET['region']) ? trim($_GET['region']) : '',
    'accountType' => isset($_GET['accountType']) ? trim($_GET['accountType']) : ''
];

try {
    // Base query with necessary joins
    $query = "SELECT 
                c.CustomerID,
                CONCAT(c.FirstName, ' ', c.LastName) AS CustomerName,
                c.Email,
                r.RegionName,
                r.Country,
                cp.RiskLevel,
                a.AccountTypeName,
                ca.account_status
            FROM churnguard_customers c
            LEFT JOIN churnguard_regions r ON c.RegionID = r.RegionID
            LEFT JOIN churnguard_churn_prediction cp ON c.CustomerID = cp.CustomerID
            LEFT JOIN churnguard_customer_accounts ca ON c.CustomerID = ca.CustomerID
            LEFT JOIN churnguard_account_types a ON ca.AccountTypeID = a.AccountTypeID
            WHERE 1=1";

    // Prepare conditions and values dynamically
    $conditions = [];
    $values = [];
    $types = '';

    // Add filters to the query
    if (!empty($filters['name'])) {
        $conditions[] = "CONCAT(LOWER(c.FirstName), ' ', LOWER(c.LastName)) LIKE ?";
        $values[] = '%' . strtolower($filters['name']) . '%';
        $types .= 's';
    }

    if (!empty($filters['account_status'])) {
        $conditions[] = "LOWER(ca.RiskLevel) = ?";
        $values[] = strtolower($filters['account_status']);
        $types .= 's';
    }

    if (!empty($filters['risk'])) {
        $conditions[] = "LOWER(cp.RiskLevel) = ?";
        $values[] = strtolower($filters['risk']);
        $types .= 's';
    }

    if (!empty($filters['region'])) {
        $conditions[] = "LOWER(r.RegionName) = ?";
        $values[] = strtolower($filters['region']);
        $types .= 's';
    }

    if (!empty($filters['accountType'])) {
        $conditions[] = "LOWER(a.AccountTypeName) = ?";
        $values[] = strtolower($filters['accountType']);
        $types .= 's';
    }

    // Append conditions to query
    if (!empty($conditions)) {
        $query .= " AND " . implode(" AND ", $conditions);
    }

    // Prepare the query
    $stmt = $conn->prepare($query);
    if (!$stmt) {
        throw new Exception("Failed to prepare statement: " . $conn->error);
    }

    // Bind parameters dynamically
    if (!empty($values)) {
        $stmt->bind_param($types, ...$values);
    }

    // Execute the query
    $stmt->execute();
    $result = $stmt->get_result();

    // Fetch results as an associative array
    $customers = $result->fetch_all(MYSQLI_ASSOC);

    // Return JSON response
    header('Content-Type: application/json');
    echo json_encode($customers);

} catch (Exception $e) {
    http_response_code(500);
    echo json_encode(['error' => 'Failed to fetch customer data', 'details' => $e->getMessage()]);
}