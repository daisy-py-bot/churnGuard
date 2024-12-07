<?php
// diplay errors
ini_set('display_errors', 1);
ini_set('display_startup_errors', 1);
error_reporting(E_ALL);

// Set headers
header("Access-Control-Allow-Origin: localhost:3000");
header("Content-Type: application/json; charset=UTF-8");
header("Access-Control-Allow-Methods: POST");

// Include database and object files
include '../db/config.php';

// Registration endpoint
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    // Get JSON data
    $data = json_decode(file_get_contents("php://input"), true);

    // Retrieve and sanitize inputs
    $firstname = isset($data['firstname']) ? trim($data['firstname']) : null;
    $lastname = isset($data['lastname']) ? trim($data['lastname']) : null;
    $email = isset($data['email']) ? trim($data['email']) : null;
    $password = isset($data['password']) ? trim($data['password']) : null;

    // Check if fields are empty
    if (empty($firstname) || empty($lastname) || empty($email) || empty($password)) {
        echo json_encode(["message" => "Missing fields"]);
        exit();
    }

    if (!filter_var($email, FILTER_VALIDATE_EMAIL)) {
        echo json_encode(["message" => "Invalid email format!"]);
        exit;
    }

    // Check if user is already registered
    $emailCheckQuery = "SELECT employeeID FROM churnguard_employees WHERE email = ?";
    $stmt = $conn->prepare($emailCheckQuery);
    $stmt->bind_param("s", $email);
    $stmt->execute();
    $stmt->store_result();

    if ($stmt->num_rows > 0) {
        echo json_encode([
            "success" => false,
            "message" => "User already registered",
            "redirect" => "../view/login.html"
        ]);
        exit();
    }

    $stmt->close();

    // Hash the password
    $hashedPassword = password_hash($password, PASSWORD_DEFAULT);

    // Register new user
    $insertQuery = "INSERT INTO churnguard_employees (firstname, lastname, email, password) VALUES (?, ?, ?, ?)";
    $stmt = $conn->prepare($insertQuery);
    $stmt->bind_param("ssss", $firstname, $lastname, $email, $hashedPassword);

    if ($stmt->execute()) {
        echo json_encode([
            "success" => true,
            "message" => "Registration successful",
            "redirect" => "../view/login.html"
        ]);
    } else {
        http_response_code(500);
        echo json_encode([
            "success" => false,
            "message" => "Could not register. Try again"
        ]);
    }

    $stmt->close();
    $conn->close();
}
