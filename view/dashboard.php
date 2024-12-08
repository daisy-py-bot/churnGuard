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
        <h3 class="text-center py-4">Bank of America</h3>
        <a href="dashboard.html"><i class="fas fa-tachometer-alt"></i><span class="nav-text">Dashboard</span></a>
        <a href="customer_overview.html"><i class="fas fa-tachometer-alt"></i><span class="nav-text">Customer Overview</span></a>
        <a href="customer_detail.html"><i class="fas fa-comments"></i><span class="nav-text">Customer Details</span></a>
        <a href="reports.html"><i class="fas fa-chart-line"></i><span class="nav-text">Reports</span></a>
        <a href="report_page.html"><i class="fas fa-chart-line"></i><span class="nav-text">Reports</span></a>
        <a href="feedback_notes.html"><i class="fas fa-chart-pie"></i><span class="nav-text">Customer Feedback</span></a>
        <a href="admin_dashboard.html"><i class="fas fa-chart-pie"></i><span class="nav-text">Admin</span></a>
        <a href="#settings"><i class="fas fa-cogs"></i><span class="nav-text">Settings</span></a>
        <a href="#logout"><i class="fas fa-sign-out-alt"></i><span class="nav-text">Logout</span></a>
        <a href="../index.php"><i class="fas fa-sign-out-alt"></i><span class="nav-text">Home</span></a>

    </div>
    

    <div class="main-content">
        <!-- Header section with video introduction -->
        <div class="header">
            <h2 class="mt-5">Welcome to Your Dashboard</h2>
            
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
        <div class="container mt-4">

                        <!-- Insights: show information on the customers, based on their location, gender, ages, tenure, types of accounts etc -->
                        <div class="widget">
                <h4>Customer Insights Dashboard</h4>
                <div class="cards-container">
                    <!-- Total Customers Card -->
                    <div class="card">
                        <div class="card-content">
                            <h5>Total Customers</h5>
                            <p id="total-customers">1,234</p>
                        </div>
                    </div>
            
                    <!-- Total Accounts Card -->
                    <div class="card">
                        <div class="card-content">
                            <h5>Total Accounts</h5>
                            <p id="total-accounts">567</p>
                        </div>
                    </div>
            
                    <!-- Average Age of Customers Card -->
                    <div class="card">
                        <div class="card-content">
                            <h5>Average Age of Customers</h5>
                            <p id="avg-age">35 years</p>
                        </div>
                    </div>
            
                    <!-- Churn Rate Card -->
                    <div class="card">
                        <div class="card-content">
                            <h5>Average Churn Rate</h5>
                            <p id="churn-rate">2.5%</p>
                        </div>
                    </div>
            
                    <!-- Percentage of Customers by Location Card -->
                    <div class="card">
                            <div class="card-content">
                                <h5>Average Tenure</h5>
                                <p id="avg-tenure">5.2 years</p> <!-- Example: Average tenure is 5.2 years -->
                            </div>
                    </div>
                </div>
            </div>


            <!-- Churn Prediction Summary: show the trend in the churn rate over a period of time-->
            <div class="widget">
                <h4>Churn Prediction Summary</h4>
                <p>Overview of customers at risk of churn.</p>
                <canvas id="churnChart"></canvas> <!-- Add chart.js or similar for charts -->
            </div>


            <!-- Customer Feedback Overview: show rolling information on some of the feedback -->
            <div class="widget">
                <h4>Customer Feedback Overview</h4>

                <div class="feedback-container">
                    <div class="feedback-list">
                        <!-- Feedback items with conditional styling -->
                        <div class="feedback-item positive-feedback">"Great service, always helpful! I would definetely recomend this banking system. Its the best I have seen so far." - John D.</div>
                        <div class="feedback-item negative-feedback">"Had to wait a long time for support." - Sarah L.</div>
                        <div class="feedback-item positive-feedback">"Banking made easy and stress-free!" - Michael R.</div>
                        <div class="feedback-item positive-feedback">"Best experience I’ve had with any bank." - Alicia P.</div>
                        <div class="feedback-item negative-feedback">"Unexpected fees and charges! This bank is just crap. Can't believe i wasted my time and money." - David M.</div>
                        <div class="feedback-item positive-feedback">"Very responsive customer support." - Emma G.</div>
                        <div class="feedback-item positive-feedback">"The app is so user-friendly!" - Olivia T.</div>
                        <div class="feedback-item negative-feedback">"I had issues logging into my account." - Jake W.</div>
                        <div class="feedback-item negative-feedback">"Poor communication from the bank." - Tom F.</div>
                        <div class="feedback-item positive-feedback">"Excellent overall experience!" - Sophia H.</div>
                    </div>
                </div>
            </div>

                        <!-- Quick links to key parts of the website -->
                        <div class="quick-links-container">
                <h2 class="mt-5">Quick Links</h2>
                <!-- Pills with links -->
                <ul class="nav nav-pills pill-links">
                    <li class="nav-item">
                        <a class="nav-link" href="#at-risk-customers">At-Risk Customers</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="#customer-search">Customer Search</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="#reports">Reports</a>
                    </li>
                </ul>
            </div>

        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    
    <script src="../assets/js/churn_summary.js"></script>
    <script src="../assets/js/global.js"></script>
    <script src="../assets/js/customer_stats.js"></script>
    <script src="../assets/js/customer_comments.js"></script>
</body>
</html>
