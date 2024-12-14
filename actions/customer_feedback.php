<?php

include "config.php";

// Get the raw POST data (assumes application/json content type)
$data = json_decode(file_get_contents('php://input'), true);

// Validate required fields
if (empty($data['CustomerID']) || empty($data['OverallSatisfaction']) || empty($data['RecommendationLikelihood'])) {
    echo json_encode(['status' => 'error', 'message' => 'Missing required fields']);
    exit;
}

$customerID = $data['CustomerID'];
$overallSatisfaction = $data['OverallSatisfaction'];
$recommendationLikelihood = $data['RecommendationLikelihood'];
$comments = $data['comments'] ?? '';
$issues = $data['issues'] ?? [];

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

echo json_encode(['status' => 'success', 'message' => 'Feedback submitted successfully']);

$conn->close();

?>
