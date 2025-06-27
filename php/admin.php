<?php
session_start();
require_once 'db.php';

// Проверка роли — пускаем только админа
if (!isset($_SESSION['role']) || $_SESSION['role'] !== 'admin') {
    header("Location: ../index.html");
    exit;
}

// Таблицы, которыми можно управлять
$allowed_tables = [
    'users',
    'orders',
    'order_items',
    'products',
    'feedback',
    'categories',
    'suppliers',
    'ingredients',
    'supplier_products'
];

// Какая таблица выбрана
$table = $_GET['table'] ?? 'users';
if (!in_array($table, $allowed_tables)) {
    die("Invalid table.");
}

// Если нужно удалить запись
if (isset($_GET['delete_id'])) {
    $id = intval($_GET['delete_id']);
    $pk = ($table == 'users') ? 'id' : (
        ($table == 'orders') ? 'order_id' : (
            ($table == 'order_items') ? 'order_item_id' : (
                ($table == 'products') ? 'product_id' : (
                    ($table == 'feedback') ? 'feedback_id' : (
                        ($table == 'categories') ? 'category_id' : (
                            ($table == 'suppliers') ? 'supplier_id' : (
                                ($table == 'ingredients') ? 'ingredient_id' : 'id'
                            )
                        )
                    )
                )
            )
        )
    );
    $stmt = $conn->prepare("DELETE FROM $table WHERE $pk = ?");
    $stmt->execute([$id]);
    header("Location: admin.php?table=$table");
    exit;
}

// Получаем данные таблицы
$stmt = $conn->query("SELECT * FROM $table");
$rows = $stmt->fetchAll(PDO::FETCH_ASSOC);
?>

<!DOCTYPE html>
<html lang="ru">
<head>
  <meta charset="UTF-8">
  <title>Admin Panel</title>
  <!-- Шрифт заголовка -->
  <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@700&display=swap" rel="stylesheet">
  <style>
    body {
      background: #FFEED9;
      color: #AA4924;
      font-family: 'Playfair Display', serif;
      padding: 20px;
    }
    h1 {
      color: #AA4924;
    }
    nav a {
      margin-right: 20px;
      text-decoration: none;
      color: #AA4924;
      font-weight: bold;
    }
    .add-btn {
      display: inline-block;
      margin-top: 20px;
      padding: 10px 20px;
      background: #F9A875;
      color: #fff;
      text-decoration: none;
      border-radius: 5px;
      font-weight: bold;
    }
    .add-btn:hover {
      background: #D86C52;
    }
    table {
      width: 100%;
      border-collapse: collapse;
      margin-top: 20px;
    }
    th, td {
      border: 2px solid #F68C40;
      padding: 10px;
      text-align: left;
    }
    th {
      background: #F9A875;
      color: #fff;
    }
    tr:nth-child(even) {
      background: #FCDDBC;
    }
    a.action-btn {
      display: inline-block;
      padding: 6px 12px;
      background: #D86C52;
      color: #fff;
      border-radius: 4px;
      text-decoration: none;
      margin-right: 5px;
    }
    a.action-btn:hover {
      background: #AA4924;
    }
    .logout, .request-btn {
      display: inline-block;
      margin-top: 20px;
      padding: 10px 20px;
      background: #F9A875;
      color: #fff;
      text-decoration: none;
      border-radius: 5px;
      font-weight: bold;
    }
    .logout:hover, .request-btn:hover {
      background: #D86C52;
    }
  </style>
</head>
<body>
  <h1>Admin Panel — Table: <?= htmlspecialchars($table) ?></h1>

  <!-- ссылки для смены таблицы -->
  <nav>
    <?php foreach ($allowed_tables as $t): ?>
      <a href="admin.php?table=<?= $t ?>"><?= $t ?></a>
    <?php endforeach; ?>
  </nav>

  <!-- кнопка добавить запись -->
  <a class="add-btn" href="form.php?table=<?= $table ?>">Add</a>

  <!-- таблица данных -->
  <table>
    <tr>
      <?php if ($rows): ?>
        <?php foreach (array_keys($rows[0]) as $col): ?>
          <th><?= htmlspecialchars($col) ?></th>
        <?php endforeach; ?>
        <th>Actions</th>
    </tr>
    <?php foreach ($rows as $row): ?>
      <tr>
        <?php foreach ($row as $cell): ?>
          <td><?= htmlspecialchars($cell) ?></td>
        <?php endforeach; ?>
        <?php
          $pk = ($table == 'users') ? 'id' : (
              ($table == 'orders') ? 'order_id' : (
                  ($table == 'order_items') ? 'order_item_id' : (
                      ($table == 'products') ? 'product_id' : (
                          ($table == 'feedback') ? 'feedback_id' : (
                              ($table == 'categories') ? 'category_id' : (
                                  ($table == 'suppliers') ? 'supplier_id' : (
                                      ($table == 'ingredients') ? 'ingredient_id' : 'id'
                                  )
                              )
                          )
                      )
                  )
              )
          );
        ?>
        <td>
          <a class="action-btn" href="form.php?table=<?= $table ?>&edit_id=<?= $row[$pk] ?>">Edit</a>
          <a class="action-btn" href="admin.php?table=<?= $table ?>&delete_id=<?= $row[$pk] ?>">Delete</a>
        </td>
      </tr>
    <?php endforeach; ?>
    <?php else: ?>
      <tr><td colspan="100%">No records</td></tr>
    <?php endif; ?>
  </table>

  <!-- кнопка выхода -->
  <a class="logout" href="logout.php">Logout</a>

  <!-- кнопка просмотра заявок -->
  <a class="request-btn" href="request.php">Просмотр представлений</a>
</body>
</html>
