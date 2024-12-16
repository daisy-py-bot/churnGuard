<?php
ini_set('display_errors', 1);
ini_set('display_startup_errors', 1);
error_reporting(E_ALL);

// Include database configuration
include '../db/config.php'; 
session_start();

// check if user is logged in and they are an admin
if (!isset($_SESSION['employeeID']) || $_SESSION['role'] !== 'Admin') {
    // If the user is not logged in, return an error message
    echo json_encode(["error" => "User is not logged in or does not have permission to view this page.", 'redirect' => '../view/login.html']);
    exit();
}

// Get customer_id from query parameters
if (!isset($_GET['customer_id']) || empty($_GET['customer_id'])) {
    die("Customer ID is required.");
}

$customer_id = intval($_GET['customer_id']);



// Fetch data from all relevant tables
$data = [];

try {
    // Fetch customer data
    $customer_query = "SELECT * FROM churnguard_customers WHERE CustomerID = $customer_id";
    $customer_result = mysqli_query($conn, $customer_query);

    if (!$customer_result || mysqli_num_rows($customer_result) === 0) {
        die("Customer not found.");
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
} catch (Exception $e) {
    die("An error occurred: " . $e->getMessage());
}

?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Customer Details</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            line-height: 1.6;
            margin: 20px;
        }
        .container {
            max-width: 900px;
            margin: auto;
        }
        h1, h2 {
            text-align: center;
        }
        .card {
            border: 1px solid #ddd;
            padding: 20px;
            margin-bottom: 20px;
            border-radius: 8px;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin: 20px 0;
        }
        table th, table td {
            border: 1px solid #ddd;
            padding: 8px;
            text-align: left;
        }
        table th {
            background-color: #f4f4f4;
        }
    </style>
