<?php
session_start();
require_once 'db.php';

// === публичная форма обратной связи ===
if (isset($_POST['name'], $_POST['email'], $_POST['message'])) {
    $name = trim($_POST['name']);
    $email = trim($_POST['email']);
    $message = trim($_POST['message']);

    if (!$name || !$email || !$message) {
        header("Location: ../feedback.html?error=empty");
        exit;
    }

    if (!filter_var($email, FILTER_VALIDATE_EMAIL)) {
        header("Location: ../feedback.html?error=email");
        exit;
    }

    // для анонимного посетителя user_id всегда NULL
    $user_id = null;

    try {
        $stmt = $conn->prepare("INSERT INTO feedback (user_id, name, email, message) VALUES (?, ?, ?, ?)");
        $stmt->execute([$user_id, $name, $email, $message]);
        header("Location: ../feedback.html?success=1");
        exit;
    } catch (PDOException $e) {
        die("Ошибка отправки: " . $e->getMessage());
    }
}

// === личный кабинет: форма с phone + details ===
if (isset($_POST['phone'], $_POST['details'])) {
    // если пользователь авторизован берём его имя и email
    $user_id = isset($_SESSION['id']) ? $_SESSION['id'] : null;
    $name = 'Guest';
    $email = '';

    if ($user_id) {
        $stmt_user = $conn->prepare("SELECT name, email FROM users WHERE id = ?");
        $stmt_user->execute([$user_id]);
        $user = $stmt_user->fetch(PDO::FETCH_ASSOC);
        $name = $user['name'] ?? 'Guest';
        $email = $user['email'] ?? '';
    }

    $phone = trim($_POST['phone']);
    $details = trim($_POST['details']);

    if (!$phone || !$details) {
        die('Заполните телефон и детали заказа.');
    }

    $message = "Телефон: $phone\nДетали заказа: $details";

    try {
        $stmt = $conn->prepare("INSERT INTO feedback (user_id, name, email, message) VALUES (?, ?, ?, ?)");
        $stmt->execute([$user_id, $name, $email, $message]);
        echo "OK";
        exit;
    } catch (PDOException $e) {
        die("Ошибка отправки: " . $e->getMessage());
    }
}

// === если запрос не подходит ни под один вариант ===
die('Некорректный запрос.');
?>
