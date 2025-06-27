<?php
session_start();
require_once 'db.php';

// берём данные из формы
$name = trim($_POST['name'] ?? '');
$email = trim($_POST['email'] ?? '');
$password = trim($_POST['password'] ?? '');

// проверка: все поля должны быть заполнены
if (!$name || !$email || !$password) {
    die('Все поля обязательны.');
}

// проверка: email уникален
$stmt = $conn->prepare("SELECT id FROM users WHERE email = ?");
$stmt->execute([$email]);

if ($stmt->fetch()) {
    die('Пользователь с таким email уже существует.');
}

// добавляем пользователя (пароль без хеша)
$stmt = $conn->prepare("INSERT INTO users (name, email, password) VALUES (?, ?, ?)");
$stmt->execute([$name, $email, $password]);

// cохраняем ID нового пользователя в сессию
$_SESSION['id'] = $conn->lastInsertId();

// редирект в профиль
header("Location: ../profile.html");
exit;
?>
