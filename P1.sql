-- phpMyAdmin SQL Dump
-- version 4.8.3
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: Apr 07, 2019 at 06:29 AM
-- Server version: 10.1.36-MariaDB
-- PHP Version: 7.2.11

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `P1`
--

-- --------------------------------------------------------

--
-- Table structure for table `account`
--

CREATE TABLE `account` (
  `acc_no` int(11) NOT NULL,
  `cust_id` int(11) NOT NULL,
  `acc_type` varchar(45) NOT NULL,
  `balance` float DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `account`
--

INSERT INTO `account` (`acc_no`, `cust_id`, `acc_type`, `balance`) VALUES
(24, 8, 'Checking', 0),
(25, 9, 'Checking', 0),
(26, 10, 'Checking', 26);

-- --------------------------------------------------------

--
-- Table structure for table `branch`
--

CREATE TABLE `branch` (
  `id` int(11) NOT NULL,
  `branch_name` varchar(45) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `branch`
--

INSERT INTO `branch` (`id`, `branch_name`) VALUES
(3, 'Dearborn'),
(1, 'Livonia'),
(2, 'RedFord');

-- --------------------------------------------------------

--
-- Table structure for table `customer`
--

CREATE TABLE `customer` (
  `id` int(11) NOT NULL,
  `branch_id` int(11) NOT NULL,
  `ssn` varchar(45) NOT NULL,
  `user` varchar(45) NOT NULL,
  `pass` varchar(45) NOT NULL,
  `firstname` varchar(45) NOT NULL,
  `lastname` varchar(45) NOT NULL,
  `age` int(11) NOT NULL,
  `street` varchar(45) NOT NULL,
  `city` varchar(45) NOT NULL,
  `state` varchar(45) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `customer`
--

INSERT INTO `customer` (`id`, `branch_id`, `ssn`, `user`, `pass`, `firstname`, `lastname`, `age`, `street`, `city`, `state`) VALUES
(7, 3, '11111111', 'jmac', 'ww', 'John', 'Macfadyen', 21, 'Kinloch', 'RedFord', 'MI'),
(8, 1, '123', 'jman', 'www', 'John', 'MacFadyen', 1, '15422 Kinloch St', 'RedFord', 'MI'),
(9, 1, '12345', 'mpat', 'sdasd', 'Maitra', 'Patel', 1, '15422 Kinloch St', 'RedFord', 'MI'),
(10, 1, '124', 'johnmac', 'ww', 'John', 'MacFadyen', 1, '15422 Kinloch St', 'RedFord', 'MI');

-- --------------------------------------------------------

--
-- Table structure for table `cust_phone`
--

CREATE TABLE `cust_phone` (
  `cust_id` int(11) NOT NULL,
  `phone_num` varchar(45) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `transaction`
--

CREATE TABLE `transaction` (
  `id` int(11) NOT NULL,
  `cust_id` int(11) NOT NULL,
  `tr_type` varchar(45) NOT NULL,
  `tr_amount` float DEFAULT '0',
  `tr_datetime` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `tr_acc_no` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `transaction`
--

INSERT INTO `transaction` (`id`, `cust_id`, `tr_type`, `tr_amount`, `tr_datetime`, `tr_acc_no`) VALUES
(17, 10, 'Deposit', 18, '2019-04-06 23:53:17', 26),
(18, 10, 'Deposit', 18, '2019-04-07 00:00:29', 26);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `account`
--
ALTER TABLE `account`
  ADD PRIMARY KEY (`acc_no`),
  ADD KEY `CustID_to_acc_fk_idx` (`cust_id`);

--
-- Indexes for table `branch`
--
ALTER TABLE `branch`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `branch_name_UNIQUE` (`branch_name`);

--
-- Indexes for table `customer`
--
ALTER TABLE `customer`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `ssn_UNIQUE` (`ssn`),
  ADD UNIQUE KEY `user_UNIQUE` (`user`),
  ADD KEY `branchid_to_customer_fk_idx` (`branch_id`);

--
-- Indexes for table `cust_phone`
--
ALTER TABLE `cust_phone`
  ADD PRIMARY KEY (`cust_id`,`phone_num`);

--
-- Indexes for table `transaction`
--
ALTER TABLE `transaction`
  ADD PRIMARY KEY (`id`),
  ADD KEY `CustId_to_transc_fk_idx` (`cust_id`),
  ADD KEY `accno_to_transc_fk_idx` (`tr_acc_no`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `account`
--
ALTER TABLE `account`
  MODIFY `acc_no` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=27;

--
-- AUTO_INCREMENT for table `branch`
--
ALTER TABLE `branch`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `customer`
--
ALTER TABLE `customer`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `transaction`
--
ALTER TABLE `transaction`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `account`
--
ALTER TABLE `account`
  ADD CONSTRAINT `CustID_to_acc_fk` FOREIGN KEY (`cust_id`) REFERENCES `customer` (`id`);

--
-- Constraints for table `customer`
--
ALTER TABLE `customer`
  ADD CONSTRAINT `branchid_to_customer_fk` FOREIGN KEY (`branch_id`) REFERENCES `branch` (`id`);

--
-- Constraints for table `cust_phone`
--
ALTER TABLE `cust_phone`
  ADD CONSTRAINT `CustID_to_custphone_fk` FOREIGN KEY (`cust_id`) REFERENCES `customer` (`id`);

--
-- Constraints for table `transaction`
--
ALTER TABLE `transaction`
  ADD CONSTRAINT `CustId_to_transc_fk` FOREIGN KEY (`cust_id`) REFERENCES `customer` (`id`),
  ADD CONSTRAINT `accno_to_transc_fk` FOREIGN KEY (`tr_acc_no`) REFERENCES `account` (`acc_no`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
