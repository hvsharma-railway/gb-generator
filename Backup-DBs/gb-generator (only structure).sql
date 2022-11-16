-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Nov 16, 2022 at 12:47 PM
-- Server version: 10.4.25-MariaDB
-- PHP Version: 7.4.30

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `gb-generator-1`
--

-- --------------------------------------------------------

--
-- Table structure for table `sequence`
--

CREATE TABLE `sequence` (
  `id` int(11) NOT NULL,
  `head_of_account` varchar(255) NOT NULL,
  `allocation` varchar(255) DEFAULT NULL,
  `debit_sequence` varchar(11) DEFAULT NULL,
  `credit_sequence` varchar(11) DEFAULT NULL,
  `tags` longtext DEFAULT NULL COMMENT 'used for searching data in revenue report',
  `utilization` enum('obsolete','active') NOT NULL DEFAULT 'active',
  `should_only_carry_forward` tinyint(1) NOT NULL DEFAULT 0,
  `should_debit_be_zero_if_positive` tinyint(1) NOT NULL DEFAULT 0,
  `should_credit_be_zero_if_positive` tinyint(1) NOT NULL DEFAULT 0,
  `should_debit_be_zero_if_negative` tinyint(1) NOT NULL DEFAULT 0,
  `should_credit_be_zero_if_negative` tinyint(1) NOT NULL DEFAULT 0,
  `can_be_found_in_schedule` tinyint(1) NOT NULL DEFAULT 0,
  `should_include_in_II_part` tinyint(1) NOT NULL DEFAULT 0,
  `notes` longtext DEFAULT NULL,
  `update_frequency` enum('monthly','yearly') DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `sequence_data`
--

CREATE TABLE `sequence_data` (
  `id` int(100) NOT NULL,
  `sequence_id` int(11) NOT NULL,
  `for_the_month_debit_amount` varchar(100) NOT NULL DEFAULT '0',
  `for_the_month_credit_amount` varchar(100) NOT NULL DEFAULT '0',
  `end_of_month_debit_amount` varchar(100) NOT NULL DEFAULT '0',
  `end_of_month_credit_amount` varchar(100) NOT NULL DEFAULT '0',
  `custom_year_month` int(11) NOT NULL,
  `is_final` tinyint(1) NOT NULL DEFAULT 0,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `sequence`
--
ALTER TABLE `sequence`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `sequence_data`
--
ALTER TABLE `sequence_data`
  ADD PRIMARY KEY (`id`),
  ADD KEY `sequence_fk` (`sequence_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `sequence`
--
ALTER TABLE `sequence`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `sequence_data`
--
ALTER TABLE `sequence_data`
  MODIFY `id` int(100) NOT NULL AUTO_INCREMENT;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `sequence_data`
--
ALTER TABLE `sequence_data`
  ADD CONSTRAINT `sequence_fk` FOREIGN KEY (`sequence_id`) REFERENCES `sequence` (`id`) ON DELETE NO ACTION;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
