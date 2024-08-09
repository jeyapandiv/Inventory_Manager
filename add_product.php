<?php
include 'db.php';

if ($_SERVER['REQUEST_METHOD'] === 'POST') {

    $productName = $_POST['productName'];
    $quantity = $_POST['quantity'];

    //checking the product existance
    $sql = "SELECT quantity FROM quantity WHERE productName = ?";
    $stmt = $conn->prepare($sql);
    $stmt->bind_param("s", $productName);
    $stmt->execute();
    $stmt->store_result();

    if ($stmt->num_rows > 0) {
        //updating existing product quantity
        $stmt->bind_result($currentQuantity);
        $stmt->fetch();
        $newQuantity = $currentQuantity + $quantity;

        $sql = "UPDATE quantity SET quantity = ? WHERE productName = ?";
        $stmt = $conn->prepare($sql);
        $stmt->bind_param("is", $newQuantity, $productName);
    } else {
        //inserting new product
        $sql = "INSERT INTO quantity (productName, quantity) VALUES (?, ?)";
        $stmt = $conn->prepare($sql);
        $stmt->bind_param("si", $productName, $quantity);
    }

    if ($stmt->execute()) {
        echo "Success";
    } else {
        echo "Error: " . $stmt->error;
    }

    $stmt->close();
    $conn->close();
}
