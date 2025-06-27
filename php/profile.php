<?php
session_start();
require_once 'db.php';

// берём ID пользователя из сессии
$id = $_SESSION['id'] ?? 0;

// берём имя и email
$stmt_user = $conn->prepare("SELECT name, email FROM users WHERE id = ?");
$stmt_user->execute([$id]);
$user = $stmt_user->fetch(PDO::FETCH_ASSOC);

// берём заказы с товарами
$stmt = $conn->prepare("
    SELECT o.order_id, o.order_date, p.name, p.price, oi.quantity
    FROM orders o
    JOIN order_items oi ON o.order_id = oi.order_id
    JOIN products p ON oi.product_id = p.product_id
    WHERE o.user_id = ?
    ORDER BY o.order_date DESC
");
$stmt->execute([$id]);
$orders = $stmt->fetchAll(PDO::FETCH_ASSOC);

// готовим JSON
$response = [
    'name' => $user['name'] ?? '',
    'email' => $user['email'] ?? '',
    'orders' => $orders
];

// отдаём JSON
header('Content-Type: application/json');
echo json_encode($response);
?>
