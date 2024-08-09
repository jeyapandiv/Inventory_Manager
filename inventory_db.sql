-- phpMyAdmin SQL Dump
-- version 5.1.1deb5ubuntu1
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Jul 20, 2024 at 05:34 PM
-- Server version: 10.6.18-MariaDB-0ubuntu0.22.04.1
-- PHP Version: 8.1.29

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `inventory_db`
--

-- --------------------------------------------------------

--
-- Table structure for table `quantity`
--

CREATE TABLE `quantity` (
  `id` int(11) NOT NULL,
  `productName` varchar(255) NOT NULL,
  `quantity` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `quantity`
--

INSERT INTO `quantity` (`id`, `productName`, `quantity`) VALUES
(1, 'Book', 1),
(2, 'Bag', 22),
(3, 'Laptop', 7),
(4, 'Mouse', 10);

-- --------------------------------------------------------

--
-- Table structure for table `updateable`
--

CREATE TABLE `updateable` (
  `id` int(11) NOT NULL,
  `product` varchar(255) NOT NULL,
  `recipient` varchar(255) NOT NULL,
  `quantity` int(11) NOT NULL,
  `update_time` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `updateable`
--

INSERT INTO `updateable` (`id`, `product`, `recipient`, `quantity`, `update_time`) VALUES
(1, 'book', 'guru', 1, '2024-07-20 02:52:04'),
(2, 'Laptop', 'mohan', 28, '2024-07-20 02:58:09'),
(3, 'bag', 'Jey', 10, '2024-07-20 03:05:33'),
(4, 'bag', 'Jey', 10, '2024-07-20 03:05:55'),
(5, 'Laptop', 'Jey', 17, '2024-07-20 03:06:15'),
(10, 'Bag', 'Mukesh', 8, '2024-07-20 05:46:02'),
(11, 'raja', 'Bag', 2, '2024-07-20 06:28:50');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `quantity`
--
ALTER TABLE `quantity`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `updateable`
--
ALTER TABLE `updateable`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `quantity`
--
ALTER TABLE `quantity`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `updateable`
--
ALTER TABLE `updateable`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
