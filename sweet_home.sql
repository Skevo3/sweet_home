-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Хост: 127.0.0.1
-- Время создания: Июн 27 2025 г., 17:40
-- Версия сервера: 10.4.32-MariaDB
-- Версия PHP: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- База данных: `sweet_home`
--

-- --------------------------------------------------------

--
-- Структура таблицы `categories`
--

CREATE TABLE `categories` (
  `category_id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Дамп данных таблицы `categories`
--

INSERT INTO `categories` (`category_id`, `name`) VALUES
(1, 'Cakes'),
(2, 'Chocolate & Sweets'),
(3, 'Cookies & Biscuits');

-- --------------------------------------------------------

--
-- Структура таблицы `feedback`
--

CREATE TABLE `feedback` (
  `feedback_id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `message` text DEFAULT NULL,
  `date` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Дамп данных таблицы `feedback`
--

INSERT INTO `feedback` (`feedback_id`, `user_id`, `name`, `email`, `message`, `date`) VALUES
(1, 1, 'John Doe', 'john@example.com', 'Everything was delicious!', '2025-06-23 01:27:31'),
(2, 2, 'Jane Smith', 'jane@example.com', 'Телефон: +7 (966) 078-98-16\nДетали заказа: tasty cakes', '2025-06-24 13:14:07'),
(3, NULL, 'Ivan Petrov', 'ivan.petrov@example.com', 'Здравствуйте! Хочу узнать про доставку.', '2025-06-24 13:25:27'),
(4, NULL, 'Anna Smirnova', 'anna.smirnova@example.com', 'Можно ли сделать заказ без регистрации?', '2025-06-24 13:25:27'),
(5, NULL, 'vasya', 'vasya@mpt.ru', 'tasty', '2025-06-24 13:21:03');

-- --------------------------------------------------------

--
-- Структура таблицы `ingredients`
--

CREATE TABLE `ingredients` (
  `ingredient_id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `supplier_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Дамп данных таблицы `ingredients`
--

INSERT INTO `ingredients` (`ingredient_id`, `name`, `supplier_id`) VALUES
(1, 'Cocoa', 1),
(2, 'Sugar', 2);

-- --------------------------------------------------------

--
-- Структура таблицы `orders`
--

CREATE TABLE `orders` (
  `order_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `order_date` datetime DEFAULT current_timestamp(),
  `total` decimal(10,2) DEFAULT NULL,
  `status` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Дамп данных таблицы `orders`
--

INSERT INTO `orders` (`order_id`, `user_id`, `order_date`, `total`, `status`) VALUES
(1, 1, '2025-06-23 01:27:30', 570.00, 'Pending'),
(2, 2, '2025-06-23 01:27:30', 350.00, 'Completed'),
(3, 3, '2025-06-24 12:45:07', 1.00, 'completed');

-- --------------------------------------------------------

--
-- Структура таблицы `order_items`
--

CREATE TABLE `order_items` (
  `order_item_id` int(11) NOT NULL,
  `order_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `quantity` int(11) NOT NULL,
  `unit_price` decimal(10,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Дамп данных таблицы `order_items`
--

INSERT INTO `order_items` (`order_item_id`, `order_id`, `product_id`, `quantity`, `unit_price`) VALUES
(1, 1, 1, 2, 220.00),
(2, 1, 2, 1, 350.00),
(3, 2, 4, 3, 150.00);

-- --------------------------------------------------------

--
-- Структура таблицы `products`
--

CREATE TABLE `products` (
  `product_id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `description` text DEFAULT NULL,
  `price` decimal(10,2) NOT NULL,
  `image` varchar(255) DEFAULT NULL,
  `category_id` int(11) DEFAULT NULL,
  `quantity` int(11) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Дамп данных таблицы `products`
--

INSERT INTO `products` (`product_id`, `name`, `description`, `price`, `image`, `category_id`, `quantity`) VALUES
(1, 'Milk Chocolate', 'Delicious milk chocolate.', 220.00, 'milk-chocolate.jpg', 2, 50),
(2, 'Praline', 'Nutty praline sweets.', 350.00, 'praline.jpg', 2, 20),
(3, 'Lemon Marmalade', 'Fresh lemon marmalade.', 250.00, 'lemon-marmalade.jpg', 3, 5),
(4, 'Caramel Candy', 'Sweet caramel candies.', 150.00, 'caramel-candy.jpg', 2, 40),
(5, 'Gingerbread', 'Tasty gingerbread cookies.', 180.00, 'gingerbread.jpg', 3, 25),
(6, 'Strawberry Cake', 'Fresh strawberry cake.', 450.00, 'strawberry-cake.jpg', 1, 15),
(7, 'Vanilla Cupcake', 'Soft vanilla cupcake.', 120.00, 'vanilla-cupcake.jpg', 1, 30),
(8, 'Chocolate Muffin', 'Rich chocolate muffin.', 200.00, 'chocolate-muffin.jpg', 1, 20),
(9, 'Fruit Tart', 'Delicious fruit tart.', 350.00, 'fruit-tart.jpg', 1, 10);

-- --------------------------------------------------------

--
-- Структура таблицы `suppliers`
--

CREATE TABLE `suppliers` (
  `supplier_id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Дамп данных таблицы `suppliers`
--

INSERT INTO `suppliers` (`supplier_id`, `name`) VALUES
(1, 'Supplier A'),
(2, 'Supplier B');

-- --------------------------------------------------------

--
-- Структура таблицы `supplier_products`
--

CREATE TABLE `supplier_products` (
  `id` int(11) NOT NULL,
  `supplier_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Дамп данных таблицы `supplier_products`
--

INSERT INTO `supplier_products` (`id`, `supplier_id`, `product_id`) VALUES
(1, 1, 1),
(2, 1, 2),
(3, 2, 4);

-- --------------------------------------------------------

--
-- Структура таблицы `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `role` varchar(20) NOT NULL DEFAULT 'user'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Дамп данных таблицы `users`
--

INSERT INTO `users` (`id`, `name`, `email`, `password`, `role`) VALUES
(1, 'John Doe', 'john@example.com', 'password123', 'admin'),
(2, 'Jane Smith', 'jane@example.com', 'password456', 'user'),
(3, 'danya', 'testmail@mpt.ru', '123456', 'user');

-- --------------------------------------------------------

--
-- Дублирующая структура для представления `итог по продажам за период`
-- (См. Ниже фактическое представление)
--
CREATE TABLE `итог по продажам за период` (
`name` varchar(255)
,`total_quantity` decimal(32,0)
);

-- --------------------------------------------------------

--
-- Дублирующая структура для представления `поставщики по ингредиенту`
-- (См. Ниже фактическое представление)
--
CREATE TABLE `поставщики по ингредиенту` (
`supplier_id` int(11)
,`name` varchar(255)
);

-- --------------------------------------------------------

--
-- Дублирующая структура для представления `поставщики по продукту`
-- (См. Ниже фактическое представление)
--
CREATE TABLE `поставщики по продукту` (
`supplier_id` int(11)
,`name` varchar(255)
);

-- --------------------------------------------------------

--
-- Дублирующая структура для представления `продукты по категории`
-- (См. Ниже фактическое представление)
--
CREATE TABLE `продукты по категории` (
`product_id` int(11)
,`name` varchar(255)
,`price` decimal(10,2)
,`quantity` int(11)
);

-- --------------------------------------------------------

--
-- Дублирующая структура для представления `продукты по категории с малым остатком`
-- (См. Ниже фактическое представление)
--
CREATE TABLE `продукты по категории с малым остатком` (
`product_id` int(11)
,`name` varchar(255)
,`price` decimal(10,2)
,`quantity` int(11)
);

-- --------------------------------------------------------

--
-- Дублирующая структура для представления `продукты с малым остатком`
-- (См. Ниже фактическое представление)
--
CREATE TABLE `продукты с малым остатком` (
`product_id` int(11)
,`name` varchar(255)
,`price` decimal(10,2)
,`quantity` int(11)
);

-- --------------------------------------------------------

--
-- Дублирующая структура для представления `заказы клиента`
-- (См. Ниже фактическое представление)
--
CREATE TABLE `заказы клиента` (
`order_id` int(11)
,`user_id` int(11)
,`order_date` datetime
,`total` decimal(10,2)
,`status` varchar(50)
);

-- --------------------------------------------------------

--
-- Дублирующая структура для представления `заказы по статусу`
-- (См. Ниже фактическое представление)
--
CREATE TABLE `заказы по статусу` (
`order_id` int(11)
,`user_id` int(11)
,`order_date` datetime
,`total` decimal(10,2)
,`status` varchar(50)
);

-- --------------------------------------------------------

--
-- Дублирующая структура для представления `заказы за период`
-- (См. Ниже фактическое представление)
--
CREATE TABLE `заказы за период` (
`order_id` int(11)
,`user_id` int(11)
,`order_date` datetime
,`total` decimal(10,2)
,`status` varchar(50)
);

-- --------------------------------------------------------

--
-- Дублирующая структура для представления `заказы с клиентом и продуктом`
-- (См. Ниже фактическое представление)
--
CREATE TABLE `заказы с клиентом и продуктом` (
`order_id` int(11)
,`client_name` varchar(255)
,`product_name` varchar(255)
);

-- --------------------------------------------------------

--
-- Структура для представления `итог по продажам за период`
--
DROP TABLE IF EXISTS `итог по продажам за период`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `итог по продажам за период`  AS SELECT `p`.`name` AS `name`, sum(`oi`.`quantity`) AS `total_quantity` FROM ((`order_items` `oi` join `orders` `o` on(`oi`.`order_id` = `o`.`order_id`)) join `products` `p` on(`oi`.`product_id` = `p`.`product_id`)) WHERE `o`.`order_date` between '2025-01-01' and '2025-12-31' GROUP BY `p`.`product_id` ;

-- --------------------------------------------------------

--
-- Структура для представления `поставщики по ингредиенту`
--
DROP TABLE IF EXISTS `поставщики по ингредиенту`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `поставщики по ингредиенту`  AS SELECT `s`.`supplier_id` AS `supplier_id`, `s`.`name` AS `name` FROM (`suppliers` `s` join `ingredients` `i` on(`s`.`supplier_id` = `i`.`supplier_id`)) WHERE `i`.`name` = 'Cocoa' ;

-- --------------------------------------------------------

--
-- Структура для представления `поставщики по продукту`
--
DROP TABLE IF EXISTS `поставщики по продукту`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `поставщики по продукту`  AS SELECT `s`.`supplier_id` AS `supplier_id`, `s`.`name` AS `name` FROM (`suppliers` `s` join `supplier_products` `sp` on(`s`.`supplier_id` = `sp`.`supplier_id`)) WHERE `sp`.`product_id` = 1 ;

-- --------------------------------------------------------

--
-- Структура для представления `продукты по категории`
--
DROP TABLE IF EXISTS `продукты по категории`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `продукты по категории`  AS SELECT `products`.`product_id` AS `product_id`, `products`.`name` AS `name`, `products`.`price` AS `price`, `products`.`quantity` AS `quantity` FROM `products` WHERE `products`.`category_id` = 1 ;

-- --------------------------------------------------------

--
-- Структура для представления `продукты по категории с малым остатком`
--
DROP TABLE IF EXISTS `продукты по категории с малым остатком`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `продукты по категории с малым остатком`  AS SELECT `products`.`product_id` AS `product_id`, `products`.`name` AS `name`, `products`.`price` AS `price`, `products`.`quantity` AS `quantity` FROM `products` WHERE `products`.`category_id` = 3 AND `products`.`quantity` < 30 ;

-- --------------------------------------------------------

--
-- Структура для представления `продукты с малым остатком`
--
DROP TABLE IF EXISTS `продукты с малым остатком`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `продукты с малым остатком`  AS SELECT `products`.`product_id` AS `product_id`, `products`.`name` AS `name`, `products`.`price` AS `price`, `products`.`quantity` AS `quantity` FROM `products` WHERE `products`.`quantity` < 30 ;

-- --------------------------------------------------------

--
-- Структура для представления `заказы клиента`
--
DROP TABLE IF EXISTS `заказы клиента`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `заказы клиента`  AS SELECT `orders`.`order_id` AS `order_id`, `orders`.`user_id` AS `user_id`, `orders`.`order_date` AS `order_date`, `orders`.`total` AS `total`, `orders`.`status` AS `status` FROM `orders` WHERE `orders`.`user_id` = 1 ;

-- --------------------------------------------------------

--
-- Структура для представления `заказы по статусу`
--
DROP TABLE IF EXISTS `заказы по статусу`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `заказы по статусу`  AS SELECT `orders`.`order_id` AS `order_id`, `orders`.`user_id` AS `user_id`, `orders`.`order_date` AS `order_date`, `orders`.`total` AS `total`, `orders`.`status` AS `status` FROM `orders` WHERE `orders`.`status` = 'Pending' ;

-- --------------------------------------------------------

--
-- Структура для представления `заказы за период`
--
DROP TABLE IF EXISTS `заказы за период`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `заказы за период`  AS SELECT `orders`.`order_id` AS `order_id`, `orders`.`user_id` AS `user_id`, `orders`.`order_date` AS `order_date`, `orders`.`total` AS `total`, `orders`.`status` AS `status` FROM `orders` WHERE `orders`.`order_date` between '2025-01-01' and '2025-12-31' ;

-- --------------------------------------------------------

--
-- Структура для представления `заказы с клиентом и продуктом`
--
DROP TABLE IF EXISTS `заказы с клиентом и продуктом`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `заказы с клиентом и продуктом`  AS SELECT `o`.`order_id` AS `order_id`, `u`.`name` AS `client_name`, `p`.`name` AS `product_name` FROM (((`orders` `o` join `users` `u` on(`o`.`user_id` = `u`.`id`)) join `order_items` `oi` on(`o`.`order_id` = `oi`.`order_id`)) join `products` `p` on(`oi`.`product_id` = `p`.`product_id`)) ;

--
-- Индексы сохранённых таблиц
--

--
-- Индексы таблицы `categories`
--
ALTER TABLE `categories`
  ADD PRIMARY KEY (`category_id`);

--
-- Индексы таблицы `feedback`
--
ALTER TABLE `feedback`
  ADD PRIMARY KEY (`feedback_id`),
  ADD KEY `fk_feedback_user` (`user_id`);

--
-- Индексы таблицы `ingredients`
--
ALTER TABLE `ingredients`
  ADD PRIMARY KEY (`ingredient_id`),
  ADD KEY `supplier_id` (`supplier_id`);

--
-- Индексы таблицы `orders`
--
ALTER TABLE `orders`
  ADD PRIMARY KEY (`order_id`),
  ADD KEY `fk_orders_user` (`user_id`);

--
-- Индексы таблицы `order_items`
--
ALTER TABLE `order_items`
  ADD PRIMARY KEY (`order_item_id`),
  ADD KEY `fk_order_items_order` (`order_id`),
  ADD KEY `fk_order_items_product` (`product_id`);

--
-- Индексы таблицы `products`
--
ALTER TABLE `products`
  ADD PRIMARY KEY (`product_id`),
  ADD KEY `fk_products_category` (`category_id`);

--
-- Индексы таблицы `suppliers`
--
ALTER TABLE `suppliers`
  ADD PRIMARY KEY (`supplier_id`);

--
-- Индексы таблицы `supplier_products`
--
ALTER TABLE `supplier_products`
  ADD PRIMARY KEY (`id`),
  ADD KEY `supplier_id` (`supplier_id`),
  ADD KEY `product_id` (`product_id`);

--
-- Индексы таблицы `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`);

--
-- AUTO_INCREMENT для сохранённых таблиц
--

--
-- AUTO_INCREMENT для таблицы `categories`
--
ALTER TABLE `categories`
  MODIFY `category_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT для таблицы `feedback`
--
ALTER TABLE `feedback`
  MODIFY `feedback_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT для таблицы `ingredients`
--
ALTER TABLE `ingredients`
  MODIFY `ingredient_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT для таблицы `orders`
--
ALTER TABLE `orders`
  MODIFY `order_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT для таблицы `order_items`
--
ALTER TABLE `order_items`
  MODIFY `order_item_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT для таблицы `products`
--
ALTER TABLE `products`
  MODIFY `product_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT для таблицы `suppliers`
--
ALTER TABLE `suppliers`
  MODIFY `supplier_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT для таблицы `supplier_products`
--
ALTER TABLE `supplier_products`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT для таблицы `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- Ограничения внешнего ключа сохраненных таблиц
--

--
-- Ограничения внешнего ключа таблицы `feedback`
--
ALTER TABLE `feedback`
  ADD CONSTRAINT `fk_feedback_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE SET NULL;

--
-- Ограничения внешнего ключа таблицы `ingredients`
--
ALTER TABLE `ingredients`
  ADD CONSTRAINT `ingredients_ibfk_1` FOREIGN KEY (`supplier_id`) REFERENCES `suppliers` (`supplier_id`) ON DELETE CASCADE;

--
-- Ограничения внешнего ключа таблицы `orders`
--
ALTER TABLE `orders`
  ADD CONSTRAINT `fk_orders_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Ограничения внешнего ключа таблицы `order_items`
--
ALTER TABLE `order_items`
  ADD CONSTRAINT `fk_order_items_order` FOREIGN KEY (`order_id`) REFERENCES `orders` (`order_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_order_items_product` FOREIGN KEY (`product_id`) REFERENCES `products` (`product_id`) ON DELETE CASCADE;

--
-- Ограничения внешнего ключа таблицы `products`
--
ALTER TABLE `products`
  ADD CONSTRAINT `fk_products_category` FOREIGN KEY (`category_id`) REFERENCES `categories` (`category_id`) ON DELETE SET NULL;

--
-- Ограничения внешнего ключа таблицы `supplier_products`
--
ALTER TABLE `supplier_products`
  ADD CONSTRAINT `supplier_products_ibfk_1` FOREIGN KEY (`supplier_id`) REFERENCES `suppliers` (`supplier_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `supplier_products_ibfk_2` FOREIGN KEY (`product_id`) REFERENCES `products` (`product_id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
