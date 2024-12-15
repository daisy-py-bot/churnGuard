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
    <title>Admin - Users Management</title>
    <link rel="stylesheet" href="../../assets/css/global.css"> 
    <link rel="stylesheet" href="../../assets/css/users.css">
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css" rel="stylesheet"> <!-- Link to Font Awesome -->
</head>
<body>

    <!-- Sidebar -->
    <div class="sidebar">
        <h3 class="text-center py-4" style="color:gold;"><i>ChurnGuard</i> </h3>
        <a href="../dashboard.php"><i class="fas fa-tachometer-alt"></i><span class="nav-text">Dashboard</span></a>
        <a href="../customer_overview.php"><i class="fas fa-users"></i><span class="nav-text">Customer Overview</span></a>
        <a href="../report_page.php"><i class="fas fa-chart-line"></i><span class="nav-text">Reports</span></a>
        <a href="../feedback_notes.php"><i class="fas fa-comment-alt"></i><span class="nav-text">Customer Feedback</span></a>

        <!-- show the users link of the user role is admin -->
        <?php if($_SESSION['role'] == 'Admin') { ?>
            <a href="#admin/users.php"><i class="fas fa-users-cog"></i><span class="nav-text">Users</span></a>
        <?php } ?>

        <a href="../../index.php"><i class="fas fa-home"></i><span class="nav-text">Home</span></a>
        <a href="../../actions/logout.php"><i class="fas fa-sign-out-alt"></i><span class="nav-text">Logout</span></a>
    </div>
        
    
    <div class="main-content">

        <header>
            <h1 style="text-align: center;">Users Management</h1>
        </header>


            <section class="users-table">
                <table>
                    <thead>
                        <tr>
                            <th>EmployeeID</th>
                            <th>Name</th>
                            <th>Email</th>
                            <th>Role</th>
                            <th>Date Joined</th>
                            <th>Last Login</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody id="usersTableBody">
                        <!-- Dynamic rows will be inserted here by JavaScript -->
                    </tbody>
                </table>
            </section>

    </div>
    <script src="../../assets/js/users.js"></script> 
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

</body>
</html>
