<?php
include 'admin_check.php';

$data = json_decode(file_get_contents("php://input"), true);

if (!$data || !isset($data['id'], $data['role'])) {
    echo json_encode(["success" => false, "message" => "Invalid input"]);
    exit();
}

$id = $data['id'];
$role = $data['role'];

$stmt = $conn->prepare("UPDATE churnguard_employees SET Role = ? WHERE EmployeeID = ?");
$stmt->bind_param("si", $role, $id);

if ($stmt->execute()) {
    echo json_encode(["success" => true, "message" => "User role updated successfully"]);
} else {
    echo json_encode(["success" => false, "message" => "Error updating role: " . $stmt->error]);
}

$stmt->close();
$conn->close();
?>
