-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- 主机： 127.0.0.1
-- 生成日期： 2026-03-16 03:52:26
-- 服务器版本： 10.4.32-MariaDB
-- PHP 版本： 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- 数据库： `portfolio_site`
--

-- --------------------------------------------------------

--
-- 表的结构 `contacts`
--

CREATE TABLE `contacts` (
  `id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `email` varchar(120) NOT NULL,
  `subject` varchar(150) NOT NULL,
  `message` text NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- 转存表中的数据 `contacts`
--

INSERT INTO `contacts` (`id`, `name`, `email`, `subject`, `message`, `created_at`) VALUES
(1, 'test01', 'aaa@aaa.com', 't01', 'test!', '2026-03-14 00:07:19'),
(2, 't2', 'bbb@gmail.com', 'test2', 'hi!', '2026-03-14 00:48:53'),
(3, 'bbb', 'bbbbbbb@gmail.com', 'T4', 'TEST!', '2026-03-16 02:47:41');

-- --------------------------------------------------------

--
-- 表的结构 `projects`
--

CREATE TABLE `projects` (
  `id` int(11) NOT NULL,
  `title` varchar(255) NOT NULL,
  `slug` varchar(255) NOT NULL,
  `category` varchar(100) NOT NULL,
  `short_description` text NOT NULL,
  `full_description` text NOT NULL,
  `cover_image` varchar(255) NOT NULL,
  `featured` tinyint(1) DEFAULT 0,
  `role` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- 转存表中的数据 `projects`
--

INSERT INTO `projects` (`id`, `title`, `slug`, `category`, `short_description`, `full_description`, `cover_image`, `featured`, `role`) VALUES
(1, 'Stylized Characters (Project Seed)', 'project-seed', 'Stylized Character', 'A lineup of stylized game characters focusing on strong silhouettes, painterly materials, and animation-ready topology.', 'A stylized character set developed for game production workflows, emphasizing clean topology, clear shape language, and efficient texture workflows.', 'images/se-cover.jpg', 1, 'Modeling, Texturing, Rendering, LOD Optimization'),
(2, 'Samael Mecha', 'samael-mecha', 'Hard Surface', 'Stylized hard-surface mecha designed for mobile game production, focusing on clear mechanical forms and readable materials.', 'A stylized mecha asset designed with game production constraints in mind. The project focuses on efficient topology, clean panel structures, and material readability suitable for real-time engines.', 'images/samael-cover.jpg', 1, 'Modeling, UV Layout, Baking, Rendering'),
(3, 'Coraline', 'coraline', 'Realistic Character', 'A realistic character study focused on likeness, anatomy, and believable skin and material definition.', 'A realistic character project emphasizing facial likeness, anatomical accuracy, and production-ready material workflows for cinematic presentation.', 'images/coraline-cover.jpg', 1, 'Modeling, Texturing, Rendering'),
(4, 'Water Leviathan', 'water-leviathan', 'Stylized Creature', 'A stylized sea creature designed with dynamic silhouette, layered materials, and expressive forms.', 'A stylized creature project focused on silhouette readability, stylized surface treatment, and expressive creature design suitable for stylized game worlds.', 'images/leviathan-cover.jpg', 0, 'Modeling, Texturing, Rendering'),
(5, 'Rimerock', 'rimerock', 'Realistic Creature', 'A realistic dragon creature created from concept design through modeling, texturing, rigging, and animation.', 'A full creature pipeline project covering concept design, modeling, texturing, Python-based rigging, and animation. The project explores a complete character production workflow for games and cinematic presentation.', 'images/rimerock-cover.jpg', 0, 'Design, Modeling, Texturing, Python Rigging, Animation, Rendering');

-- --------------------------------------------------------

--
-- 表的结构 `project_filters`
--

CREATE TABLE `project_filters` (
  `id` int(11) NOT NULL,
  `project_id` int(11) NOT NULL,
  `filter_name` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- 转存表中的数据 `project_filters`
--

INSERT INTO `project_filters` (`id`, `project_id`, `filter_name`) VALUES
(1, 1, 'stylized'),
(2, 1, 'character'),
(3, 2, 'stylized'),
(4, 2, 'hardsurface'),
(5, 3, 'realistic'),
(6, 3, 'character'),
(7, 4, 'stylized'),
(8, 4, 'creature'),
(9, 5, 'realistic'),
(10, 5, 'creature'),
(11, 5, 'technical');

-- --------------------------------------------------------

--
-- 表的结构 `project_images`
--

CREATE TABLE `project_images` (
  `id` int(11) NOT NULL,
  `project_id` int(11) NOT NULL,
  `image_path` varchar(255) NOT NULL,
  `sort_order` int(11) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- 转存表中的数据 `project_images`
--

INSERT INTO `project_images` (`id`, `project_id`, `image_path`, `sort_order`) VALUES
(1, 1, 'images/project-seed/project-seed-01.PNG', 1),
(2, 1, 'images/project-seed/project-seed-02.PNG', 2),
(3, 1, 'images/project-seed/project-seed-03.PNG', 3),
(4, 1, 'images/project-seed/project-seed-04.PNG', 4),
(5, 1, 'images/project-seed/project-seed-05.PNG', 5),
(6, 1, 'images/project-seed/project-seed-06.PNG', 6),
(7, 1, 'images/project-seed/project-seed-07.PNG', 7),
(8, 1, 'images/project-seed/project-seed-08.PNG', 8),
(9, 1, 'images/project-seed/project-seed-09.PNG', 9),
(10, 2, 'images/samael/samael-01.PNG', 1),
(11, 2, 'images/samael/samael-02.PNG', 2),
(12, 2, 'images/samael/samael-03.PNG', 3),
(13, 3, 'images/coraline/coraline-01.PNG', 1),
(14, 3, 'images/coraline/coraline-02.PNG', 2),
(15, 4, 'images/leviathan/leviathan-01.PNG', 1),
(16, 4, 'images/leviathan/leviathan-02.PNG', 2),
(17, 4, 'images/leviathan/leviathan-03.PNG', 3),
(18, 5, 'images/rimerock/rimerock-01.PNG', 1),
(19, 5, 'images/rimerock/rimerock-02.PNG', 2),
(20, 5, 'images/rimerock/rimerock-03.PNG', 3);

-- --------------------------------------------------------

--
-- 表的结构 `project_tools`
--

CREATE TABLE `project_tools` (
  `id` int(11) NOT NULL,
  `project_id` int(11) NOT NULL,
  `tool_name` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- 转存表中的数据 `project_tools`
--

INSERT INTO `project_tools` (`id`, `project_id`, `tool_name`) VALUES
(1, 1, 'ZBrush'),
(2, 1, 'Maya'),
(3, 1, 'Substance Painter'),
(4, 1, 'Marmoset Toolbag'),
(5, 2, 'Maya'),
(6, 2, 'ZBrush'),
(7, 2, 'Substance Painter'),
(8, 2, 'Marmoset Toolbag'),
(9, 3, 'ZBrush'),
(10, 3, 'Maya'),
(11, 3, 'Substance Painter'),
(12, 3, 'Arnold'),
(13, 4, 'ZBrush'),
(14, 4, 'Maya'),
(15, 4, 'Substance Painter'),
(16, 4, 'Marmoset Toolbag'),
(17, 5, 'ZBrush'),
(18, 5, 'Maya'),
(19, 5, 'Substance Painter'),
(20, 5, 'Python'),
(21, 5, 'Arnold');

--
-- 转储表的索引
--

--
-- 表的索引 `contacts`
--
ALTER TABLE `contacts`
  ADD PRIMARY KEY (`id`);

--
-- 表的索引 `projects`
--
ALTER TABLE `projects`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `slug` (`slug`);

--
-- 表的索引 `project_filters`
--
ALTER TABLE `project_filters`
  ADD PRIMARY KEY (`id`),
  ADD KEY `project_id` (`project_id`);

--
-- 表的索引 `project_images`
--
ALTER TABLE `project_images`
  ADD PRIMARY KEY (`id`),
  ADD KEY `project_id` (`project_id`);

--
-- 表的索引 `project_tools`
--
ALTER TABLE `project_tools`
  ADD PRIMARY KEY (`id`),
  ADD KEY `project_id` (`project_id`);

--
-- 在导出的表使用AUTO_INCREMENT
--

--
-- 使用表AUTO_INCREMENT `contacts`
--
ALTER TABLE `contacts`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- 使用表AUTO_INCREMENT `projects`
--
ALTER TABLE `projects`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- 使用表AUTO_INCREMENT `project_filters`
--
ALTER TABLE `project_filters`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- 使用表AUTO_INCREMENT `project_images`
--
ALTER TABLE `project_images`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- 使用表AUTO_INCREMENT `project_tools`
--
ALTER TABLE `project_tools`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22;

--
-- 限制导出的表
--

--
-- 限制表 `project_filters`
--
ALTER TABLE `project_filters`
  ADD CONSTRAINT `project_filters_ibfk_1` FOREIGN KEY (`project_id`) REFERENCES `projects` (`id`) ON DELETE CASCADE;

--
-- 限制表 `project_images`
--
ALTER TABLE `project_images`
  ADD CONSTRAINT `project_images_ibfk_1` FOREIGN KEY (`project_id`) REFERENCES `projects` (`id`) ON DELETE CASCADE;

--
-- 限制表 `project_tools`
--
ALTER TABLE `project_tools`
  ADD CONSTRAINT `project_tools_ibfk_1` FOREIGN KEY (`project_id`) REFERENCES `projects` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
