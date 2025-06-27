<?php
session_start();
require_once 'db.php';

// получаем данные из формы
$email = trim($_POST['email'] ?? '');
$password = trim($_POST['password'] ?? '');

if (!$email || !$password) {
    die('Все поля обязательны.');
}

// проверяем по email
$stmt = $conn->prepare("SELECT id, name, password, role FROM users WHERE email = ?");
$stmt->execute([$email]);
$user = $stmt->fetch();

// если пользователь найден и пароль совпал
if ($user && $password === $user['password']) {
    $_SESSION['id'] = $user['id'];
    $_SESSION['user_name'] = $user['name'];
    $_SESSION['role'] = $user['role'];

    // возвращаем роль — trim на всякий случай
    echo trim($user['role']);
    exit;
} else {
    die('Неверный логин или пароль.');
}
?>
