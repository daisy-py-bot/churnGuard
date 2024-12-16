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
    <title>Dashboard</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css" rel="stylesheet"> <!-- Link to Font Awesome -->
    <link rel="stylesheet" href="../assets/css/global.css">
    <link rel="stylesheet" href="../assets/css/dashboard.css">

</head>
<body>

    <!-- Sidebar -->
<div class="sidebar">
    <h3 class="text-center py-4" style="color:gold;"><i>ChurnGuard</i> </h3>
    <a href="#dashboard.php"><i class="fas fa-tachometer-alt"></i><span class="nav-text">Dashboard</span></a>
    <a href="customer_overview.php"><i class="fas fa-users"></i><span class="nav-text">Customer Overview</span></a>
    <a href="report_page.php"><i class="fas fa-chart-line"></i><span class="nav-text">Reports</span></a>
    <a href="feedback_notes.php"><i class="fas fa-comment-alt"></i><span class="nav-text">Customer Feedback</span></a>

    <!-- show the users link of the user role is admin -->
    <?php if($_SESSION['role'] == 'Admin') { ?>
        <a href="admin/users.php"><i class="fas fa-users-cog"></i><span class="nav-text">Users</span></a>
    <?php } ?>

    <a href="../index.php"><i class="fas fa-home"></i><span class="nav-text">Home</span></a>
    <a href="../actions/logout.php"><i class="fas fa-sign-out-alt"></i><span class="nav-text">Logout</span></a>
