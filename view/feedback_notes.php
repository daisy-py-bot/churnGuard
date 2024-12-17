<?php
    // Start session
    session_start();

    // Check if user is logged in
    if(!isset($_SESSION['employeeID'])){
        header('Location: ../index.php');
    }
?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Feedback and Notes Page</title>
    <link rel="stylesheet" href="../assets/css/global.css">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <link rel="stylesheet" href="../assets/css/feedback_notes.css">
</head>
<body>
        <!-- Sidebar -->
    <div class="sidebar">
        <h3 class="text-center py-4" style="color:gold;"><i>ChurnGuard</i> </h3>
        <a href="dashboard.php"><i class="fas fa-tachometer-alt"></i><span class="nav-text">Dashboard</span></a>
        <a href="customer_overview.php"><i class="fas fa-users"></i><span class="nav-text">Customer Overview</span></a>
        <a href="report_page.php"><i class="fas fa-chart-line"></i><span class="nav-text">Reports</span></a>
        <a href="#feedback_notes.php"><i class="fas fa-comment-alt"></i><span class="nav-text">Customer Feedback</span></a>

        <!-- show the users link of the user role is admin -->
        <?php if($_SESSION['role'] == 'Admin') { ?>
            <a href="admin/users.php"><i class="fas fa-users-cog"></i><span class="nav-text">Users</span></a>
        <?php } ?>

        <a href="../index.php"><i class="fas fa-home"></i><span class="nav-text">Home</span></a>
        <a href="../actions/logout.php"><i class="fas fa-sign-out-alt"></i><span class="nav-text">Logout</span></a>
    </div>



    <div class="main-content">
        <section class="feedback-page">
            <header>
                <h1>Customer Feedback</h1>
                <!-- Filters and Sorting -->
                <div class="search-filter-bar">
        
                    <!-- Resolution Filter -->
                    <select class="filter" id="resolution-filter">
                        <option value="">All Resolutions</option>
                        <option value="resolved">Resolved</option>
                        <option value="not-resolved">Not Resolved</option>
                    </select>
        
                    <!-- Sort by Date -->
                    <select class="filter" id="date-sort">
                        <option value="recent">Most Recent</option>
                        <option value="oldest">Oldest</option>
                    </select>
        
                    <!-- Sort by Priority -->
                    <select class="filter" id="priority-sort">
                        <option value="Priority">Priority</option>
                        <option value="High">High</option>
                        <option value="Medium">Medium</option>
                        <option value="Low">Low</option>
                    </select>
        
                    <!-- Apply Filters Button -->
                    <button class="btn btn-primary" onclick="applyFeedbackFilters()">Apply Filters</button>
                </div>
            </header>
        
            <!-- Feedback Table -->
            <table class="feedback-table">
                <thead>
                    <tr>
                        <th>Customer ID</th>
                        <th>Name</th>
                        <th>Date Received</th>
                        <th>Description</th>
                        <th>Priority</th>
                        <th>Resolution</th>
                        <th>Resolved Date</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody id="feedback-table-body">
                    <!-- Feedback rows will be dynamically populated -->
                </tbody>
            </table>
            
            <div id="description-modal" class="modal">
                <div class="modal-content">
                    <span class="close" onclick="closeModal()">&times;</span>
                    <p id="description-text"></p>
                </div>
            </div>
            
        </section>
        
        
    </div>
    <script src="../assets/js/global.js"></script>
    <script src="../assets/js/feedback_notes.js"></script>
</body>

</html>