</head>
<body>
<div class="container">
    <h1>Customer Details</h1>

    <div class="card">
        <h2>Basic Information</h2>
        <p><strong>First Name:</strong> <?= $data['customer']['FirstName'] ?></p>
        <p><strong>Last Name:</strong> <?= $data['customer']['LastName'] ?></p>
        <p><strong>Email:</strong> <?= $data['customer']['Email'] ?></p>
        <p><strong>Phone Number:</strong> <?= $data['customer']['PhoneNumber'] ?></p>
    </div>

    <div class="card">
        <h2>Accounts</h2>
        <?php if (!empty($data['accounts'])): ?>
            <table>
                <thead>
                <tr>
                    <th>Account ID</th>
                    <th>Type</th>
                    <th>Balance</th>
                    <th>Status</th>
                </tr>
                </thead>
                <tbody>
                <?php foreach ($data['accounts'] as $account): ?>
                    <tr>
                        <td><?= $account['AccountID'] ?></td>
                        <td><?= $account['AccountTypeID'] ?></td>
                        <td><?= $account['Balance'] ?></td>
                        <td><?= $account['account_status'] ?></td>
                    </tr>
                <?php endforeach; ?>
                </tbody>
            </table>
        <?php else: ?>
            <p>No accounts found.</p>
        <?php endif; ?>
    </div>

    <div class="card">
        <h2>Churns</h2>
        <?php if (!empty($data['churns'])): ?>
            <table>
                <thead>
                <tr>
                    <th>Churn ID</th>
                    <th>Churn Date</th>
                    <th>Reason</th>
                </tr>
                </thead>
                <tbody>
                <?php foreach ($data['churns'] as $churn): ?>
                    <tr>
                        <td><?= isset($churn['churnID']) ? $churn['churnID'] : 'N/A' ?></td>
                        <td><?= isset($churn['churnDate']) ? $churn['churnDate'] : 'N/A' ?></td>
                        <td><?= isset($churn['reason']) ? $churn['reason'] : 'N/A' ?></td>
                    </tr>
                <?php endforeach; ?>
                </tbody>
            </table>
        <?php else: ?>
            <p>No churn data found.</p>
        <?php endif; ?>
    </div>

    <div class="card">
        <h2>Transactions</h2>
        <?php if (!empty($data['transactions'])): ?>
            <table>
                <thead>
                <tr>
                    <th>Transaction ID</th>
                    <th>Amount</th>
                    <th>Date</th>
                    <th>Status</th>
                </tr>
                </thead>
                <tbody>
                <?php foreach ($data['transactions'] as $transaction): ?>
                    <tr>
                        <td><?= isset($transaction['TransactionID']) ? $transaction['TransactionID'] : 'N/A' ?></td>
                        <td><?= isset($transaction['TransactionAmount']) ? $transaction['TransactionAmount'] : 'N/A' ?></td>
                        <td><?= isset($transaction['TransactionDate']) ? $transaction['TransactionDate'] : 'N/A' ?></td>
                        <td><?= isset($transaction['TransactionType']) ? $transaction['TransactionType'] : 'N/A' ?></td>
                    </tr>
                <?php endforeach; ?>
                </tbody>
            </table>
        <?php else: ?>
            <p>No transactions found.</p>
        <?php endif; ?>
    </div>

    <div class="card">
        <h2>Complaints</h2>
        <?php if (!empty($data['complaints'])): ?>
            <table>
                <thead>
                <tr>
                    <th>Complaint ID</th>
                    <th>Complaint Date</th>
                    <th>Resolved status</th>
                </tr>
                </thead>
                <tbody>
                <?php foreach ($data['complaints'] as $complaint): ?>
                    <tr>
                        <td><?= isset($complaint['ComplaintID']) ? $complaint['ComplaintID'] : 'N/A' ?></td>
                        <td><?= isset($complaint['ComplaintDate']) ? $complaint['ComplaintDate'] : 'N/A' ?></td>
                        <td><?= isset($complaint['ResolvedStatus']) ? $complaint['ResolvedStatus'] : 'N/A' ?></td>
                    </tr>
                <?php endforeach; ?>
                </tbody>
            </table>
        <?php else: ?>
            <p>No complaints found.</p>
        <?php endif; ?>
    </div>

    <div class="card">
        <h2>Reviews</h2>
        <?php if (!empty($data['reviews'])): ?>
            <table>
                <thead>
                <tr>
                    <th>Review ID</th>
                    <th>Review Date</th>
                    <th>Rating (/5)</th>
                    <th>Comments</th>
                </tr>
                </thead>
                <tbody>
                <?php foreach ($data['reviews'] as $review): ?>
                    <tr>
                        <td><?= isset($review['ReviewID']) ? $review['ReviewID'] : 'N/A' ?></td>
                        <td><?= isset($review['CreatedAt']) ? $review['CreatedAt'] : 'N/A' ?></td>
                        <td><?= isset($review['OverallSatisfaction']) ? $review['OverallSatisfaction'] : 'N/A' ?></td>
                        <td><?= isset($review['comments']) ? $review['comments'] : 'N/A' ?></td>
                    </tr>
                <?php endforeach; ?>
                </tbody>
            </table>
        <?php else: ?>
            <p>No reviews found.</p>
        <?php endif; ?>
    </div>

    <div class="card">
        <h2>Demographics</h2>
        <?php if (!empty($data['demographics'])): ?>
            <table>
                <thead>
                <tr>
                    <th>Demographic ID</th>
                    <th>Age</th>
                    <th>Gender</th>
                    <th>Income Level</th>
                </tr>
                </thead>
                <tbody>
                <?php foreach ($data['demographics'] as $demographic): ?>
                    <tr>
                        <td><?= isset($demographic['CustomerDemographicID']) ? $demographic['CustomerDemographicID'] : 'N/A' ?></td>
                        <td><?= isset($demographic['Age']) ? $demographic['Age'] : 'N/A' ?></td>
                        <td><?= isset($demographic['Gender']) ? $demographic['Gender'] : 'N/A' ?></td>
                        <td><?= isset($demographic['IncomeLevel']) ? $demographic['IncomeLevel'] : 'N/A' ?></td>
                    </tr>
                <?php endforeach; ?>
                </tbody>
            </table>
        <?php else: ?>
            <p>No demographic data found.</p>
        <?php endif; ?>
    </div>
</div>
</body>
</html>
