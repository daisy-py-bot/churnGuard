<?php
include 'admin_check.php';

$data = json_decode(file_get_contents("php://input"), true);

if (!$data || !isset($data['id'])) {
    echo json_encode(["success" => false, "message" => "Invalid input"]);
    exit();
}

$id = $data['id'];

$stmt = $conn->prepare("DELETE FROM churnguard_employees WHERE EmployeeID = ?");
$stmt->bind_param("i", $id);

if ($stmt->execute()) {
    echo json_encode(["success" => true, "message" => "User deleted successfully"]);
} else {
    echo json_encode(["success" => false, "message" => "Error deleting user: " . $stmt->error]);
}

$stmt->close();
$conn->close();
?>
