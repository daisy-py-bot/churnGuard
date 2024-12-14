<?php
/// disable error reporting for production code
ini_set('display_errors', 1);
ini_set('display_startup_errors', 1);
error_reporting(E_ALL);

include 'admin_check.php';

$data = json_decode(file_get_contents("php://input"), true);

// Validate the input data
if (!$data || !isset($data['id'], $data['firstname'], $data['lastname']) || empty($data['firstname']) || empty($data['lastname'])) {
    echo json_encode(["success" => false, "message" => "Invalid input or empty name fields"]);
    exit();
}

$id = $data['id'];
$firstname = $data['firstname'];
$lastname = $data['lastname'];

// Prepare and bind parameters
$stmt = $conn->prepare("UPDATE churnguard_employees SET FirstName = ?, LastName = ? WHERE EmployeeID = ?");
$stmt->bind_param("ssi", $firstname, $lastname, $id);

// Execute the query and handle the result
if ($stmt->execute()) {
    echo json_encode(["success" => true, "message" => "User updated successfully"]);
} else {
    echo json_encode(["success" => false, "message" => "Error updating user: " . $stmt->error]);
}

// Close the connection
$stmt->close();
$conn->close();
?>
