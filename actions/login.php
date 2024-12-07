<?php
// disable error reporting for production code
ini_set('display_errors', 1);
ini_set('display_startup_errors', 1);
error_reporting(E_ALL);


// Include configuration file
include '../db/config.php';

// Start a session
session_start();

// Handle POST request for login
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    // Decode JSON input
    $data = json_decode(file_get_contents("php://input"), true);
    
    // Retrieve and sanitize inputs
    $email = isset($data['email']) ? trim($data['email']) : null;
    $password = isset($data['password']) ? trim($data['password']) : null;

    // Validate email format
    if (!filter_var($email, FILTER_VALIDATE_EMAIL)) {
        http_response_code(400);
        echo json_encode(["message" => "Invalid email format"]);
        exit();
    }

    // Check for empty fields
    if (empty($email) || empty($password)) {
        http_response_code(400);
        echo json_encode(["message" => "All fields are required"]);
        exit();
    }

    // Prepare SQL query to check if user is registered
    $emailCheckQuery = "SELECT employeeID, firstname, lastname, password, role FROM churnguard_employees WHERE email = ?";
    if ($stmt = $conn->prepare($emailCheckQuery)) {
        $stmt->bind_param("s", $email);
        $stmt->execute();
        $result = $stmt->get_result();

        // If user is found, verify password
        if ($result->num_rows > 0) {
            $row = $result->fetch_assoc();

            if (password_verify($password, $row['password'])) {
                // Regenerate session ID for security
                session_regenerate_id(true);
                $_SESSION['employeeID'] = $row['employeeID'];
                $_SESSION['firstname'] = $row['firstname'];
                $_SESSION['lastname'] = $row['lastname'];
                $_SESSION['role'] = $row['role'];

                // Send success response with redirection URL
                http_response_code(200);
                echo json_encode([
                    "message" => "Login successful",
                    "redirect" => "../view/dashboard.php"
                ]);
                exit();
            } else {
                // Send error response for incorrect password
                http_response_code(401);
                echo json_encode(["message" => "Password incorrect"]);
                exit();
            }
        } else {
            // User not registered, redirect to register page
            http_response_code(400);
            echo json_encode([
                "message" => "User not registered",
                "redirect" => "../view/register.html"
            ]);
            exit();
        }

        $stmt->close();
    } else {
        // Handle SQL prepare error
        http_response_code(500);
        echo json_encode(['message' => 'Server error, please try again later']);
    }
    
    $conn->close();
}
?>
