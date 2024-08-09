<?php
include 'db.php';

$sql = "SELECT product, recipient, quantity, update_time FROM updateable ORDER BY update_time DESC";
$result = $conn->query($sql);

$recipientDetails = [];

if ($result->num_rows > 0) {
    while($row = $result->fetch_assoc()) {
        $recipientDetails[] = $row;
    }
}

echo json_encode($recipientDetails);

$conn->close();