</div>

    

    <div class="main-content">

        <!-- Header section with video introduction -->
        <div class="header">
            <!-- welcome the user with their name -->
            <h1 style="text-align:center">Welcome, <?php echo $_SESSION['firstname']; ?></h1>
            
            <p style="text-align: center;">Monitor customer insights and predict churn effectively.</p>

            <!-- Video Introduction -->
            <div class="embed-responsive embed-responsive-16by9">
                    <iframe class="embed-responsive-item" 
                            src="https://www.youtube.com/embed/IOdW3jompYw" 
                            title="What is Customer Churn? And How It Can Affect Your Business" 
                            frameborder="0" 
                            allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" 
                            referrerpolicy="strict-origin-when-cross-origin" 
                            allowfullscreen>
                    </iframe>
            </div>
        </div>

        
        <!-- Dashboard widgets -->
        <div class="container mt-4" style="margin-bottom: 200px;">

            <div class="widget" style="background-color: #bdc3c7;">
                <h2>Customer Insights Dashboard</h>
                <p style="text-align: center; margin-bottom: 20px; font-size: 16px; color: #555;">
                    Explore key metrics about our customer base, churn trends, and revenue insights.
                </p>

                <div class="cards-container">
                    <!-- Total Customers Card -->
                    <div class="card">
                        <div class="card-content">
                            <h3>Total Customers</h3>
                            <p id="total-customers">1,234</p>
                        </div>
                    </div>

                    <!-- Average Age of Customers Card -->
                    <div class="card">
                        <div class="card-content">
                            <h3>Customer Average Age</h3>
                            <p id="avg-age">35 years</p>
                        </div>
                    </div>

                    <!-- Percentage of Customers by Location Card -->
                    <div class="card">
                            <div class="card-content">
                                <h3>Average Tenure</h3>
                                <p id="avg-tenure">5.2 years</p> <!-- Example: Average tenure is 5.2 years -->
                            </div>
                    </div>
                    
            
                    <!-- Total Accounts Card -->
                    <div class="card">
                        <div class="card-content">
                            <h3>Total Accounts</h3>
                            <p id="total-accounts">567</p>
                        </div>
                    </div>
            

            
                    <!-- Churn Rate Card -->
                    <div class="card">
                        <div class="card-content">
                            <h3>Average Churn Prediction Rate</h3>
                            <p id="churn-rate">2.5%</p>
                        </div>
                    </div>

                    <!-- Total Churned Customers Card -->
                    <div class="card">
                        <div class="card-content">
                            <h3>Total Churned Customers</h3>
                            <p id="total-churned-customers">0</p>
                        </div>
                    </div>
            



                    <!-- show the employees card to the admin only -->
                    <?php if($_SESSION['role'] == 'Admin') { ?>
                        <!-- Total Employees Card -->
                        <div class="card">
                            <div class="card-content">
                                <h3>Total Employees</h3>
                                <p id="total-employees">0</p>
                            </div>
                        </div>
                    <?php } ?>


                </div>
            </div>


            <!-- Churn Prediction Summary: show the trend in the churn rate over a period of time-->
            <div class="widget" style="background-color: #bdc3c7;;">
                <h2 style="margin-bottom: 1px;">
                <i class="fas fa-chart-line" style="font-size: 24px; color:#2c3e50;"></i>
                    Real Churn Trend</h2>
                <p style="margin-bottom: 25px; color: #555; text-align: center; font-size: 1.1rem; padding-bottom: 10px; border-bottom: 1px solid #ccc;">
                    "Tracking the churn trend over time helps us understand 
                    when customer attrition peaks and identify factors that influence customer retention."
                </p>
                <canvas id="churnChart"></canvas> <!-- Add chart.js or similar for charts -->
            </div>


            <!-- Customer Feedback Overview: show rolling information on some of the feedback -->

             
            <div class="widget" style="background-color: #bdc3c7;" >
                <h2 style="margin-bottom: 1px;">
                    Customer Feedback Overview
                </h2>
                
                    <p style="margin-bottom: 25px; color: #555; text-align: center; font-size: 1.1rem;  border-bottom: 1px solid #ccc;">
                "Explore the insights from our customers and help us drive continuous improvement in our services."
                </p>

                <div class="feedback-container">
                    <div class="feedback-list">
                        <!-- Feedback items with conditional styling -->
                        <div class="feedback-item positive-feedback">"Great service, always helpful! I would definetely recomend this banking system. Its the best I have seen so far." - John D.</div>
                        <div class="feedback-item negative-feedback">"Had to wait a long time for support." - Sarah L.</div>
    
                    </div>
                </div>
            </div>



        </div>


    <!-- Footer -->
        <footer style="background-color: #2c3e50; color: #ecf0f1; padding: 30px 15px; text-align: center;">
            <div class="footer-container" style="max-width: 1200px; margin: auto; display: flex; flex-wrap: wrap; justify-content: space-between; gap: 20px;">
                
                <!-- About Section -->
                <div class="footer-section" style="flex: 1; min-width: 200px;">
                    <h4 style="font-size: 18px; margin-bottom: 15px; color: #f39c12;">About Us</h4>
                    <p style="font-size: 14px; line-height: 1.6;">
                        ChurnGuard provides innovative customer retention solutions tailored to meet your needs. Our commitment is to deliver excellence and ensure your financial success.
                    </p>
                </div>
                
                <!-- Quick Links -->
                <div class="footer-section" style="flex: 1; min-width: 200px;">
                    <h4 style="font-size: 18px; margin-bottom: 15px; color: #f39c12;">Quick Links</h4>
                    <ul style="list-style: none; padding: 0; font-size: 14px; line-height: 1.8;">
                        <li><a href="#dashboard.html" style="color: #ecf0f1; text-decoration: none;">Dashboard</a></li>
                        <li><a href="customer_overview.html" style="color: #ecf0f1; text-decoration: none;">Customer Overview</a></li>
                        <li><a href="report_page.php" style="color: #ecf0f1; text-decoration: none;">Reports</a></li>
                        <li><a href="feedback_notes.html" style="color: #ecf0f1; text-decoration: none;">Feedback</a></li>
                    </ul>
                </div>
                
                <!-- Contact Section -->
                <div class="footer-section" style="flex: 1; min-width: 200px;">
                    <h4 style="font-size: 18px; margin-bottom: 15px; color: #f39c12;">Contact Us</h4>
                    <p style="font-size: 14px; line-height: 1.6;">
                        📍 Julius Nyerere, Harare, Zimbabwe<br>
                        📞 +1 (123) 456-7890<br>
                        ✉️ support@churnguard.com
                    </p>
                </div>
            </div>
            
            <!-- Bottom Footer -->
            <div class="bottom-footer" style="margin-top: 30px; border-top: 1px solid #7f8c8d; padding-top: 15px; font-size: 14px;">
                <p style="margin: 0;">&copy; 2024 ChurnGuard. All Rights Reserved.</p>
                <p style="margin: 0;">Powered by ChurnGuard Solutions</p>
            </div>
        </footer>



    </div>



    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    
    <script src="../assets/js/churn_summary.js"></script>
    <script src="../assets/js/global.js"></script>
    <script src="../assets/js/customer_stats.js"></script>
    <script src="../assets/js/customer_comments.js"></script>
</body>
</html>
