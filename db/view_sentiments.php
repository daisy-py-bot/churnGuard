<?php

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
        MONTHNAME(CreatedAt) AS month,
        SUM(CASE WHEN SentimentLabel = 'positive' THEN 1 ELSE 0 END) AS positive,
        SUM(CASE WHEN SentimentLabel = 'neutral' THEN 1 ELSE 0 END) AS neutral,
        SUM(CASE WHEN SentimentLabel = 'negative' THEN 1 ELSE 0 END) AS negative
    FROM churnguard_customer_reviews
    WHERE YEAR(CreatedAt) = ?
    GROUP BY MONTH(CreatedAt)
    ORDER BY MONTH(CreatedAt);
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
