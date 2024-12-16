<?php
ini_set('display_errors', 1);
ini_set('display_startup_errors', 1);
error_reporting(E_ALL);


include "../db/config.php";


// Validate required fields
if (empty($_POST['CustomerID']) || empty($_POST['OverallSatisfaction']) || empty($_POST['RecommendationLikelihood'])) {
    echo json_encode(['status' => 'error', 'message' => 'Missing required fields']);
    exit;
}


$customerID = $_POST['CustomerID'] ?? null;
$overallSatisfaction = $_POST['OverallSatisfaction'] ?? null;
$recommendationLikelihood = $_POST['RecommendationLikelihood'] ?? null;
$comments = $_POST['feedbackMessage'] ?? '';
$issues = $_POST['issues'] ?? [];


// Calculate sentiment label based on recommendation likelihood
$sentimentLabel = 'Neutral'; // Default
if ($recommendationLikelihood <= 2) {
    $sentimentLabel = 'Negative';
} elseif ($recommendationLikelihood > 3) {
    $sentimentLabel = 'Positive';
}

// Calculate churn prediction probability and risk level
$churnProbability = ($overallSatisfaction * $recommendationLikelihood) / ($overallSatisfaction * $recommendationLikelihood * 60);
$riskLevel = 'Low'; // Default
if ($churnProbability > 0.6) {
    $riskLevel = 'High';
} elseif ($churnProbability >= 0.4 && $churnProbability <= 0.5) {
    $riskLevel = 'Medium';
}

// Prepare and execute the insertion into the `churnguard_customer_reviews` table
$stmt = $conn->prepare("INSERT INTO churnguard_customer_reviews (CustomerID, OverallSatisfaction, RecommendationLikelihood, comments, SentimentLabel, CreatedAt) VALUES (?, ?, ?, ?, ?, NOW())");
$stmt->bind_param("iiiss", $customerID, $overallSatisfaction, $recommendationLikelihood, $comments, $sentimentLabel);
if (!$stmt->execute()) {
    echo json_encode(['status' => 'error', 'message' => 'Failed to insert review']);
    exit;
}

// Insert churn prediction into `churnguard_churn_prediction` table
$stmt = $conn->prepare("INSERT INTO churnguard_churn_prediction (CustomerID, ChurnProbability, RiskLevel, PredictionDate) VALUES (?, ?, ?, NOW())");
$stmt->bind_param("ids", $customerID, $churnProbability, $riskLevel);
if (!$stmt->execute()) {
    echo json_encode(['status' => 'error', 'message' => 'Failed to insert churn prediction']);
    exit;
}

// Insert customer issues into `churnguard_customer_complaints`
foreach ($issues as $issue) {
    // Handle "Other" issue if present
    $otherIssueDescription = '';
    if ($issue == 'Other' && isset($data['otherIssueDescription'])) {
        $otherIssueDescription = $data['otherIssueDescription'];
    }

    // Prepare and insert each issue
    $stmt = $conn->prepare("INSERT INTO churnguard_customer_complaints (CustomerID, IssueID, ComplaintDate, ResolvedStatus, Priority) VALUES (?, ?, NOW(), 'Unresolved', 'Low')");
    $stmt->bind_param("ii", $customerID, $issueID); // You would need a way to map issues to IssueIDs (e.g., look up in a predefined table)
    
    if (!$stmt->execute()) {
        echo json_encode(['status' => 'error', 'message' => 'Failed to insert complaint']);
        exit;
    }
}

// echo json_encode(['status' => 'success', 'message' => 'Feedback submitted successfully']);
// display the feedback message
echo "<h1>Feedback submitted successfully</h1>";

$conn->close();

?>
