<?php
// update_inventory.php
include 'db.php';

$product = $_POST['product'];
$quantity = $_POST['quantity'];
$recipient = $_POST['recipient'];
$updateTime = date("Y-m-d H:i:s");

// Update product quantity in inventory
$sql = "SELECT quantity FROM quantity WHERE productName = ?";
$stmt = $conn->prepare($sql);
$stmt->bind_param("s", $product);
$stmt->execute();
$stmt->store_result();

if ($stmt->num_rows > 0) {
    $stmt->bind_result($currentQuantity);
    $stmt->fetch();
    $newQuantity = $currentQuantity - $quantity;

    if ($newQuantity < 0) {
        echo "Error: Not enough stock";
        exit;
    }

    $sql = "UPDATE quantity SET quantity = ? WHERE productName = ?";
    $stmt = $conn->prepare($sql);
    $stmt->bind_param("is", $newQuantity, $product);
    $stmt->execute();
}

// Insert record into updateable table
$sql = "INSERT INTO updateable (product, recipient, quantity, update_time) VALUES (?, ?, ?, ?)";
$stmt = $conn->prepare($sql);
$stmt->bind_param("ssis", $product, $recipient, $quantity, $updateTime);

if ($stmt->execute()) {
    echo "Success";
} else {
    echo "Error: " . $stmt->error;
}

$stmt->close();
$conn->close();

