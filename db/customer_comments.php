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

// SQL query to fetch the reviews with sentiments
$query = "SELECT c.FirstName, c.LastName, r.comments, r.SentimentLabel 
          FROM churnguard_customer_reviews r
          JOIN churnguard_customers c ON r.CustomerID = c.CustomerID";

// Execute the query
$result = $conn->query($query);

// Initialize an array to store reviews
$reviews = [];

if ($result->num_rows > 0) {
    while ($row = $result->fetch_assoc()) {
        // Add each review to the array
        $reviews[] = [
            'customer_name' => $row['FirstName'] . ' ' . $row['LastName'],
            'comment' => $row['comments'],
            'sentiment' => $row['SentimentLabel']
        ];
    }
}

// Return the reviews as JSON
echo json_encode($reviews);

// Close the database connection
$conn->close();
?>
