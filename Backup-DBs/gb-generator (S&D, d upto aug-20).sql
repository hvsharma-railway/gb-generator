-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Nov 16, 2022 at 12:59 PM
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
-- Database: `gb-generator-2`
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

--
-- Dumping data for table `sequence`
--

INSERT INTO `sequence` (`id`, `head_of_account`, `allocation`, `debit_sequence`, `credit_sequence`, `tags`, `utilization`, `should_only_carry_forward`, `should_debit_be_zero_if_positive`, `should_credit_be_zero_if_positive`, `should_debit_be_zero_if_negative`, `should_credit_be_zero_if_negative`, `can_be_found_in_schedule`, `should_include_in_II_part`, `notes`, `update_frequency`, `created_at`, `updated_at`) VALUES
(1, 'Cash Imprest', '00867201', '91800', '38300', NULL, 'active', 0, 0, 0, 0, 1, 0, 0, NULL, 'monthly', '2022-08-22 08:27:29', '2022-11-02 12:29:49'),
(2, '101 INCOME TAX ON UNION EMOLUMENT INCL PENSION', '00002101', NULL, '10500', NULL, 'active', 0, 0, 0, 1, 0, 0, 0, NULL, 'monthly', '2022-08-22 08:27:29', '2022-11-02 12:29:49'),
(3, '102 INCOME TAX ON INCOME OTHER THAN UNION EMOLUMENTS', '00002102', NULL, '10600', NULL, 'active', 0, 0, 0, 1, 0, 0, 0, NULL, 'monthly', '2022-08-22 08:27:29', '2022-11-02 12:29:49'),
(4, 'Advance Cheque', NULL, NULL, NULL, NULL, 'obsolete', 1, 0, 0, 0, 0, 0, 0, 'Only Carry forward', NULL, '2022-08-26 10:43:33', '2022-09-16 06:10:24'),
(5, 'Misc Govt A/CS', NULL, NULL, NULL, NULL, 'active', 1, 0, 0, 0, 0, 0, 0, 'This will only be used in March of every year.', 'yearly', '2022-08-26 10:43:33', '2022-11-02 12:30:17'),
(6, 'Net Revenue', NULL, NULL, NULL, NULL, 'obsolete', 1, 0, 0, 0, 0, 0, 0, 'Only Carry forward', NULL, '2022-08-26 10:43:33', '2022-09-16 06:10:34'),
(7, 'Final Heads (Excluding Suspense, Accident - Compensation and Pensionary Charges)', NULL, '00007', NULL, 'Total Grant No.3 to 13\nFinal Heads (Excluding\nSuspense,Accident-\nCompensation and Pensionary Charges) NET', 'active', 0, 0, 1, 0, 1, 1, 0, 'It is to be taken from Revenue Schedule', 'monthly', '2022-08-26 10:43:33', '2022-11-02 12:29:49'),
(8, 'Miscellaneous Advance Revenue Others', NULL, '00001', NULL, 'Miscellaneous Advance Revenue Others (Debit - Credit)', 'active', 0, 0, 1, 0, 1, 1, 0, NULL, 'monthly', '2022-08-26 10:43:33', '2022-11-02 12:29:49'),
(9, 'Miscellaneous Advance Revenue (GST)', NULL, '00002', NULL, 'Miscellaneous Advance Revenue (GST) (Debit - Credit)', 'active', 0, 0, 1, 0, 1, 1, 0, NULL, 'monthly', '2022-08-26 10:43:33', '2022-11-02 12:29:49'),
(10, 'Miscellaneous Advance Revenue (COVID-19)', NULL, '00003', NULL, 'Miscellaneous Advance Revenue (COVID-19) (Debit - Credit)', 'active', 0, 0, 1, 0, 1, 1, 0, NULL, 'monthly', '2022-08-26 10:43:33', '2022-11-02 12:29:49'),
(11, 'Demand payable', NULL, '00004', NULL, 'Demand payable (Debit - Credit)', 'active', 0, 0, 1, 0, 0, 1, 0, NULL, 'monthly', '2022-08-26 10:43:33', '2022-11-11 06:58:07'),
(12, 'Deduct amount Met Debit service Fund', NULL, '48200', NULL, NULL, 'active', 0, 0, 0, 0, 0, 0, 0, NULL, 'monthly', '2022-08-26 10:43:33', '2022-11-02 12:29:49'),
(13, '504 EDUCATION CESS', '00002504', NULL, '10800', NULL, 'active', 1, 0, 0, 0, 0, 0, 0, NULL, NULL, '2022-08-26 10:43:33', '2022-09-16 06:10:40'),
(14, 'Secondary and Higher Education Cess', NULL, NULL, '10850', NULL, 'obsolete', 1, 0, 0, 0, 0, 0, 0, NULL, NULL, '2022-08-26 10:43:33', '2022-09-16 06:12:02'),
(15, 'Edu- cess E', '00002505', NULL, NULL, NULL, 'obsolete', 1, 0, 0, 0, 0, 0, 0, 'Carry forward from old entry.', NULL, '2022-08-26 10:43:33', '2022-09-16 06:12:08'),
(16, 'Health and Education Cess', '00002506', NULL, '10900', NULL, 'active', 0, 0, 0, 1, 0, 0, 0, NULL, 'monthly', '2022-08-26 10:43:33', '2022-11-02 12:29:49'),
(17, 'Basic service Tax', '004411', NULL, '11110', NULL, 'obsolete', 0, 0, 0, 0, 0, 0, 0, NULL, 'monthly', '2022-08-26 10:43:33', '2022-11-02 12:29:49'),
(18, 'Swach BHarat Tax', '004414', NULL, '11135', NULL, 'obsolete', 0, 0, 0, 0, 0, 0, 0, NULL, 'monthly', '2022-08-26 10:43:33', '2022-11-02 12:29:49'),
(19, 'Krishi Kalyan Tax', '004414', NULL, '11140', NULL, 'active', 0, 0, 0, 0, 0, 0, 0, NULL, 'monthly', '2022-08-26 10:43:33', '2022-11-02 12:29:49'),
(20, 'Int on Advances (4901 to 4905)', '', NULL, '11600', NULL, 'active', 0, 0, 0, 1, 0, 0, 0, NULL, 'monthly', '2022-08-26 10:43:33', '2022-11-07 09:51:16'),
(21, 'House Bldg Adv Rly', '00761001', NULL, '18500', NULL, 'active', 0, 0, 0, 0, 0, 0, 0, NULL, 'monthly', '2022-08-30 06:25:22', '2022-11-02 12:29:49'),
(22, 'Motor car Adv', '00761002', '59100', '18700', NULL, 'active', 0, 1, 0, 0, 0, 0, 0, NULL, 'monthly', '2022-08-30 06:25:22', '2022-11-02 12:29:49'),
(23, 'Scooter Adv Rly\r\n', '00761003', NULL, '18800', NULL, 'active', 0, 0, 1, 0, 0, 0, 0, NULL, 'monthly', '2022-08-30 06:25:22', '2022-11-11 10:22:26'),
(24, 'Scooter Adv Audit\r\n', '00761053', NULL, NULL, NULL, 'active', 1, 0, 0, 0, 0, 0, 0, 'Carry forward from old entry.', NULL, '2022-08-30 06:25:22', '2022-09-16 06:12:11'),
(25, 'Cycle Adv Rly\r\n', '00761004', NULL, NULL, NULL, 'active', 1, 0, 0, 0, 0, 0, 0, 'Carry forward from old entry.', NULL, '2022-08-30 06:25:22', '2022-09-16 06:12:14'),
(26, 'Cycle Adv Audit\r\n', '00761054', NULL, NULL, NULL, 'active', 1, 0, 0, 0, 0, 0, 0, 'Carry forward from old entry.', NULL, '2022-08-30 06:25:22', '2022-09-16 06:12:20'),
(27, 'Computer Adv Rly', '00761005', '59400', '19100', NULL, 'active', 0, 0, 1, 0, 0, 0, 0, NULL, 'monthly', '2022-08-30 06:25:22', '2022-11-02 12:29:49'),
(28, 'Computer Adv Audit', '00761055', NULL, NULL, NULL, 'active', 0, 0, 0, 0, 0, 0, 0, 'Carry forward from old entry.', 'monthly', '2022-08-30 06:25:22', '2022-11-02 12:29:49'),
(37, 'Fan Adv Rly', '00761006', NULL, NULL, NULL, 'active', 1, 0, 0, 0, 0, 0, 0, 'Carry forward from old entry.', NULL, '2022-08-30 06:27:16', '2022-09-16 06:12:44'),
(38, 'Fan Adv Audit', '', NULL, NULL, NULL, 'active', 1, 0, 0, 0, 0, 0, 0, 'Carry forward from old entry.', NULL, '2022-08-30 06:27:16', '2022-09-16 06:12:46'),
(39, 'Flood Adv', NULL, NULL, NULL, NULL, 'active', 1, 0, 0, 0, 0, 0, 0, 'Carry forward from old entry.', NULL, '2022-08-30 06:27:16', '2022-09-16 06:12:52'),
(40, 'DEPOSIT WITH RESERVE BANK', NULL, '86700', NULL, NULL, 'active', 0, 0, 0, 0, 1, 0, 0, NULL, 'monthly', '2022-08-30 06:29:54', '2022-11-02 12:29:49'),
(41, 'Advance Of Pay (Departmental Advance)', NULL, NULL, '84800', NULL, 'active', 1, 0, 0, 0, 0, 0, 0, 'Carry forward from old entry.', NULL, '2022-08-30 06:29:54', '2022-09-16 06:12:57'),
(42, 'Fun. Adv (Deptt Advance)', '00855202', '84800', '32000', NULL, 'active', 0, 0, 1, 0, 0, 0, 0, NULL, 'monthly', '2022-08-30 06:29:54', '2022-11-02 12:29:49'),
(43, 'Commercial Lines 47100', NULL, '47100', NULL, NULL, 'active', 1, 0, 0, 0, 0, 0, 0, NULL, NULL, '2022-08-30 06:29:54', '2022-09-16 06:13:02'),
(45, 'Central Govt GIS (801101 TO 801104)', NULL, NULL, '22200', NULL, 'active', 0, 0, 0, 1, 0, 0, 0, NULL, 'monthly', '2022-08-30 06:42:00', '2022-11-02 12:29:49'),
(46, 'C.G.E.G.I.S (Insurance fund)\r\n', NULL, '77200', NULL, NULL, 'active', 0, 0, 0, 0, 1, 0, 0, 'Carry forward from old entry.', 'monthly', '2022-08-30 06:42:00', '2022-11-02 12:29:49'),
(47, 'C.G.E.G.I.S (Savings Fund)\r\n', NULL, '77300', NULL, NULL, 'active', 0, 0, 0, 0, 1, 0, 0, NULL, 'monthly', '2022-08-30 06:42:00', '2022-11-02 12:29:49'),
(48, 'O.L.W.R.\r\n', NULL, NULL, NULL, NULL, 'active', 1, 0, 0, 0, 0, 0, 0, 'Carry forward from old entry.', NULL, '2022-08-30 06:42:00', '2022-09-16 06:13:07'),
(49, 'R.R.S.K. (RRSK)\r\n', NULL, '55000', NULL, NULL, 'active', 0, 0, 0, 0, 1, 0, 0, NULL, 'monthly', '2022-08-30 06:42:00', '2022-11-02 12:29:49'),
(50, 'N.C.State Railway PF', NULL, '76000', '21100', NULL, 'active', 0, 0, 0, 1, 0, 0, 0, NULL, 'monthly', '2022-08-30 06:42:00', '2022-11-02 12:29:49'),
(51, 'D.R.F.\r\n', NULL, '54400', NULL, NULL, 'active', 0, 0, 0, 0, 1, 0, 0, NULL, 'monthly', '2022-08-30 06:42:00', '2022-11-02 12:29:49'),
(52, 'D.F.', NULL, '54500', NULL, NULL, 'active', 0, 0, 0, 0, 1, 0, 0, NULL, 'monthly', '2022-08-30 06:42:00', '2022-11-02 12:29:49'),
(53, 'S.R.S.F.', NULL, '57900', NULL, NULL, 'active', 1, 0, 0, 0, 0, 0, 0, NULL, NULL, '2022-08-30 06:42:00', '2022-09-16 06:13:11'),
(54, 'R.S.F.', NULL, '54900', NULL, NULL, 'active', 0, 0, 1, 0, 0, 0, 0, NULL, 'monthly', '2022-08-30 06:48:04', '2022-11-02 12:29:49'),
(55, 'A.C.F.', NULL, NULL, NULL, NULL, 'active', 1, 0, 0, 0, 0, 0, 0, NULL, NULL, '2022-08-30 06:48:04', '2022-09-16 06:13:22'),
(56, 'Pension Fund', NULL, '48100', NULL, NULL, 'active', 0, 0, 0, 0, 1, 0, 0, NULL, 'monthly', '2022-08-30 06:48:04', '2022-11-02 12:29:49'),
(57, 'TFR FROM CONT P.F. CR', NULL, NULL, NULL, NULL, 'active', 1, 0, 0, 0, 0, 0, 0, 'Carry forward from old entry.', NULL, '2022-08-30 06:48:04', '2022-09-16 06:13:25'),
(58, 'New Pen. Scheme 00834201&202', NULL, NULL, NULL, NULL, 'active', 1, 0, 0, 0, 0, 0, 0, 'Carry forward from old entry.', NULL, '2022-08-30 06:48:04', '2022-09-16 06:13:28'),
(59, 'Remittance into Bank\r\n', NULL, '87200', NULL, NULL, 'active', 0, 0, 0, 0, 1, 0, 0, NULL, 'monthly', '2022-08-30 06:48:04', '2022-11-02 12:29:49'),
(60, 'Departmental Balance', NULL, '91700', '38200', NULL, 'active', 0, 0, 0, 0, 0, 0, 0, NULL, 'monthly', '2022-08-30 06:48:04', '2022-11-02 12:29:49'),
(61, '00834203  (-1748050)', NULL, NULL, NULL, NULL, 'active', 1, 0, 0, 0, 0, 0, 0, NULL, NULL, '2022-08-30 06:48:04', '2022-09-16 06:13:31'),
(62, 'Cap Fund', NULL, NULL, NULL, NULL, 'obsolete', 1, 0, 0, 0, 0, 0, 0, 'Carry forward from old entry.', NULL, '2022-08-30 06:48:04', '2022-09-16 06:13:35'),
(63, 'Capital Outlay\r\n', NULL, '55450', NULL, NULL, 'active', 0, 0, 0, 0, 1, 0, 0, NULL, 'monthly', '2022-08-30 06:48:04', '2022-11-02 12:29:49'),
(64, 'Commercial Lines', NULL, '78630', NULL, NULL, 'active', 1, 0, 0, 0, 0, 0, 0, NULL, NULL, '2022-08-30 07:23:18', '2022-09-16 06:13:38'),
(65, '5002 Net Capital Outlay (Nirbhaya)', NULL, '55460', NULL, NULL, 'active', 1, 0, 0, 0, 0, 0, 0, NULL, NULL, '2022-08-30 07:23:18', '2022-09-16 06:13:42'),
(66, 'Rly Deposits \r\n', NULL, '83900', '31100', NULL, 'active', 0, 1, 0, 1, 0, 0, 0, NULL, 'monthly', '2022-08-30 07:23:18', '2022-11-02 12:29:49'),
(67, 'TRANSFERRED FROM MH 5003-02\r\n', NULL, NULL, '28150', NULL, 'active', 0, 0, 0, 0, 0, 0, 0, NULL, 'monthly', '2022-08-30 10:24:56', '2022-11-02 12:29:49'),
(68, 'Employee Contribution\r\n', NULL, NULL, '12960', NULL, 'active', 0, 0, 0, 1, 0, 0, 0, 'Full amount divide by 2', 'monthly', '2022-08-30 10:24:56', '2022-11-02 12:29:49'),
(69, 'Government Contribution\r\n', NULL, NULL, '12960', NULL, 'active', 0, 0, 0, 1, 0, 0, 0, 'Full amount divide by 2', 'monthly', '2022-08-30 10:24:56', '2022-11-02 12:29:49'),
(70, 'Payments towards trustee Bank-EC\r\n', NULL, NULL, '12965', NULL, 'active', 0, 0, 0, 1, 0, 0, 0, 'Full amount divide by 2', 'monthly', '2022-08-30 10:24:56', '2022-11-02 12:29:49'),
(71, 'Payments towards trustee Bank-GC\r\n', NULL, NULL, '12965', NULL, 'active', 0, 0, 0, 1, 0, 0, 0, 'Full amount divide by 2', 'monthly', '2022-08-30 10:24:56', '2022-11-02 12:29:49'),
(72, 'Total-0071-NPS', NULL, NULL, NULL, NULL, 'active', 1, 0, 0, 0, 0, 0, 0, NULL, NULL, '2022-08-30 10:30:17', '2022-09-16 06:13:47'),
(73, 'Cheques & Bills\r\n', NULL, NULL, '34300', NULL, 'active', 0, 1, 0, 0, 0, 0, 0, NULL, 'monthly', '2022-08-30 10:30:17', '2022-11-02 12:29:49'),
(74, 'Demands Recoverable', NULL, NULL, '00005', 'DEMANDS RECOVERABLE', 'active', 0, 0, 0, 1, 0, 1, 0, NULL, 'monthly', '2022-08-30 10:30:17', '2022-11-02 12:29:49'),
(75, 'Gross Earnings', NULL, NULL, '00006', 'TOTAL GROSS EARNINGS\r\n', 'active', 0, 0, 0, 1, 0, 1, 0, NULL, 'monthly', '2022-08-30 10:30:17', '2022-11-02 12:29:49'),
(76, 'Misc Receipts\r\n', NULL, NULL, '15400', NULL, 'active', 0, 0, 0, 1, 0, 0, 0, NULL, 'monthly', '2022-08-30 10:30:17', '2022-11-02 12:29:49'),
(77, 'Transfers Divisional\r\n', NULL, '89500', '36200-I', NULL, 'active', 0, 0, 0, 1, 0, 0, 0, NULL, 'monthly', '2022-08-30 10:30:17', '2022-11-02 12:29:49'),
(78, 'Transfers Railway Capital\r\n', NULL, '89600', '36200-II', NULL, 'active', 0, 0, 0, 0, 0, 0, 0, NULL, 'monthly', '2022-08-30 10:30:17', '2022-11-02 12:29:49'),
(79, 'R. Staff Benefit Fund\r\n', NULL, '80400', '26900', NULL, 'active', 0, 1, 0, 0, 0, 0, 0, NULL, 'monthly', '2022-08-30 10:30:17', '2022-11-02 12:29:49'),
(80, 'Miscellaneous Advance Revenue (LC BANK CHARGE)', NULL, NULL, NULL, 'Miscellaneous Advance Revenue (LC BANK CHARGE)', 'active', 0, 0, 0, 0, 0, 0, 0, 'to be found in revenue schedule.', 'monthly', '2022-08-30 11:41:44', '2022-11-02 12:29:49'),
(115, 'DEPOSIT CLAIMS', '00844501', NULL, NULL, NULL, 'active', 0, 0, 0, 0, 0, 1, 1, NULL, 'monthly', '2022-10-25 06:59:58', '2022-11-02 12:29:49'),
(116, 'DEPOSIT BOOKS [UNPAID WAGES]', '00844510', NULL, NULL, NULL, 'active', 0, 0, 0, 0, 0, 1, 1, NULL, 'monthly', '2022-10-25 06:59:58', '2022-11-02 12:29:49'),
(117, 'DEPOSIT PF', '00844505', NULL, NULL, NULL, 'active', 0, 0, 0, 0, 0, 1, 1, NULL, 'monthly', '2022-10-25 06:59:58', '2022-11-02 12:29:49'),
(118, 'DEPOSIT NPS', '00844572', NULL, NULL, NULL, 'active', 0, 0, 0, 0, 0, 1, 1, NULL, 'monthly', '2022-10-25 06:59:58', '2022-11-02 12:29:49'),
(119, 'DEPOSIT PENSION', '00844508', NULL, NULL, NULL, 'active', 0, 0, 0, 0, 0, 1, 1, NULL, 'monthly', '2022-10-25 07:06:10', '2022-11-02 12:29:49'),
(120, 'DEPOSIT COAL', '00844506', NULL, NULL, NULL, 'active', 0, 0, 0, 0, 0, 1, 1, NULL, 'monthly', '2022-10-25 07:06:10', '2022-11-02 12:29:49'),
(121, 'LABOUR CESS CHARGE', '00844551', NULL, NULL, NULL, 'active', 0, 0, 0, 0, 0, 1, 1, NULL, 'monthly', '2022-10-25 07:18:05', '2022-11-02 12:29:49'),
(122, 'DEPOSIT SECURITY', '00844553', NULL, NULL, NULL, 'active', 0, 0, 0, 0, 0, 1, 1, NULL, 'monthly', '2022-10-25 07:18:05', '2022-11-02 12:29:49'),
(123, 'DEPOSIT EXPENDITURE', '00844519', NULL, NULL, NULL, 'active', 0, 0, 0, 0, 0, 1, 1, NULL, 'monthly', '2022-10-25 07:18:05', '2022-11-02 12:29:49'),
(124, 'DEPOSIT ECC BANK', '00844512', NULL, NULL, NULL, 'active', 0, 0, 0, 0, 0, 1, 1, NULL, 'monthly', '2022-10-25 07:18:05', '2022-11-02 12:29:49'),
(125, 'DEPOSIT H.S.D.OIL', '00844515', NULL, NULL, NULL, 'active', 0, 0, 0, 0, 0, 1, 1, NULL, 'monthly', '2022-10-25 07:27:37', '2022-11-02 12:29:49'),
(126, 'DEPOSIT WORKS', '00844521', NULL, NULL, NULL, 'active', 0, 0, 0, 0, 0, 1, 1, NULL, 'monthly', '2022-10-25 07:27:37', '2022-11-02 12:29:49'),
(127, 'DEPOSIT BOOKS EARNEST MONEY', '00844533', NULL, NULL, NULL, 'active', 0, 0, 0, 0, 0, 1, 1, NULL, 'monthly', '2022-10-25 07:27:37', '2022-11-02 12:29:49'),
(128, 'DEPOSIT GVAT', '', NULL, NULL, NULL, 'active', 1, 0, 0, 0, 0, 1, 1, NULL, NULL, '2022-10-25 07:27:37', '2022-10-25 07:27:37'),
(129, 'DEPOSIT CIPS', '00844539', NULL, NULL, NULL, 'active', 0, 0, 0, 0, 0, 1, 1, NULL, 'monthly', '2022-10-25 07:32:37', '2022-11-02 12:29:49'),
(130, 'DEPOSIT PM RELIEF FUND', '00844540', NULL, NULL, NULL, 'active', 0, 0, 0, 0, 0, 1, 1, NULL, 'monthly', '2022-10-25 07:32:37', '2022-11-02 12:29:49'),
(131, 'DEPOSIT STORES-LIQUIDITY DAMAGE', '00844583', NULL, NULL, NULL, 'active', 0, 0, 0, 0, 0, 1, 1, NULL, 'monthly', '2022-10-25 07:32:37', '2022-11-02 12:29:49'),
(132, 'DEPOSIT MISC TDS CGST', '00844541', NULL, NULL, NULL, 'active', 0, 0, 0, 0, 0, 1, 1, NULL, 'monthly', '2022-10-25 07:32:37', '2022-11-02 12:29:49'),
(133, 'DEPOSIT MISC TDS SGST', '00844542', NULL, NULL, NULL, 'active', 0, 0, 0, 0, 0, 1, 1, NULL, 'monthly', '2022-10-25 07:32:37', '2022-11-02 12:29:49'),
(134, 'DEPOSIT MISC TDS IGST', '00844544', NULL, NULL, NULL, 'active', 0, 0, 0, 0, 0, 1, 1, NULL, 'monthly', '2022-10-25 07:32:37', '2022-11-02 12:29:49'),
(135, 'DEPOSIT EST GAZZ(D n G)', '00844566', NULL, NULL, NULL, 'active', 0, 0, 0, 0, 0, 1, 1, NULL, 'monthly', '2022-10-25 07:32:37', '2022-11-02 12:29:49'),
(136, 'Deposit Misc CGST Output Tax Liablity', '00844545', NULL, NULL, NULL, 'active', 0, 0, 0, 0, 0, 1, 1, NULL, 'monthly', '2022-10-25 07:36:30', '2022-11-02 12:29:49'),
(137, 'Deposit Misc SGST Output Tax Liablity', '00844546', NULL, NULL, NULL, 'active', 0, 0, 0, 0, 0, 1, 1, NULL, 'monthly', '2022-10-25 07:36:30', '2022-11-02 12:29:49'),
(138, 'Deposit Misc IGST Output Tax Liablity', '00844548', NULL, NULL, NULL, 'active', 0, 0, 0, 0, 0, 1, 1, NULL, 'monthly', '2022-10-25 07:36:30', '2022-11-02 12:29:49'),
(139, 'DEPOSIT CGST RCM TAX LIABLITY', '00844595', NULL, NULL, NULL, 'active', 0, 0, 0, 0, 0, 1, 1, NULL, 'monthly', '2022-10-25 07:42:24', '2022-11-02 12:29:49'),
(140, 'DEPOSIT SGST RCM TAX LIABLITY', '00844596', NULL, NULL, NULL, 'active', 0, 0, 0, 0, 0, 1, 1, NULL, 'monthly', '2022-10-25 07:42:24', '2022-11-02 12:29:49'),
(141, 'DEPOSIT CESS RCM TAX LIABLITY', '00844599', NULL, NULL, NULL, 'active', 0, 0, 0, 0, 0, 1, 1, NULL, 'monthly', '2022-10-25 07:42:24', '2022-11-02 12:29:49'),
(142, 'DEPOSIT EST NON GAZZ(D n G)', '00844567', NULL, NULL, NULL, 'active', 0, 0, 0, 0, 0, 1, 1, NULL, 'monthly', '2022-10-25 07:50:36', '2022-11-02 12:29:49'),
(143, 'PM CARES FUND', '00844569', NULL, NULL, NULL, 'active', 0, 0, 0, 0, 0, 1, 1, NULL, 'monthly', '2022-10-25 07:50:36', '2022-11-02 12:29:49'),
(144, 'DEPOSIT STORES-SECURITY DEPOSIT', '00844584', NULL, NULL, NULL, 'active', 0, 0, 0, 0, 0, 1, 1, NULL, 'monthly', '2022-10-25 07:50:36', '2022-11-02 12:29:49'),
(145, 'EBR-IRFC Fund Source (84)', 'EBR84', NULL, NULL, NULL, 'active', 0, 0, 0, 0, 0, 1, 1, NULL, 'monthly', '2022-10-25 07:55:15', '2022-11-02 12:29:49'),
(146, 'EBR-Special Fund Source (85)', 'EBR85', NULL, NULL, NULL, 'active', 0, 0, 0, 0, 0, 1, 1, NULL, 'monthly', '2022-10-25 07:55:15', '2022-11-02 12:29:49'),
(147, 'EBR-SPECIAL', '00844685', NULL, NULL, NULL, 'active', 0, 0, 0, 0, 0, 1, 1, NULL, 'monthly', '2022-10-26 05:24:18', '2022-11-02 12:29:49'),
(148, 'DEPOSIT IRFC', '00844528', NULL, NULL, NULL, 'active', 0, 0, 0, 0, 0, 1, 1, NULL, 'monthly', '2022-10-26 05:24:18', '2022-11-02 12:29:49'),
(149, 'DEPOSIT RAILWAY MINISTERS WELFARE AND RELIEF', '00844514', NULL, NULL, NULL, 'active', 0, 0, 0, 0, 0, 1, 1, NULL, 'monthly', '2022-10-26 05:24:18', '2022-11-02 12:29:49'),
(150, 'DEPOSIT ESTABLISHMENT NON GAZZ', '00844507', NULL, NULL, NULL, 'active', 0, 0, 0, 0, 0, 1, 1, NULL, 'monthly', '2022-10-27 04:50:38', '2022-11-02 12:29:49'),
(151, 'Deposit Misc UTGST Output Tax Liablity', '00844547', NULL, NULL, NULL, 'active', 0, 0, 0, 0, 0, 1, 1, NULL, NULL, '2022-11-09 06:56:08', '2022-11-09 06:56:08'),
(152, 'DEPOSIT WORKS-CONT/WORKS TAX', '00844531', NULL, NULL, NULL, 'active', 0, 0, 0, 0, 0, 1, 1, NULL, NULL, '2022-11-09 06:56:15', '2022-11-09 06:56:15');

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
-- Dumping data for table `sequence_data`
--

