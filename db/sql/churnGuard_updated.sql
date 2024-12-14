-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: Dec 14, 2024 at 01:42 PM
-- Server version: 10.4.28-MariaDB
-- PHP Version: 8.2.4

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `churnguard`
--

-- --------------------------------------------------------

--
-- Table structure for table `churnguard_account_types`
--

CREATE TABLE `churnguard_account_types` (
  `AccountTypeID` int(11) NOT NULL,
  `AccountTypeName` varchar(50) NOT NULL,
  `InterestRate` decimal(5,2) DEFAULT NULL,
  `CreatedAt` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `churnguard_account_types`
--

INSERT INTO `churnguard_account_types` (`AccountTypeID`, `AccountTypeName`, `InterestRate`, `CreatedAt`) VALUES
(1, 'Savings', 2.50, '2024-12-07 21:13:12'),
(2, 'Checking', 1.00, '2024-12-07 21:13:12'),
(3, 'Business', 4.00, '2024-12-07 21:13:12'),
(4, 'Other', 0.50, '2024-12-07 21:13:12'),
(5, 'Savings', 2.80, '2024-12-07 21:13:12');

-- --------------------------------------------------------

--
-- Table structure for table `churnguard_bank_issues`
--

CREATE TABLE `churnguard_bank_issues` (
  `IssueID` int(11) NOT NULL,
  `IssueType` enum('Product','Service','Billing','Other') DEFAULT NULL,
  `IssueDescription` varchar(255) DEFAULT NULL,
  `IssueStatus` enum('Resolved','Unresolved') DEFAULT 'Unresolved',
  `IssueDate` date DEFAULT NULL,
  `IssueResolvedDate` date DEFAULT NULL,
  `IssueResolvedBy` varchar(255) DEFAULT NULL,
  `issue_priority` enum('High','Medium','Low') DEFAULT 'Low'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `churnguard_bank_issues`
--

INSERT INTO `churnguard_bank_issues` (`IssueID`, `IssueType`, `IssueDescription`, `IssueStatus`, `IssueDate`, `IssueResolvedDate`, `IssueResolvedBy`, `issue_priority`) VALUES
(1, 'Product', 'Customer unable to access mobile banking app.', 'Resolved', '2024-01-01', '2024-01-02', 'Admin 1', 'Low'),
(2, 'Service', 'Delayed response from customer support.', 'Unresolved', '2024-02-10', NULL, 'Admin 2', 'Low'),
(3, 'Billing', 'Incorrect charges on monthly statement.', 'Resolved', '2024-03-05', '2024-03-06', 'Admin 3', 'Low'),
(4, 'Other', 'ATM machine malfunctioned.', 'Unresolved', '2024-04-18', NULL, 'Admin 4', 'Low'),
(5, 'Product', 'Online banking transaction failed.', 'Resolved', '2024-05-25', '2024-05-26', 'Admin 5', 'Low');

-- --------------------------------------------------------

--
-- Table structure for table `churnguard_churn_prediction`
--

CREATE TABLE `churnguard_churn_prediction` (
  `PredictionID` int(11) NOT NULL,
  `CustomerID` int(11) NOT NULL,
  `PredictionDate` date DEFAULT NULL,
  `ChurnProbability` decimal(3,2) DEFAULT NULL,
  `RiskLevel` enum('Low','Medium','High') DEFAULT NULL,
  `PredictionNotes` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `churnguard_churn_prediction`
--

INSERT INTO `churnguard_churn_prediction` (`PredictionID`, `CustomerID`, `PredictionDate`, `ChurnProbability`, `RiskLevel`, `PredictionNotes`) VALUES
(1, 1, '2024-06-01', 0.10, 'Low', 'Stable account with good history'),
(2, 2, '2024-06-02', 0.40, 'Medium', 'Frequent complaints, but good transactions'),
(3, 3, '2024-01-03', 0.60, 'High', 'Customer has had several unresolved issues'),
(4, 4, '2024-03-04', 0.20, 'Low', 'Positive feedback and consistent payments'),
(5, 5, '2024-06-05', 0.30, 'Medium', 'Medium satisfaction, good account activity'),
(6, 1, '2024-06-01', 0.10, 'Low', 'Stable account with good history'),
(7, 2, '2024-07-02', 0.40, 'Medium', 'Frequent complaints, but good transactions'),
(8, 3, '2024-08-03', 0.60, 'High', 'Customer has had several unresolved issues'),
(9, 4, '2024-09-04', 0.20, 'Low', 'Positive feedback and consistent payments'),
(10, 5, '2024-10-05', 0.30, 'Medium', 'Medium satisfaction, good account activity'),
(11, 1, '2024-01-01', 0.10, 'Low', 'Stable account with good history'),
(12, 2, '2024-06-02', 0.40, 'Medium', 'Frequent complaints, but good transactions'),
(13, 3, '2024-11-03', 0.60, 'High', 'Customer has had several unresolved issues'),
(14, 4, '2024-12-04', 0.20, 'Low', 'Positive feedback and consistent payments'),
(15, 5, '2024-10-05', 0.30, 'Medium', 'Medium satisfaction, good account activity');

-- --------------------------------------------------------

--
-- Table structure for table `churnguard_customers`
--

CREATE TABLE `churnguard_customers` (
  `CustomerID` int(11) NOT NULL,
  `FirstName` varchar(50) NOT NULL,
  `LastName` varchar(50) NOT NULL,
  `Email` varchar(100) NOT NULL,
  `PhoneNumber` varchar(15) DEFAULT NULL,
  `Address` text DEFAULT NULL,
  `DateOfBirth` date DEFAULT NULL,
  `RegionID` int(11) DEFAULT NULL,
  `DateJoined` timestamp NOT NULL DEFAULT current_timestamp(),
  `LastLogin` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `churnguard_customers`
--

INSERT INTO `churnguard_customers` (`CustomerID`, `FirstName`, `LastName`, `Email`, `PhoneNumber`, `Address`, `DateOfBirth`, `RegionID`, `DateJoined`, `LastLogin`) VALUES
(1, 'John', 'Doe', 'john.doe@example.com', '+1-555-1234', '123 Main St, New York, NY', '1990-01-15', 1, '2020-12-07 21:13:12', '2024-12-07 21:13:12'),
(2, 'Jane', 'Smith', 'jane.smith@example.com', '+44-555-5678', '45 Baker St, London', '1985-03-22', 2, '2019-12-07 21:13:12', '2024-12-07 21:13:12'),
(3, 'Raj', 'Patel', 'raj.patel@example.com', '+91-555-8765', '12 MG Road, Bangalore', '1992-11-30', 3, '2022-12-07 21:13:12', '2024-12-07 21:13:12'),
(4, 'Thabo', 'Mokoena', 'thabo.mokoena@example.com', '+27-555-2345', '234 Main Road, Johannesburg', '1994-08-19', 4, '2016-12-07 21:13:12', '2024-12-07 21:13:12'),
(5, 'Maria', 'Lopez', 'maria.lopez@example.com', '+55-555-7890', '789 Avenida Paulista, Sao Paulo', '1988-12-02', 5, '2021-12-07 21:13:12', '2024-12-07 21:13:12'),
(11, 'Michael', 'Taylor', 'michael.taylor@example.com', '+1-555-2233', '123 Oak St, Chicago, IL', '1988-07-11', 1, '2022-12-08 01:33:19', '2024-12-08 01:33:19'),
(12, 'Emily', 'Johnson', 'emily.johnson@example.com', '+44-555-8877', '56 Queen St, London', '1990-02-25', 2, '2023-12-08 01:33:19', '2024-12-08 01:33:19'),
(13, 'Sandeep', 'Kumar', 'sandeep.kumar@example.com', '+91-555-4321', '56 Janpath Road, Delhi', '1993-04-18', 3, '2024-12-08 01:33:19', '2024-12-08 01:33:19'),
(14, 'Lunga', 'Dlamini', 'lunga.dlamini@example.com', '+27-555-9876', '12 Park Rd, Cape Town', '1987-09-03', 4, '2024-12-08 01:33:19', '2024-12-08 01:33:19'),
(15, 'Carla', 'Gonzalez', 'carla.gonzalez@example.com', '+55-555-1234', '98 Rio Ave, Rio de Janeiro', '1991-06-10', 5, '2020-12-08 01:33:19', '2024-12-08 01:33:19'),
(16, 'Alice', 'Parker', 'alice.parker@example.com', '+1-555-6543', '73 Elm St, New York, NY', '1992-10-15', 1, '2022-12-08 01:33:19', '2024-12-08 01:33:19'),
(17, 'Ayesha', 'Shah', 'ayesha.shah@example.com', '+91-555-6789', '23 Emaar Road, Mumbai', '1989-01-27', 3, '2024-12-08 01:33:19', '2024-12-08 01:33:19'),
(18, 'Nomsa', 'Mthembu', 'nomsa.mthembu@example.com', '+27-555-4567', '87 Durban St, Durban', '1995-03-09', 4, '2023-03-08 01:33:19', '2024-12-08 01:33:19'),
(19, 'Andre', 'Silva', 'andre.silva@example.com', '+55-555-8765', '54 Avenida Rio, Brasilia', '1994-11-17', 5, '2010-12-08 01:33:19', '2024-12-08 01:33:19'),
(20, 'Isabelle', 'Dubois', 'isabelle.dubois@example.com', '+33-555-9876', '12 Rue de Paris, Paris', '1990-12-02', 6, '2024-12-08 01:33:19', '2024-12-08 01:33:19');

-- --------------------------------------------------------
INSERT INTO `churnguard_customer_complaints` (`ComplaintID`, `CustomerID`, `IssueID`, `ComplaintDate`, `ResolvedStatus`, `ResolvedDate`, `Priority`) VALUES
(6, 6, 1, '2024-01-01', 'Resolved', '2024-12-14', 'Medium'),
(7, 7, 2, '2024-02-10', 'Resolved', '2024-12-14', 'Low'),
(8, 8, 3, '2024-03-05', 'Resolved', '2024-12-14', 'Low'),
(9, 9, 4, '2024-04-18', 'Resolved', '2024-12-14', 'Low'),
(10, 10, 5, '2024-05-25', 'Resolved', '2024-12-14', 'Low');
--
-- Table structure for table `churnguard_customer_accounts`
--

CREATE TABLE `churnguard_customer_accounts` (
  `AccountID` int(11) NOT NULL,
  `CustomerID` int(11) NOT NULL,
  `AccountTypeID` int(11) NOT NULL,
  `AccountNumber` varchar(20) NOT NULL,
  `Balance` decimal(15,2) DEFAULT 0.00,
  `OpenedAt` timestamp NOT NULL DEFAULT current_timestamp(),
  `account_status` enum('Active','Inactive') DEFAULT 'Inactive'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `churnguard_customer_accounts`
--

INSERT INTO `churnguard_customer_accounts` (`AccountID`, `CustomerID`, `AccountTypeID`, `AccountNumber`, `Balance`, `OpenedAt`, `account_status`) VALUES
(1, 1, 1, 'ACC123456', 5000.00, '2024-12-07 21:13:12', 'Inactive'),
(2, 2, 2, 'ACC234567', 1500.00, '2024-12-07 21:13:12', 'Active'),
(3, 3, 3, 'ACC345678', 3000.00, '2024-12-07 21:13:12', 'Inactive'),
(4, 4, 2, 'ACC456789', 1200.00, '2024-12-07 21:13:12', 'Active'),
(5, 5, 1, 'ACC567890', 4000.00, '2024-12-07 21:13:12', 'Inactive'),
(6, 11, 1, 'ACC112233', 3500.00, '2024-12-08 01:58:04', 'Inactive'),
(7, 12, 2, 'ACC223344', 2200.00, '2024-12-08 01:58:04', 'Active'),
(8, 13, 3, 'ACC334455', 5000.00, '2024-12-08 01:58:04', 'Inactive'),
(9, 14, 2, 'ACC445566', 800.00, '2024-12-08 01:58:04', 'Active'),
(10, 15, 1, 'ACC556677', 3500.00, '2024-12-08 01:58:04', 'Inactive'),
(11, 16, 1, 'ACC667788', 4500.00, '2024-12-08 01:58:04', 'Active'),
(12, 17, 3, 'ACC778899', 6000.00, '2024-12-08 01:58:04', 'Inactive'),
(13, 18, 2, 'ACC889900', 1500.00, '2024-12-08 01:58:04', 'Active'),
(14, 19, 1, 'ACC990011', 4800.00, '2024-12-08 01:58:04', 'Inactive'),
(15, 20, 3, 'ACC101112', 7000.00, '2024-12-08 01:58:04', 'Active');

-- --------------------------------------------------------

--
-- Table structure for table `churnguard_customer_churns`
--

CREATE TABLE `churnguard_customer_churns` (
  `churnID` int(11) NOT NULL,
  `customerID` int(11) NOT NULL,
  `churnDate` date NOT NULL,
  `reason` varchar(255) DEFAULT NULL,
  `status` enum('churned','active') DEFAULT 'churned'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `churnguard_customer_churns`
--

INSERT INTO `churnguard_customer_churns` (`churnID`, `customerID`, `churnDate`, `reason`, `status`) VALUES
(1, 11, '2024-01-05', 'Switching to a competitor', 'churned'),
(2, 12, '2024-12-06', 'Dissatisfaction with service', 'churned'),
(3, 13, '2024-12-07', 'High fees', 'churned'),
(4, 14, '2024-02-08', 'Personal financial issues', 'churned'),
(5, 15, '2024-12-09', 'No longer needed the service', 'churned'),
(6, 16, '2024-12-10', 'Moved to a new location', 'churned'),
(7, 17, '2024-07-11', 'Found better offer elsewhere', 'churned'),
(8, 18, '2024-12-12', 'Account inactivity', 'churned'),
(9, 19, '2024-12-13', 'Poor customer support', 'churned'),
(10, 20, '2024-12-14', 'Lack of features', 'churned');

-- --------------------------------------------------------

--
-- Table structure for table `churnguard_customer_complaints`
--

CREATE TABLE `churnguard_customer_complaints` (
  `ComplaintID` int(11) NOT NULL,
  `CustomerID` int(11) NOT NULL,
  `IssueID` int(11) NOT NULL,
  `ComplaintDate` date DEFAULT NULL,
  `ResolvedStatus` enum('Resolved','Unresolved') DEFAULT 'Unresolved',
  `ResolvedDate` date DEFAULT NULL,
  `Priority` enum('Low','Medium','High') DEFAULT 'Low'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `churnguard_customer_complaints`
--

INSERT INTO `churnguard_customer_complaints` (`ComplaintID`, `CustomerID`, `IssueID`, `ComplaintDate`, `ResolvedStatus`, `ResolvedDate`, `Priority`) VALUES
(1, 1, 1, '2024-01-01', 'Resolved', '2024-12-14', 'Medium'),
(2, 2, 2, '2024-02-10', 'Resolved', '2024-12-14', 'Low'),
(3, 3, 3, '2024-03-05', 'Resolved', '2024-12-14', 'Low'),
(4, 4, 4, '2024-04-18', 'Resolved', '2024-12-14', 'Low'),
(5, 5, 5, '2024-05-25', 'Resolved', '2024-12-14', 'Low');

-- --------------------------------------------------------

--
-- Table structure for table `churnguard_customer_demographics`
--

CREATE TABLE `churnguard_customer_demographics` (
  `CustomerDemographicID` int(11) NOT NULL,
  `CustomerID` int(11) NOT NULL,
  `Age` int(11) DEFAULT NULL,
  `Gender` enum('M','F','Other') DEFAULT NULL,
  `IncomeLevel` enum('Low','Medium','High') DEFAULT NULL,
  `DateJoined` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `churnguard_customer_demographics`
--

INSERT INTO `churnguard_customer_demographics` (`CustomerDemographicID`, `CustomerID`, `Age`, `Gender`, `IncomeLevel`, `DateJoined`) VALUES
(1, 1, 34, 'M', 'High', '2020-05-01'),
(2, 2, 39, 'F', 'Medium', '2018-02-15'),
(3, 3, 32, 'M', 'Medium', '2021-07-10'),
(4, 4, 29, 'M', 'Low', '2022-06-05'),
(5, 5, 36, 'F', 'High', '2020-11-12'),
(33, 11, 32, 'F', 'Low', '2020-07-07'),
(34, 12, 27, 'F', 'Medium', '2021-10-21'),
(35, 13, 36, 'M', 'High', '2019-05-10'),
(36, 14, 38, 'F', 'Medium', '2022-08-25'),
(37, 15, 29, 'M', 'Low', '2021-11-30'),
(38, 16, 35, 'M', 'High', '2021-05-30'),
(39, 17, 30, 'F', 'Medium', '2019-09-05'),
(40, 18, 26, 'M', 'Low', '2020-11-01'),
(41, 19, 33, 'F', 'Medium', '2021-03-22'),
(42, 20, 31, 'M', 'High', '2022-02-14');

-- --------------------------------------------------------

--
-- Table structure for table `churnguard_customer_reviews`
--

CREATE TABLE `churnguard_customer_reviews` (
  `ReviewID` int(11) NOT NULL,
  `CustomerID` int(11) NOT NULL,
  `OverallSatisfaction` int(11) DEFAULT NULL CHECK (`OverallSatisfaction` between 1 and 5),
  `RecommendationLikelihood` int(11) DEFAULT NULL CHECK (`RecommendationLikelihood` between 1 and 5),
  `comments` text DEFAULT NULL,
  `SentimentLabel` enum('Negative','Neutral','Positive') DEFAULT NULL,
  `FollowUpContact` tinyint(1) DEFAULT 0,
  `CreatedAt` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `churnguard_customer_reviews`
--

INSERT INTO `churnguard_customer_reviews` (`ReviewID`, `CustomerID`, `OverallSatisfaction`, `RecommendationLikelihood`, `comments`, `SentimentLabel`, `FollowUpContact`, `CreatedAt`) VALUES
(1, 1, 5, 5, 'Excellent service, highly recommend.', 'Positive', 0, '2024-12-07 21:13:12'),
(2, 2, 3, 3, 'Okay service, could improve.', 'Neutral', 0, '2024-12-07 21:13:12'),
(3, 3, 2, 2, 'Very dissatisfied, will not recommend.', 'Negative', 0, '2024-01-07 21:13:12'),
(4, 4, 4, 4, 'Good experience, minor issues with ATM.', 'Neutral', 0, '2024-12-07 21:13:12'),
(5, 5, 5, 5, 'Fantastic experience, will definitely recommend.', 'Positive', 0, '2024-06-07 21:13:12');

-- --------------------------------------------------------

--
-- Table structure for table `churnguard_employees`
--

CREATE TABLE `churnguard_employees` (
  `EmployeeID` int(11) NOT NULL,
  `FirstName` varchar(255) NOT NULL,
  `LastName` varchar(255) NOT NULL,
  `Email` varchar(255) NOT NULL,
  `Password` varchar(255) NOT NULL,
  `Role` enum('Employee','Admin') NOT NULL DEFAULT 'Employee',
  `CreatedAt` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `churnguard_employees`
--

INSERT INTO `churnguard_employees` (`EmployeeID`, `FirstName`, `LastName`, `Email`, `Password`, `Role`, `CreatedAt`) VALUES
(1, 'Alice', 'Johnson', 'alice.johnson@example.com', 'admin123', 'Admin', '2024-12-07 21:13:12'),
(2, 'Bob', 'Martin', 'bob.martin@example.com', 'employee123', 'Employee', '2024-12-07 21:13:12'),
(3, 'Charlie', 'Williams', 'charlie.williams@example.com', 'employee123', 'Employee', '2024-12-07 21:13:12'),
(4, 'Diana', 'Taylor', 'diana.taylor@example.com', 'admin123', 'Admin', '2024-12-07 21:13:12'),
(5, 'Edward', 'Brown', 'edward.brown@example.com', 'employee123', 'Employee', '2024-12-07 21:13:12'),
(6, 'Daisy', 'Tsenesa', 'daisy.tsenesa@gmail.com', '$2y$10$o6JCQSUYA1Dbzi46fAvYDuy85sLX7GHKzN6ArEoJGsNDsRoiXyLx6', 'Employee', '2024-12-07 22:14:15');

-- --------------------------------------------------------

--
-- Table structure for table `churnguard_regions`
--

CREATE TABLE `churnguard_regions` (
  `RegionID` int(11) NOT NULL,
  `RegionName` varchar(100) NOT NULL,
  `Country` varchar(100) DEFAULT NULL,
  `RegionDescription` varchar(255) DEFAULT NULL,
  `CustomerCount` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `churnguard_regions`
--

INSERT INTO `churnguard_regions` (`RegionID`, `RegionName`, `Country`, `RegionDescription`, `CustomerCount`) VALUES
(1, 'North America', 'USA', 'Includes USA and Canada', 200),
(2, 'Europe', 'Germany', 'Central European region', 150),
(3, 'Asia Pacific', 'India', 'Asia Pacific region', 300),
(4, 'Africa', 'South Africa', 'African continent', 100),
(5, 'South America', 'Brazil', 'Latin American region', 50),
(6, 'North America', 'USA', 'Includes USA and Canada', 200),
(7, 'Europe', 'Germany', 'Central European region', 150),
(8, 'Asia Pacific', 'India', 'Asia Pacific region', 300),
(9, 'Africa', 'South Africa', 'African continent', 100),
(10, 'South America', 'Brazil', 'Latin American region', 50);

-- --------------------------------------------------------

--
-- Table structure for table `churnguard_transactions`
--

CREATE TABLE `churnguard_transactions` (
  `TransactionID` int(11) NOT NULL,
  `CustomerID` int(11) NOT NULL,
  `TransactionDate` timestamp NOT NULL DEFAULT current_timestamp(),
  `TransactionAmount` decimal(15,2) DEFAULT NULL,
  `TransactionType` enum('Deposit','Withdrawal','Payment','Transfer') DEFAULT NULL,
  `BalanceAfterTransaction` decimal(15,2) DEFAULT NULL,
  `BranchLocation` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `churnguard_transactions`
--

INSERT INTO `churnguard_transactions` (`TransactionID`, `CustomerID`, `TransactionDate`, `TransactionAmount`, `TransactionType`, `BalanceAfterTransaction`, `BranchLocation`) VALUES
(1, 1, '2024-12-07 21:13:12', 1000.00, 'Deposit', 5000.00, 'NYC Main Branch'),
(2, 2, '2024-12-07 21:13:12', 200.00, 'Withdrawal', 1500.00, 'London Central Branch'),
(3, 3, '2024-12-07 21:13:12', 500.00, 'Transfer', 3000.00, 'Bangalore Main Branch'),
(4, 4, '2024-12-07 21:13:12', 150.00, 'Deposit', 1200.00, 'Johannesburg East Branch'),
(5, 5, '2024-12-07 21:13:12', 800.00, 'Payment', 4000.00, 'Sao Paulo West Branch');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `churnguard_account_types`
--
ALTER TABLE `churnguard_account_types`
  ADD PRIMARY KEY (`AccountTypeID`);

--
-- Indexes for table `churnguard_bank_issues`
--
ALTER TABLE `churnguard_bank_issues`
  ADD PRIMARY KEY (`IssueID`);

--
-- Indexes for table `churnguard_churn_prediction`
--
ALTER TABLE `churnguard_churn_prediction`
  ADD PRIMARY KEY (`PredictionID`),
  ADD KEY `CustomerID` (`CustomerID`);

--
-- Indexes for table `churnguard_customers`
--
ALTER TABLE `churnguard_customers`
  ADD PRIMARY KEY (`CustomerID`),
  ADD UNIQUE KEY `Email` (`Email`),
  ADD KEY `RegionID` (`RegionID`);

--
-- Indexes for table `churnguard_customer_accounts`
--
ALTER TABLE `churnguard_customer_accounts`
  ADD PRIMARY KEY (`AccountID`),
  ADD UNIQUE KEY `AccountNumber` (`AccountNumber`),
  ADD KEY `CustomerID` (`CustomerID`),
  ADD KEY `AccountTypeID` (`AccountTypeID`);

--
-- Indexes for table `churnguard_customer_churns`
--
ALTER TABLE `churnguard_customer_churns`
  ADD PRIMARY KEY (`churnID`),
  ADD KEY `customerID` (`customerID`);

--
-- Indexes for table `churnguard_customer_complaints`
--
ALTER TABLE `churnguard_customer_complaints`
  ADD PRIMARY KEY (`ComplaintID`),
  ADD KEY `CustomerID` (`CustomerID`),
  ADD KEY `IssueID` (`IssueID`);

--
-- Indexes for table `churnguard_customer_demographics`
--
ALTER TABLE `churnguard_customer_demographics`
  ADD PRIMARY KEY (`CustomerDemographicID`),
  ADD KEY `CustomerID` (`CustomerID`);

--
-- Indexes for table `churnguard_customer_reviews`
--
ALTER TABLE `churnguard_customer_reviews`
  ADD PRIMARY KEY (`ReviewID`),
  ADD KEY `CustomerID` (`CustomerID`);

--
-- Indexes for table `churnguard_employees`
--
ALTER TABLE `churnguard_employees`
  ADD PRIMARY KEY (`EmployeeID`);

--
-- Indexes for table `churnguard_regions`
--
ALTER TABLE `churnguard_regions`
  ADD PRIMARY KEY (`RegionID`);

--
-- Indexes for table `churnguard_transactions`
--
ALTER TABLE `churnguard_transactions`
  ADD PRIMARY KEY (`TransactionID`),
  ADD KEY `CustomerID` (`CustomerID`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `churnguard_account_types`
--
ALTER TABLE `churnguard_account_types`
  MODIFY `AccountTypeID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `churnguard_bank_issues`
--
ALTER TABLE `churnguard_bank_issues`
  MODIFY `IssueID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `churnguard_churn_prediction`
--
ALTER TABLE `churnguard_churn_prediction`
  MODIFY `PredictionID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT for table `churnguard_customers`
--
ALTER TABLE `churnguard_customers`
  MODIFY `CustomerID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT for table `churnguard_customer_accounts`
--
ALTER TABLE `churnguard_customer_accounts`
  MODIFY `AccountID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT for table `churnguard_customer_churns`
--
ALTER TABLE `churnguard_customer_churns`
  MODIFY `churnID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `churnguard_customer_complaints`
--
ALTER TABLE `churnguard_customer_complaints`
  MODIFY `ComplaintID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `churnguard_customer_demographics`
--
ALTER TABLE `churnguard_customer_demographics`
  MODIFY `CustomerDemographicID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=43;

--
-- AUTO_INCREMENT for table `churnguard_customer_reviews`
--
ALTER TABLE `churnguard_customer_reviews`
  MODIFY `ReviewID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `churnguard_employees`
--
ALTER TABLE `churnguard_employees`
  MODIFY `EmployeeID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `churnguard_regions`
--
ALTER TABLE `churnguard_regions`
  MODIFY `RegionID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `churnguard_transactions`
--
ALTER TABLE `churnguard_transactions`
  MODIFY `TransactionID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `churnguard_churn_prediction`
--
ALTER TABLE `churnguard_churn_prediction`
  ADD CONSTRAINT `churnguard_churn_prediction_ibfk_1` FOREIGN KEY (`CustomerID`) REFERENCES `churnguard_customers` (`CustomerID`);

--
-- Constraints for table `churnguard_customers`
--
ALTER TABLE `churnguard_customers`
  ADD CONSTRAINT `churnguard_customers_ibfk_1` FOREIGN KEY (`RegionID`) REFERENCES `churnguard_regions` (`RegionID`);

--
-- Constraints for table `churnguard_customer_accounts`
--
ALTER TABLE `churnguard_customer_accounts`
  ADD CONSTRAINT `churnguard_customer_accounts_ibfk_1` FOREIGN KEY (`CustomerID`) REFERENCES `churnguard_customers` (`CustomerID`),
  ADD CONSTRAINT `churnguard_customer_accounts_ibfk_2` FOREIGN KEY (`AccountTypeID`) REFERENCES `churnguard_account_types` (`AccountTypeID`);

--
-- Constraints for table `churnguard_customer_churns`
--
ALTER TABLE `churnguard_customer_churns`
  ADD CONSTRAINT `churnguard_customer_churns_ibfk_1` FOREIGN KEY (`customerID`) REFERENCES `churnguard_customers` (`CustomerID`);

--
-- Constraints for table `churnguard_customer_complaints`
--
ALTER TABLE `churnguard_customer_complaints`
  ADD CONSTRAINT `churnguard_customer_complaints_ibfk_1` FOREIGN KEY (`CustomerID`) REFERENCES `churnguard_customers` (`CustomerID`),
  ADD CONSTRAINT `churnguard_customer_complaints_ibfk_2` FOREIGN KEY (`IssueID`) REFERENCES `churnguard_bank_issues` (`IssueID`);

--
-- Constraints for table `churnguard_customer_demographics`
--
ALTER TABLE `churnguard_customer_demographics`
  ADD CONSTRAINT `churnguard_customer_demographics_ibfk_1` FOREIGN KEY (`CustomerID`) REFERENCES `churnguard_customers` (`CustomerID`);

--
-- Constraints for table `churnguard_customer_reviews`
--
ALTER TABLE `churnguard_customer_reviews`
  ADD CONSTRAINT `churnguard_customer_reviews_ibfk_1` FOREIGN KEY (`CustomerID`) REFERENCES `churnguard_customers` (`CustomerID`);

--
-- Constraints for table `churnguard_transactions`
--
ALTER TABLE `churnguard_transactions`
  ADD CONSTRAINT `churnguard_transactions_ibfk_1` FOREIGN KEY (`CustomerID`) REFERENCES `churnguard_customers` (`CustomerID`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
