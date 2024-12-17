<?php
// display errors
ini_set('display_errors', 1);
ini_set('display_startup_errors', 1);
error_reporting(E_ALL);

include 'config.php';

// Start the session to check if the user is logged in
session_start();

// Check if the user is logged in
if (!isset($_SESSION['employeeID'])) {
    http_response_code(401); // Unauthorized
    echo json_encode(["error" => "User not logged in."]);
    exit;
}

// Ensure that the request method is GET
if ($_SERVER['REQUEST_METHOD'] != 'GET') {
    http_response_code(405); // Method Not Allowed
    echo json_encode(["error" => "Method Not Allowed"]);
    exit;
}
// Get the year from the GET parameter, or use the current year as default
$year = isset($_GET['year']) ? $_GET['year'] : date('Y');  // default to current year

// SQL query to get sentiment data by month
$query = "
SELECT 
    m.month_name AS month,
    IFNULL(SUM(CASE WHEN SentimentLabel = 'positive' THEN 1 ELSE 0 END), 0) AS positive,
    IFNULL(SUM(CASE WHEN SentimentLabel = 'neutral' THEN 1 ELSE 0 END), 0) AS neutral,
    IFNULL(SUM(CASE WHEN SentimentLabel = 'negative' THEN 1 ELSE 0 END), 0) AS negative
FROM 
    (SELECT 1 AS month_num, 'January' AS month_name UNION ALL
     SELECT 2, 'February' UNION ALL
     SELECT 3, 'March' UNION ALL
     SELECT 4, 'April' UNION ALL
     SELECT 5, 'May' UNION ALL
     SELECT 6, 'June' UNION ALL
     SELECT 7, 'July' UNION ALL
     SELECT 8, 'August' UNION ALL
     SELECT 9, 'September' UNION ALL
     SELECT 10, 'October' UNION ALL
     SELECT 11, 'November' UNION ALL
     SELECT 12, 'December') AS m
LEFT JOIN churnguard_customer_reviews r 
    ON MONTH(r.CreatedAt) = m.month_num AND YEAR(r.CreatedAt) = ?
GROUP BY m.month_num, m.month_name
ORDER BY m.month_num;
";

// Prepare and bind the statement
$stmt = $conn->prepare($query);
$stmt->bind_param("i", $year);
$stmt->execute();

// Get the result
$result = $stmt->get_result();

// Initialize arrays to store the data
$months = [];
$positive = [];
$neutral = [];
$negative = [];

// Fetch the data
while ($row = $result->fetch_assoc()) {
    $months[] = $row['month'];
    $positive[] = (int) $row['positive'];
    $neutral[] = (int) $row['neutral'];
    $negative[] = (int) $row['negative'];
}

// Prepare the response
$response = [
    "year" => $year,
    "months" => $months,
    "positive" => $positive,
    "neutral" => $neutral,
    "negative" => $negative
];

// Close the database connection
$conn->close();

// Set content type to JSON and output the response
header('Content-Type: application/json');
echo json_encode($response);

?>
