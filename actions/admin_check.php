<?php
session_start();
include '../db/config.php';

// Check if user is logged in and is an admin
if (!isset($_SESSION['user_id']) || $_SESSION['user_id'] !== 1) {
    echo json_encode(["success" => false, "message" => "Unauthorized"]);
    exit();
}
?>
