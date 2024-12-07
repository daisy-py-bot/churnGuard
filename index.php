<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>ChurnGuard - Protect Your Customers</title>
    <!-- Include Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        /* Custom styles */
        body {
            font-family: Arial, sans-serif;
        }

        .navbar {
            background-color: #2c3e50; /* Navy blue theme */
        }

        .navbar-brand,
        .nav-link {
            color: white !important;
        }

        .nav-link:hover {
            text-decoration: underline;
            color: #f4d03f !important; /* Gold accent */
        }

        .hero-section {
            background-color: #ecf0f1; /* Light gray background */
            padding: 40px 20px;
            text-align: center;
        }

        .hero-section img {
            max-width: 100%;
            height: auto;
            border-radius: 10px;
        }

        .btn-primary {
            background-color: #2c3e50; /* Navy blue */
            border-color: #2c3e50;
        }

        .btn-primary:hover {
            background-color: #f4d03f; /* Gold accent */
            border-color: #f4d03f;
        }

        .features-section {
            background-color: #ffffff; /* White background for clarity */
            padding: 40px 20px;
        }

        .features-section .feature-box {
            text-align: center;
            margin-bottom: 30px;
        }

        .testimonials {
            background-color: #bdc3c7; /* Soft gray */
            color: #2c3e50; /* Navy blue text */
            padding: 40px 20px;
            text-align: center;
        }

        .testimonials blockquote {
            font-style: italic;
        }

        footer {
            background-color: #2c3e50; /* Navy blue */
            color: white;
            padding: 10px;
            text-align: center;
        }

        footer a {
            color: #f4d03f; /* Gold accent */
            text-decoration: none;
        }

        footer a:hover {
            text-decoration: underline;
        }
    </style>
</head>

<body>
    <!-- Navigation Bar -->
    <nav class="navbar navbar-expand-lg">
        <div class="container">
            <a class="navbar-brand" href="#">
                <img src="https://i.ibb.co/GW6v78f/bank.jpg" alt="ChurnGuard Logo" style="width: 40px; height: 40px; border-radius: 50%; margin-right: 8px;">
                ChurnGuard
            </a>

            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>

            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav ms-auto">
                    <li class="nav-item">
                        <a class="nav-link" href="view/login.html">Login</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="view/register.html">Register</a>
                    </li>
                </ul>
            </div>
        </div>
    </nav>

    <!-- Hero Section -->
    <header class="hero-section">
        <div class="container">
            <h1>Welcome to ChurnGuard</h1>
            <p>Empowering banks to reduce customer churn and enhance customer retention.</p>
            <img src="https://i.ibb.co/GW6v78f/bank.jpg" alt="bank" class="img-fluid">
            <p class="mt-3">
                Discover how ChurnGuard turns customer data into actionable strategies, helping banks retain clients 
                and build lasting relationships.
            </p>
            <a href="view/register.html" class="btn btn-primary">Get Started</a>
        </div>
    </header>

    <!-- Features Section -->
    <section class="features-section">
        <div class="container">
            <h2 class="text-center">Why Choose ChurnGuard?</h2>
            <div class="row mt-4">
                <div class="col-md-4 feature-box">
                    <h4>Predictive Analytics</h4>
                    <p>Anticipate customer churn with cutting-edge AI insights.</p>
                </div>
                <div class="col-md-4 feature-box">
                    <h4>Proactive Solutions</h4>
                    <p>Take data-driven actions to retain valuable customers.</p>
                </div>
                <div class="col-md-4 feature-box">
                    <h4>Comprehensive Dashboards</h4>
                    <p>Visualize customer behavior and retention metrics in real time.</p>
                </div>
            </div>
        </div>
    </section>

    <!-- Testimonials Section -->
    <section class="testimonials">
        <div class="container">
            <h2>What Our Clients Say</h2>
            <blockquote class="mt-4">
                "ChurnGuard has revolutionized how we approach customer retention. We've seen a 20% improvement in retention rates!" 
                - <strong>Banking Executive</strong>
            </blockquote>
        </div>
    </section>

    <!-- Footer -->
    <footer>
        <p>&copy; 2024 ChurnGuard. All Rights Reserved. | <a href="#">Privacy Policy</a></p>
    </footer>

    <!-- Include Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.min.js"></script>
</body>

</html>
