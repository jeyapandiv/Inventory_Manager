<?php
include 'db.php';

$sql = "SELECT productName, quantity FROM quantity ORDER BY quantity DESC";
$result = $conn->query($sql);

$topProducts = [];
$inventoryStatus = [];

if ($result->num_rows > 0) {
    while ($row = $result->fetch_assoc()) {
        $inventoryStatus[] = $row;
        if (count($topProducts) < 3) {
            $topProducts[] = $row;
        }
    }
}

echo json_encode([
    'topProducts' => $topProducts,
    'inventoryStatus' => $inventoryStatus
]);

$conn->close();

