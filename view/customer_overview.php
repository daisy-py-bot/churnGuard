
<?php
    // Start session
    session_start();

    // Check if user is logged in
    if(!isset($_SESSION['employeeID'])){
        header('Location: ../index.php');
    }

    // get user role
    $role = $_SESSION['role'];
?>



<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Customer Overview</title>
    <link rel="stylesheet" href="../assets/css/global.css">
    <link rel="stylesheet" href="../assets/css/customer_overview.css">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css" rel="stylesheet"> 
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
</head>

<body>
     <!-- Sidebar -->
    <div class="sidebar">
        <h3 class="text-center py-4" style="color:gold;"><i>ChurnGuard</i> </h3>
        <a href="dashboard.php"><i class="fas fa-tachometer-alt"></i><span class="nav-text">Dashboard</span></a>
        <a href="#customer_overview.php"><i class="fas fa-users"></i><span class="nav-text">Customer Overview</span></a>
        <a href="report_page.php"><i class="fas fa-chart-line"></i><span class="nav-text">Reports</span></a>
        <a href="feedback_notes.php"><i class="fas fa-comment-alt"></i><span class="nav-text">Customer Feedback</span></a>

        <!-- show the users link of the user role is admin -->
        <?php if($_SESSION['role'] == 'Admin') { ?>
            <a href="admin/users.php"><i class="fas fa-users-cog"></i><span class="nav-text">Users</span></a>
        <?php } ?>

        <a href="../index.php"><i class="fas fa-home"></i><span class="nav-text">Home</span></a>
        <a href="../actions/logout.php"><i class="fas fa-sign-out-alt"></i><span class="nav-text">Logout</span></a>
    </div>



    <!-- Main Content -->
    <div class="main-content">
        <!-- embed role in a hidden div -->
        <div id="user-role" data-role="<?php echo $role; ?>" style="display: none;"></div>
        
        <div class="customer-overview">
            <header>
                <h1>Customer Overview</h1>
                <div class="search-filter-bar">
                    <!-- Search by Name -->
                    <input type="text" class="search-bar" placeholder="Search by customer name..." id="name-search">
            
                    <!-- Filter by Account Status -->
                    <select class="filter" id="status-filter">
                        <option value="">Churn Status</option>
                        <option value="active">Active</option>
                        <option value="churned">Churned</option>
                    </select>
            
                    <!-- Filter by Risk Tag -->
                    <select class="filter" id="risk-level-filter">
                        <option value="">All Risks</option>
                        <option value="low">Low Risk</option>
                        <option value="medium">Medium Risk</option>
                        <option value="high">High Risk</option>
                    </select>
            
                    <!-- Filter by Location -->
                    <select class="filter" id="location-filter">
                        <option value="">All Locations</option>
                        <option value="US">USA</option>
                        <option value="Ghana">Ghana</option>
                        <option value="Zimbabwe">Zimbabwe</option>
                    </select>

                    <!-- Filter by account type -->
                    <select class="filter" id="account-filter">
                        <option value="">All Accounts</option>
                        <option value="Savings">Savings Account</option>
                        <option value="Checking">Checking Account</option>
                        <option value="Credit">Credit Card</option>
                    </select>

                    <!-- Filter Button -->
                    <button class="btn btn-primary" onclick="applyFilters()">Apply Filters</button>
                </div>
            </header>
            

            <!-- Customer List Section -->
            <section class="customer-list">
                <table>
                    <thead>
                        <tr>
                            <th>Name</th>
                            <th>Location</th>
                            <th>Churned Status</th>
                            <th>Account Type</th>
                            <th>Churn Prediction</th>
                            <th>Risk Level</th>
                            <!-- only show the actions for admin -->
                            <?php if($_SESSION['role'] == 'Admin') { ?>
                                <th>Actions</th>
                            <?php } ?>

                            <!-- <th>Actions</th> -->
                        </tr>
                    </thead>
                    <tbody id="customer-table-body"></tbody>
                </table>
                <!-- <button id="load-more" class="btn btn-secondary mt-3" onclick="loadMoreCustomers()">View More</button> -->
                
            </section>
        </div>
    </div>

    <script src="../assets/js/global.js"></script>
    <script src="../assets/js/customer_overview.js"></script>
</body>
</html>
