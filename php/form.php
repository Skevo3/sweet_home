<?php
session_start();
require_once 'db.php';

// Проверка: только админ
if (!isset($_SESSION['role']) || $_SESSION['role'] !== 'admin') {
    header("Location: ../index.html");
    exit;
}

// Таблицы, разрешённые для редактирования
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

$table = $_GET['table'] ?? '';
if (!in_array($table, $allowed_tables)) {
    die("Invalid table.");
}

// Определяем PK для таблицы
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

// Если редактируем — берём данные
$edit_id = $_GET['edit_id'] ?? null;
$data = [];

if ($edit_id) {
    $stmt = $conn->prepare("SELECT * FROM $table WHERE $pk = ?");
    $stmt->execute([$edit_id]);
    $data = $stmt->fetch(PDO::FETCH_ASSOC);
}

// Если форма отправлена
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $fields = $_POST;

    if ($edit_id) {
        $updates = [];
        $update_values = [];

        foreach ($fields as $key => $value) {
            if ($key !== $pk) {
                $updates[] = "$key = ?";
                $update_values[] = $value;
            }
        }

        $sql = "UPDATE $table SET " . implode(", ", $updates) . " WHERE $pk = ?";
        $stmt = $conn->prepare($sql);
        $update_values[] = $edit_id;
        $stmt->execute($update_values);
    } else {
        $columns = implode(", ", array_keys($fields));
        $placeholders = implode(", ", array_fill(0, count($fields), "?"));
        $sql = "INSERT INTO $table ($columns) VALUES ($placeholders)";
        $stmt = $conn->prepare($sql);
        $stmt->execute(array_values($fields));
    }

    header("Location: admin.php?table=$table");
    exit;
}

// Получаем список колонок таблицы
$stmt = $conn->query("DESCRIBE $table");
$columns = $stmt->fetchAll(PDO::FETCH_COLUMN);
?>

<!DOCTYPE html>
<html lang="ru">
<head>
  <meta charset="UTF-8">
  <title><?= $edit_id ? "Edit" : "Add" ?> in <?= htmlspecialchars($table) ?></title>
  <!-- шрифт заголовка -->
  <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@700&display=swap" rel="stylesheet">
  <style>
    body { background: #FFEED9; color: #AA4924; font-family: 'Playfair Display', serif; padding: 20px; }
    h1 { color: #AA4924; }
    form { max-width: 600px; margin: 0 auto; }
    label { display: block; margin-top: 15px; font-weight: bold; }
    input, textarea { width: 100%; padding: 10px; border: 2px solid #F68C40; border-radius: 5px; background: #FFEED9; }
    button { margin-top: 20px; padding: 12px 20px; background: #F9A875; border: none; border-radius: 5px; color: #fff; font-size: 16px; cursor: pointer; }
    button:hover { background: #D86C52; }
    a.back { display: inline-block; margin-top: 20px; text-decoration: none; color: #AA4924; font-weight: bold; }
  </style>
</head>
<body>
  <h1><?= $edit_id ? "Edit" : "Add" ?> in <?= htmlspecialchars($table) ?></h1>

  <form method="post">
    <?php foreach ($columns as $col): ?>
      <?php if ($col === $pk && !$edit_id) continue; ?>
      <label><?= htmlspecialchars($col) ?></label>
      <?php if (str_contains($col, 'description') || str_contains($col, 'message')): ?>
        <textarea name="<?= $col ?>"><?= htmlspecialchars($data[$col] ?? '') ?></textarea>
      <?php else: ?>
        <input type="text" name="<?= $col ?>" value="<?= htmlspecialchars($data[$col] ?? '') ?>">
      <?php endif; ?>
    <?php endforeach; ?>
    <button type="submit"><?= $edit_id ? "Save Changes" : "Add Record" ?></button>
  </form>

  <a class="back" href="admin.php?table=<?= $table ?>">Back to <?= $table ?></a>
</body>
</html>