INSERT INTO `sequence_data` (`id`, `sequence_id`, `for_the_month_debit_amount`, `for_the_month_credit_amount`, `end_of_month_debit_amount`, `end_of_month_credit_amount`, `custom_year_month`, `is_final`, `created_at`, `updated_at`) VALUES
(1, 2, '0', '9303863', '0', '44634374.00', 202008, 0, '2022-10-19 04:57:23', '2022-10-19 05:01:13'),
(2, 3, '0', '1982197.59', '0', '17012266.59', 202008, 0, '2022-10-19 04:57:23', '2022-10-19 05:04:08'),
(3, 13, '0', '0', '0', '0', 0, 0, '2022-10-19 04:57:23', '2022-10-19 05:08:03'),
(4, 14, '0', '0', '0', '0', 202008, 0, '2022-10-19 04:57:23', '2022-10-19 04:57:23'),
(5, 16, '0', '372664', '0', '1785318.00', 202008, 0, '2022-10-19 04:57:23', '2022-10-19 06:22:54'),
(6, 17, '0', '0', '0', '0', 202008, 0, '2022-10-19 04:57:23', '2022-10-19 04:57:23'),
(7, 18, '0', '0', '0', '0', 202008, 0, '2022-10-19 04:57:23', '2022-10-19 04:57:23'),
(8, 19, '0', '0', '0', '0', 202008, 0, '2022-10-19 04:57:23', '2022-10-19 04:57:23'),
(9, 20, '0', '0', '0', '0', 202008, 0, '2022-10-19 04:57:23', '2022-10-19 04:57:23'),
(10, 68, '0', '15173616', '0', '846636334.00', 202008, 0, '2022-10-19 04:57:23', '2022-10-19 06:24:12'),
(11, 69, '0', '15173616', '0', '846636334.00', 202008, 0, '2022-10-19 04:57:23', '2022-10-19 06:24:14'),
(12, 70, '0', '15173616', '0', '846636334.00', 202008, 0, '2022-10-19 04:57:23', '2022-10-19 06:24:15'),
(13, 71, '0', '15173616', '0', '846636334.00', 202008, 0, '2022-10-19 04:57:23', '2022-10-19 06:24:18'),
(14, 76, '0', '644971.49', '0', '19381451.85', 202008, 0, '2022-10-19 04:57:23', '2022-10-19 06:24:46'),
(15, 21, '0', '0', '-2.15', '0', 202008, 0, '2022-10-19 04:57:23', '2022-10-19 06:26:31'),
(16, 22, '0', '0', '0', '12135.00', 202008, 0, '2022-10-19 04:57:23', '2022-10-19 06:40:53'),
(17, 23, '0', '0', '29418.70', '0', 202008, 0, '2022-10-19 04:57:23', '2022-10-19 06:41:10'),
(18, 27, '0', '3000', '194856.00', '0', 202008, 0, '2022-10-19 04:57:24', '2022-10-19 06:41:45'),
(19, 50, '24008320', '27770953', '0', '1805590721.40', 202008, 0, '2022-10-19 04:57:24', '2022-10-19 06:42:20'),
(20, 45, '0', '179607', '0', '1083315.00', 202008, 0, '2022-10-19 04:57:24', '2022-10-19 06:42:41'),
(21, 79, '36000', '0', '0', '-342885.70', 202008, 0, '2022-10-19 04:57:24', '2022-10-19 06:43:12'),
(22, 67, '0', '0', '0', '84008614.04', 202008, 0, '2022-10-19 04:57:24', '2022-10-19 09:52:46'),
(23, 66, '68603163.55', '67333349.36', '0', '1097446924.65', 202008, 0, '2022-10-19 04:57:24', '2022-10-19 09:49:07'),
(24, 42, '0', '15000', '381000.00', '0', 202008, 0, '2022-10-19 04:57:24', '2022-10-19 06:44:12'),
(25, 73, '0', '-70711916', '0', '312049327.20', 202008, 0, '2022-10-19 04:57:24', '2022-10-19 09:50:46'),
(26, 77, '-12015151.12', '565019101', '0', '3275526230.51', 202008, 0, '2022-10-19 04:57:24', '2022-10-19 06:45:33'),
(27, 78, '23782981', '23782981', '0', '0', 202008, 0, '2022-10-19 04:57:24', '2022-10-19 04:57:25'),
(28, 60, '0', '0', '0', '0', 202008, 0, '2022-10-19 04:57:24', '2022-10-19 04:57:24'),
(29, 1, '2553422', '2553422', '2553422.00', '0', 202008, 0, '2022-10-19 04:57:24', '2022-10-19 06:47:57'),
(30, 43, '0', '0', '-40.98', '0', 0, 0, '2022-10-19 04:57:24', '2022-10-19 07:43:36'),
(31, 56, '38432816', '0', '7439476273.32', '0', 202008, 0, '2022-10-19 04:57:24', '2022-10-19 06:48:55'),
(32, 12, '0', '0', '43164000.00', '0', 202008, 0, '2022-10-19 04:57:24', '2022-10-19 08:08:12'),
(33, 51, '9640', '0', '3804828478.08', '0', 202008, 0, '2022-10-19 04:57:24', '2022-10-19 06:50:00'),
(34, 52, '-9640', '0', '1556822875.59', '0', 202008, 0, '2022-10-19 04:57:24', '2022-10-19 06:50:28'),
(35, 54, '0', '0', '660770376.00', '0', 202008, 0, '2022-10-19 04:57:24', '2022-10-19 06:54:52'),
(36, 49, '45954528.53', '0', '2186312460.02', '0', 202008, 0, '2022-10-19 04:57:24', '2022-10-19 06:55:22'),
(37, 63, '1610004', '0', '669345168.92', '0', 202008, 0, '2022-10-19 04:57:24', '2022-10-19 06:55:41'),
(38, 65, '0', '0', '3850000', '0', 0, 0, '2022-10-19 04:57:24', '2022-11-02 10:21:20'),
(39, 53, '0', '0', '1564279901', '0', 0, 0, '2022-10-19 04:57:24', '2022-11-02 10:21:20'),
(40, 46, '30000', '0', '150000.00', '0', 202008, 0, '2022-10-19 04:57:24', '2022-10-19 06:57:41'),
(41, 47, '426579', '0', '2821311.00', '0', 202008, 0, '2022-10-19 04:57:24', '2022-10-19 06:57:54'),
(42, 64, '0', '0', '163944000', '0', 0, 0, '2022-10-19 04:57:24', '2022-11-02 10:21:21'),
(43, 41, '0', '0', '415', '0', 0, 0, '2022-10-19 04:57:25', '2022-11-02 10:21:20'),
(44, 40, '0', '0', '383266477.00', '0', 202008, 0, '2022-10-19 04:57:25', '2022-10-19 06:59:31'),
(45, 59, '0', '0', '0', '0', 202008, 0, '2022-10-19 04:57:25', '2022-10-19 04:57:25'),
(46, 7, '435436990.02', '0', '2454762374.10', '0', 202008, 0, '2022-10-19 04:57:43', '2022-10-19 07:05:06'),
(47, 8, '751987', '0', '22637303.72', '0', 202008, 0, '2022-10-19 04:57:43', '2022-10-19 07:05:38'),
(48, 9, '41992.46', '0', '894179.73', '0', 202008, 0, '2022-10-19 04:57:43', '2022-10-19 07:06:02'),
(49, 10, '812325', '0', '15117989.70', '0', 202008, 0, '2022-10-19 04:57:43', '2022-10-19 08:22:15'),
(50, 11, '0', '0', '0', '0', 202008, 0, '2022-10-19 04:57:43', '2022-10-19 04:57:43'),
(51, 74, '0', '152025', '0', '-56236166.00', 202008, 0, '2022-10-19 04:57:43', '2022-10-19 07:07:31'),
(52, 75, '0', '2064739', '0', '1260042031.44', 202008, 0, '2022-10-19 04:57:43', '2022-10-19 07:07:51'),
(53, 4, '0', '0', '0', '0', 0, 0, '2022-10-19 07:11:02', '2022-10-19 07:11:02'),
(55, 6, '0', '0', '43010642133.34', '0', 0, 0, '2022-10-19 07:14:51', '2022-10-19 07:14:51'),
(56, 15, '0', '0', '0', '0', 0, 0, '2022-10-19 07:14:51', '2022-10-19 07:14:51'),
(57, 24, '0', '0', '0', '0', 0, 0, '2022-10-19 07:17:57', '2022-10-19 07:17:57'),
(58, 25, '0', '0', '-0.5', '0', 0, 0, '2022-10-19 07:17:57', '2022-11-02 10:21:21'),
(59, 26, '0', '0', '0', '0', 0, 0, '2022-10-19 07:17:57', '2022-10-19 07:17:57'),
(60, 28, '0', '0', '0', '0', 0, 0, '2022-10-19 07:17:57', '2022-10-19 07:17:57'),
(61, 37, '0', '0', '0', '0', 0, 0, '2022-10-19 07:17:57', '2022-10-19 07:17:57'),
(62, 38, '0', '0', '0', '0', 0, 0, '2022-10-19 07:17:57', '2022-10-19 07:17:57'),
(63, 39, '0', '0', '0', '0', 0, 0, '2022-10-19 07:17:57', '2022-10-19 07:17:57'),
(64, 48, '0', '0', '19044363', '0', 0, 0, '2022-10-19 07:22:41', '2022-11-02 10:21:21'),
(65, 55, '0', '0', '139068222.84', '0', 0, 0, '2022-10-19 07:22:41', '2022-10-19 07:22:41'),
(66, 57, '0', '0', '0', '68293209.95', 0, 0, '2022-10-19 07:22:41', '2022-10-19 07:22:41'),
(67, 58, '0', '0', '0', '1601600', 0, 0, '2022-10-19 07:22:41', '2022-11-02 10:21:21'),
(68, 61, '0', '0', '0', '0', 0, 0, '2022-10-19 07:22:41', '2022-10-19 07:22:41'),
(69, 62, '0', '0', '-57610976', '0', 0, 0, '2022-10-19 07:22:41', '2022-11-02 10:21:21'),
(70, 72, '0', '0', '0', '0', 0, 0, '2022-10-19 07:23:50', '2022-10-19 07:23:50'),
(116, 115, '0.00', '0.00', '0', '67179.00', 202008, 0, '2022-10-26 05:47:50', '2022-10-27 09:53:45'),
(117, 117, '0.00', '0.00', '0', '388135.00', 202008, 0, '2022-10-26 05:47:50', '2022-10-27 09:52:18'),
(118, 120, '0.00', '0.00', '0', '1436587.00', 202008, 0, '2022-10-26 05:47:50', '2022-10-27 09:51:48'),
(119, 119, '0.00', '0.00', '0', '652323.00', 202008, 0, '2022-10-26 05:47:50', '2022-10-27 09:50:47'),
(120, 116, '0.00', '0.00', '0', '190000.77', 202008, 0, '2022-10-26 05:47:50', '2022-10-27 09:46:40'),
(121, 124, '0.00', '0.00', '0', '198760.00', 202008, 0, '2022-10-26 05:47:50', '2022-10-27 09:46:06'),
(122, 149, '0.00', '0.00', '0', '0', 202008, 0, '2022-10-26 05:47:50', '2022-10-26 05:47:50'),
(123, 125, '24285661.00', '24261181.00', '0', '-2440014.00', 202008, 0, '2022-10-26 05:47:50', '2022-10-27 09:43:43'),
(124, 123, '0.00', '22185005.00', '0', '25859462.00', 202008, 0, '2022-10-26 05:47:50', '2022-10-27 09:42:29'),
(125, 126, '32289106.00', '3776536.00', '0', '663658490.49', 202008, 0, '2022-10-26 05:47:50', '2022-10-27 09:42:18'),
(126, 148, '0.00', '0.00', '0', '0', 202008, 0, '2022-10-26 05:47:50', '2022-10-26 05:47:50'),
(127, 127, '3519500.00', '8632400.00', '0', '42502100.00', 202008, 0, '2022-10-26 05:47:50', '2022-10-27 09:38:39'),
(128, 129, '0.00', '24680.00', '0', '496380.00', 202008, 0, '2022-10-26 05:47:50', '2022-10-27 09:37:52'),
(129, 130, '0.00', '0.00', '0', '0', 202008, 0, '2022-10-26 05:47:50', '2022-10-26 05:47:50'),
(130, 132, '918696.84', '886817.28', '0', '503010.84', 202008, 0, '2022-10-26 05:47:50', '2022-10-27 09:37:02'),
(131, 133, '918696.84', '886817.28', '0', '503010.84', 202008, 0, '2022-10-26 05:47:50', '2022-10-27 09:36:48'),
(132, 134, '183889.87', '987589.41', '0', '816282.24', 202008, 0, '2022-10-26 05:47:50', '2022-10-27 09:36:30'),
(133, 136, '0.00', '0.00', '0', '1221870.81', 202008, 0, '2022-10-26 05:47:50', '2022-10-27 09:35:45'),
(134, 137, '0.00', '0.00', '0', '1221867.41', 202008, 0, '2022-10-26 05:47:50', '2022-10-27 09:35:29'),
(135, 138, '0.00', '0.00', '0', '-5523864.08', 202008, 0, '2022-10-26 05:47:50', '2022-10-27 09:35:06'),
(136, 121, '0.00', '972537.93', '0', '1901235.93', 202008, 0, '2022-10-26 05:47:50', '2022-10-27 09:33:39'),
(137, 122, '6487613.00', '4818470.46', '0', '360421185.86', 202008, 0, '2022-10-26 05:47:50', '2022-10-27 09:33:07'),
(138, 135, '0.00', '4212.00', '0', '4212.00', 202008, 0, '2022-10-26 05:47:50', '2022-10-27 09:32:32'),
(139, 142, '0.00', '0.00', '0', '480.00', 202008, 0, '2022-10-26 05:47:50', '2022-10-27 05:05:36'),
(140, 143, '0', '-1733.00', '0', '0', 202008, 0, '2022-10-26 05:47:50', '2022-10-27 09:28:36'),
(141, 118, '0.00', '-33505.00', '0', '909117.00', 202008, 0, '2022-10-26 05:47:50', '2022-10-27 05:03:14'),
(142, 131, '0.00', '0.00', '0', '0', 202008, 0, '2022-10-26 05:47:50', '2022-10-26 05:47:50'),
(143, 139, '0.00', '0.00', '0', '469886.56', 202008, 0, '2022-10-26 05:47:50', '2022-10-27 05:02:24'),
(144, 140, '0.00', '0.00', '0', '469886.56\n', 202008, 0, '2022-10-26 05:47:50', '2022-10-27 05:01:15'),
(145, 141, '0.00', '0.00', '0', '297376.69', 202008, 0, '2022-10-26 05:47:50', '2022-10-27 05:00:29'),
(146, 146, '0', '0', '0', '0', 202008, 0, '2022-10-26 05:47:50', '2022-10-26 05:47:50'),
(147, 145, '0.00', '0.00', '0', '0', 202008, 0, '2022-10-26 05:47:50', '2022-10-26 05:47:50'),
(148, 150, '0.00', '-67659.00', '0', '1199839.73', 202008, 0, '2022-10-27 04:50:50', '2022-10-27 04:56:11'),
(149, 128, '0', '0', '0', '22123', 0, 0, '2022-10-27 11:23:25', '2022-11-02 10:21:22');

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
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=153;

--
-- AUTO_INCREMENT for table `sequence_data`
--
ALTER TABLE `sequence_data`
  MODIFY `id` int(100) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3785;

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
