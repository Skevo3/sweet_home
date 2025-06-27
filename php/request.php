<?php
require_once 'db.php';

// 1) Продукты по категории ID=1 (Milk Chocolate)
$stmt1 = $conn->query("SELECT product_id, name, price, quantity FROM products WHERE category_id = 1");
$result1 = $stmt1->fetchAll(PDO::FETCH_ASSOC);

// 2) Заказы клиента ID=1 (John Doe)
$stmt2 = $conn->query("SELECT order_id, user_id, order_date, total, status FROM orders WHERE user_id = 1");
$result2 = $stmt2->fetchAll(PDO::FETCH_ASSOC);

// 3) Поставщики с ингредиентом 'Cocoa'
$stmt3 = $conn->query("
  SELECT s.supplier_id, s.name
  FROM suppliers s
  JOIN ingredients i ON s.supplier_id = i.supplier_id
  WHERE i.name = 'Cocoa'
");
$result3 = $stmt3->fetchAll(PDO::FETCH_ASSOC);

// 4) Продукты с количеством меньше 30
$stmt4 = $conn->query("SELECT product_id, name, price, quantity FROM products WHERE quantity < 30");
$result4 = $stmt4->fetchAll(PDO::FETCH_ASSOC);

// 5) Заказы за период с 2025-01-01 по 2025-12-31
$stmt5 = $conn->query("SELECT order_id, user_id, order_date, total, status FROM orders WHERE order_date BETWEEN '2025-01-01' AND '2025-12-31'");
$result5 = $stmt5->fetchAll(PDO::FETCH_ASSOC);

// 6) Поставщики продукта ID=1 (Milk Chocolate)
$stmt6 = $conn->query("
  SELECT s.supplier_id, s.name
  FROM suppliers s
  JOIN supplier_products sp ON s.supplier_id = sp.supplier_id
  WHERE sp.product_id = 1
");
$result6 = $stmt6->fetchAll(PDO::FETCH_ASSOC);

// 7) Заказы со статусом 'Pending'
$stmt7 = $conn->query("SELECT order_id, user_id, order_date, total, status FROM orders WHERE status = 'Pending'");
$result7 = $stmt7->fetchAll(PDO::FETCH_ASSOC);

// 8) Заказы с именем клиента и продуктом
$stmt8 = $conn->query("
  SELECT o.order_id, u.name AS client_name, p.name AS product_name
  FROM orders o
  JOIN users u ON o.user_id = u.id
  JOIN order_items oi ON o.order_id = oi.order_id
  JOIN products p ON oi.product_id = p.product_id
");
$result8 = $stmt8->fetchAll(PDO::FETCH_ASSOC);

// 9) Сумма проданного каждого продукта за 2025 год
$stmt9 = $conn->query("
  SELECT p.name, SUM(oi.quantity) AS total_quantity
  FROM order_items oi
  JOIN orders o ON oi.order_id = o.order_id
  JOIN products p ON oi.product_id = p.product_id
  WHERE o.order_date BETWEEN '2025-01-01' AND '2025-12-31'
  GROUP BY p.product_id
");
$result9 = $stmt9->fetchAll(PDO::FETCH_ASSOC);

// 10) Продукты с остатком < 30 и категорией ID = 3
$stmt10 = $conn->query("
  SELECT product_id, name, price, quantity
  FROM products
  WHERE category_id = 3 AND quantity < 30
");
$result10 = $stmt10->fetchAll(PDO::FETCH_ASSOC);

// Функция для таблицы
function renderTable($data) {
  if (!$data) {
    echo "<p style='color:#AA4924; font-weight:bold;'>Нет данных для вывода.</p>";
    return;
  }
  echo "<table><tr>";
  foreach (array_keys($data[0]) as $col) {
    echo "<th>$col</th>";
  }
  echo "</tr>";
  foreach ($data as $row) {
    echo "<tr>";
    foreach ($row as $cell) {
      echo "<td>$cell</td>";
    }
    echo "</tr>";
  }
  echo "</table>";
}
?>

<!DOCTYPE html>
<html lang="ru">
<head>
  <meta charset="UTF-8">
  <title>Request — 10 SQL Queries (Fixed)</title>
  <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@700&display=swap" rel="stylesheet">
  <style>
    body {
      background: #FFEED9;
      color: #AA4924;
      font-family: 'Playfair Display', serif;
      padding: 20px;
    }
    h1, h2 {
      color: #AA4924;
    }
    table {
      border-collapse: collapse;
      width: 100%;
      margin-bottom: 40px;
    }
    th, td {
      border: 2px solid #F68C40;
      padding: 10px;
    }
    th {
      background: #F9A875;
      color: #fff;
    }
    tr:nth-child(even) {
      background: #FCDDBC;
    }
    .back-btn {
      display: inline-block;
      padding: 10px 20px;
      background: #F9A875;
      color: #fff;
      text-decoration: none;
      border-radius: 5px;
      font-weight: bold;
      margin-top: 30px;
    }
    .back-btn:hover {
      background: #D86C52;
    }
  </style>
</head>
<body>
  <h1>Request.php — 10 SQL Queries (Fixed)</h1>

  <h2>1) Продукты по категории ID = 1</h2>
  <?php renderTable($result1); ?>

  <h2>2) Заказы клиента ID = 1</h2>
  <?php renderTable($result2); ?>

  <h2>3) Поставщики с ингредиентом 'Cocoa'</h2>
  <?php renderTable($result3); ?>

  <h2>4) Продукты с количеством меньше 30</h2>
  <?php renderTable($result4); ?>

  <h2>5) Заказы за период 2025</h2>
  <?php renderTable($result5); ?>

  <h2>6) Поставщики продукта ID = 1</h2>
  <?php renderTable($result6); ?>

  <h2>7) Заказы со статусом 'Pending'</h2>
  <?php renderTable($result7); ?>

  <h2>8) Заказы с именем клиента и продуктом</h2>
  <?php renderTable($result8); ?>

  <h2>9) Сумма проданного каждого продукта за 2025</h2>
  <?php renderTable($result9); ?>

  <h2>10) Продукты с остатком &lt; 30 и категорией 1</h2>
  <?php renderTable($result10); ?>

  <!-- Кнопка возврата -->
  <a class="back-btn" href="admin.php">← Вернуться в админку</a>
</body>
</html>
