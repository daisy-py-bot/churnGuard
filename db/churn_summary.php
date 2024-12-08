<?php
// display errors
ini_set('display_errors', 1);
ini_set('display_startup_errors', 1);
error_reporting(E_ALL);


include 'config.php';

// Start the session to check if the user is logged in
session_start();


// Check if the user is logged in (optional for user verification)
if (!isset($_SESSION['employeeID'])) {
    http_response_code(401); // Unauthorized
    echo json_encode(["error" => "User not logged in."]);
    exit;
}

// Ensure that the request method is GET
if ($_SERVER['REQUEST_METHOD'] == 'GET') {
    // Query to calculate churn rate per month
    $query = "SELECT 
                YEAR(churnDate) AS year,
                MONTH(churnDate) AS month,
                COUNT(DISTINCT customerID) AS churned_customers
              FROM churnguard_customer_churns
              WHERE status = 'churned'
              GROUP BY YEAR(churnDate), MONTH(churnDate)
              ORDER BY year, month";

    $result = $conn->query($query);

    if ($result->num_rows > 0) {
        $churn_data = [];
        while ($row = $result->fetch_assoc()) {
            // Store each month's churned customers count
            $churn_data[] = [
                'month' => $row['month'],
                'churned_customers' => $row['churned_customers']
            ];
        }

        // Format the data to match the chart structure
        $months = [];
        $churned_customers = [];
        for ($i = 1; $i <= 12; $i++) {
            $months[] = date('M', strtotime("2024-$i-01")); // Month names (Jan, Feb, etc.)
            $churned_customers[] = 0; // Default value to zero for each month
        }

        // Fill the churned_customers data
        foreach ($churn_data as $data) {
            $churned_customers[$data['month'] - 1] = $data['churned_customers'];
        }

        // Send response as JSON
        echo json_encode([
            'months' => $months,
            'churned_customers' => $churned_customers
        ]);
    } else {
        echo json_encode(["error" => "No data found"]);
    }
} else {
    http_response_code(405); // Method Not Allowed
    echo json_encode(["error" => "Invalid request method."]);
}

$conn->close();
?>
