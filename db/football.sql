-- phpMyAdmin SQL Dump
-- version 4.4.15.5
-- http://www.phpmyadmin.net
--
-- Хост: 127.0.0.1:3306
-- Время создания: Авг 21 2016 г., 22:30
-- Версия сервера: 5.5.48
-- Версия PHP: 5.6.19

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- База данных: `football`
--

-- --------------------------------------------------------

--
-- Структура таблицы `matches`
--

CREATE TABLE IF NOT EXISTS `matches` (
  `id` int(5) NOT NULL,
  `tour` int(2) DEFAULT NULL,
  `owner` int(2) DEFAULT NULL,
  `guest` int(2) DEFAULT NULL,
  `owner_goal` int(2) NOT NULL DEFAULT '0',
  `guest_goal` int(2) NOT NULL DEFAULT '0',
  `played` tinyint(4) NOT NULL DEFAULT '0'
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `matches`
--

INSERT INTO `matches` (`id`, `tour`, `owner`, `guest`, `owner_goal`, `guest_goal`, `played`) VALUES
(1, 1, 1, 20, 0, 0, 0),
(2, 1, 2, 19, 0, 0, 0),
(3, 1, 3, 18, 0, 0, 0),
(4, 1, 4, 17, 0, 0, 0),
(5, 1, 5, 16, 0, 0, 0),
(6, 1, 6, 15, 0, 0, 0),
(7, 1, 7, 14, 0, 0, 0),
(8, 1, 8, 13, 0, 0, 0),
(9, 1, 9, 12, 0, 0, 0),
(10, 1, 10, 11, 0, 0, 0);

-- --------------------------------------------------------

--
-- Структура таблицы `player`
--

CREATE TABLE IF NOT EXISTS `player` (
  `id` int(4) NOT NULL,
  `name` varchar(50) NOT NULL,
  `number` int(3) NOT NULL,
  `skill` int(3) NOT NULL,
  `team_id` int(2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Дублирующая структура для представления `table`
--
CREATE TABLE IF NOT EXISTS `table` (
`id` int(2)
,`name` varchar(50)
,`matches` bigint(21)
);

-- --------------------------------------------------------

--
-- Структура таблицы `team`
--

CREATE TABLE IF NOT EXISTS `team` (
  `id` int(2) NOT NULL,
  `name` varchar(50) NOT NULL,
  `rank` int(10) DEFAULT NULL
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `team`
--

INSERT INTO `team` (`id`, `name`, `rank`) VALUES
(1, 'Juventus Turin', 423),
(2, 'Inter Mailand', 293),
(3, 'SSC Neapel', 291),
(4, 'AS Rom', 289),
(5, 'AC Mailand', 201),
(6, 'AC Florenz', 172),
(7, 'Lazio Rom', 166),
(8, 'FC Turin', 91),
(9, 'Udinese Calcio', 91),
(10, 'US Sassuolo', 89),
(11, 'FC Genua', 87),
(12, 'FC Bologna', 76),
(13, 'UC Sampdoria', 70),
(14, 'Atal. Bergamo', 64),
(15, 'Cagliari Calcio', 48),
(16, 'FC Empoli', 47),
(17, 'Chievo Verona', 35),
(18, 'US Palermo', 34),
(19, 'Delfino Pescara', 27),
(20, 'FC Crotone', 14);

-- --------------------------------------------------------

--
-- Структура для представления `table`
--
DROP TABLE IF EXISTS `table`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`%` SQL SECURITY DEFINER VIEW `table` AS select `t`.`id` AS `id`,`t`.`name` AS `name`,(select count(0) from `matches` `m` where ((`m`.`owner` = `t`.`id`) or (`m`.`guest` = `t`.`id`))) AS `matches` from `team` `t` group by `t`.`id`;

--
-- Индексы сохранённых таблиц
--

--
-- Индексы таблицы `matches`
--
ALTER TABLE `matches`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `id` (`id`),
  ADD KEY `FK__team` (`owner`),
  ADD KEY `FK__team_2` (`guest`);

--
-- Индексы таблицы `player`
--
ALTER TABLE `player`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `id` (`id`),
  ADD KEY `team_id` (`team_id`);

--
-- Индексы таблицы `team`
--
ALTER TABLE `team`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `id` (`id`);

--
-- AUTO_INCREMENT для сохранённых таблиц
--

--
-- AUTO_INCREMENT для таблицы `matches`
--
ALTER TABLE `matches`
  MODIFY `id` int(5) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=11;
--
-- AUTO_INCREMENT для таблицы `team`
--
ALTER TABLE `team`
  MODIFY `id` int(2) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=21;
--
-- Ограничения внешнего ключа сохраненных таблиц
--

--
-- Ограничения внешнего ключа таблицы `matches`
--
ALTER TABLE `matches`
  ADD CONSTRAINT `FK__team` FOREIGN KEY (`owner`) REFERENCES `team` (`id`),
  ADD CONSTRAINT `FK__team_2` FOREIGN KEY (`guest`) REFERENCES `team` (`id`);

--
-- Ограничения внешнего ключа таблицы `player`
--
ALTER TABLE `player`
  ADD CONSTRAINT `team_id` FOREIGN KEY (`team_id`) REFERENCES `team` (`id`);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
