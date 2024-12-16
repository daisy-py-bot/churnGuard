<?php
session_start();
include '../db/config.php';

// Check if user is logged in and is an admin
if (!isset($_SESSION['employeeID']) || $_SESSION['role'] !== 'Admin') {
    echo json_encode(["success" => false, "message" => "Unauthorized"]);
    exit();
}

?>
