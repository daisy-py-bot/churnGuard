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
    <title>Reports page</title>
    <link rel="stylesheet" href="../assets/css/global.css">
    <link rel="stylesheet" href="../assets/css/report_page.css">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <link rel="stylesheet" href="../assets/css/high_risk_customer_table.css">

</head>
<body>


    <!-- Sidebar -->
    <div class="sidebar">
        <h3 class="text-center py-4" style="color:gold;"><i>ChurnGuard</i> </h3>
        <a href="dashboard.php"><i class="fas fa-tachometer-alt"></i><span class="nav-text">Dashboard</span></a>
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




    <!-- Main Content -->
    <div class="main-content">

        <!-- Customer churn overview -->
        <section id="customer-churn-overview">
            <h1>Customer Churn Overview</h1>
            <div class="churn-overview-container">


                <div class="gauge-container">
                    <h2>Real-Time Churn Gauge</h2>
                    
                    <canvas id="churnRateGauge"></canvas>
                    <div id="churnRateText" class="churn-rate-text">15%</div> <!-- Text overlay for the percentage -->
                </div> 
                
                <div class="customer-churn-prediction">
                    <h2 class="graph-title">Churn Prediction per Service</h2>
                    <p class="graph-description" >
                        Analyze the likelihood of customer churn for individual banking services. <br>
                       
                    </p>

                    <canvas id="customerServiceChart"></canvas> <!-- Canvas for the chart -->
                </div>

                <div class="location-churn-prediction">
                    <h2 class="graph-title">Churn Prediction by Location</h2>
                    <p class="graph-description">
                    "Explore the insights from our customers and help us drive continuous improvement in our services."
                    </p>
                    <canvas id="customerLocationChart"></canvas>
                </div>

                <div class="sentiment-trend-analysis">
                    <h2>Sentiment Trend Analysis</h2>
                    <label for="yearFilter">Select Year:</label>
                    <select id="yearFilter">
                        <option value="2024">2024</option>
                        <option value="2023">2023</option>
                        <option value="2022">2022</option>
                    </select>
                    <canvas id="sentimentTrendChart"></canvas>
                </div>

                <div class="chart-container">
                    <h1 style="padding-top: 40px;">Customer Churn Prediction Analysis</h1>
                    <label for="churn-threshold">Set Churn Prediction Threshold:</label>
                    <input type="range" class="churn-threshold" id="churn-threshold" min="0" max="1" step="0.1" value="0">
                    <span id="threshold-value">0.0</span>
                    <canvas id="customer-chart"></canvas>
                    <div id="custom-legend" style="display: flex; justify-content: center; margin-top: 20px; margin-bottom: 20px; font-family: Arial, sans-serif;"></div>

                </div>

                        

            </div>
        </section>


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

    <script src="../assets/js/global.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <script src="../assets/js/churn_predictions.js"></script>
    <script src="../assets/js/customer_bubble_chart.js"></script>
     <script src="../assets/js/sentiment_analysis.js"></script>
     <script src="../assets/js/get_churn_predictors.js"></script>

    
</body>
</html>
