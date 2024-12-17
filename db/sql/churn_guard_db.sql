-- phpMyAdmin SQL Dump
-- version 5.2.1deb3
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Dec 17, 2024 at 07:15 PM
-- Server version: 8.0.40-0ubuntu0.24.04.1
-- PHP Version: 8.3.6

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `webtech_fall2024_daisy_tsenesa`
--

-- --------------------------------------------------------

--
-- Table structure for table `churnguard_account_types`
--

CREATE TABLE `churnguard_account_types` (
  `AccountTypeID` int NOT NULL,
  `AccountTypeName` varchar(50) COLLATE utf8mb4_general_ci NOT NULL,
  `InterestRate` decimal(5,2) DEFAULT NULL,
  `CreatedAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `churnguard_account_types`
--

INSERT INTO `churnguard_account_types` (`AccountTypeID`, `AccountTypeName`, `InterestRate`, `CreatedAt`) VALUES
(1, 'Savings', 2.50, '2024-12-07 21:13:12'),
(2, 'Checking', 1.00, '2024-12-07 21:13:12'),
(3, 'Credit', 4.00, '2024-12-07 21:13:12');

-- --------------------------------------------------------

--
-- Table structure for table `churnguard_bank_issues`
--

CREATE TABLE `churnguard_bank_issues` (
  `IssueID` int NOT NULL,
  `IssueType` enum('Product','Service','Billing','Other') COLLATE utf8mb4_general_ci DEFAULT NULL,
  `IssueDescription` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `churnguard_bank_issues`
--

INSERT INTO `churnguard_bank_issues` (`IssueID`, `IssueType`, `IssueDescription`) VALUES
(1, 'Product', 'Customer unable to access mobile banking app.'),
(2, 'Service', 'Delayed response from customer support.'),
(3, 'Billing', 'Incorrect charges on monthly statement.'),
(4, 'Other', 'ATM machine malfunctioned.'),
(5, 'Product', 'Online banking transaction failed.');

-- --------------------------------------------------------

--
-- Table structure for table `churnguard_churn_prediction`
--

CREATE TABLE `churnguard_churn_prediction` (
  `PredictionID` int NOT NULL,
  `CustomerID` int NOT NULL,
  `PredictionDate` date DEFAULT NULL,
  `ChurnProbability` decimal(3,2) DEFAULT NULL,
  `RiskLevel` enum('Low','Medium','High') COLLATE utf8mb4_general_ci DEFAULT NULL,
  `PredictionNotes` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `churnguard_churn_prediction`
--

INSERT INTO `churnguard_churn_prediction` (`PredictionID`, `CustomerID`, `PredictionDate`, `ChurnProbability`, `RiskLevel`, `PredictionNotes`) VALUES
(1, 1, '2023-06-01', 0.15, 'Low', 'Stable account with good history'),
(2, 2, '2023-07-04', 0.25, 'Low', 'Frequent transactions, no major issues'),
(3, 3, '2023-08-19', 0.35, 'Medium', 'Some complaints, but loyal customer'),
(4, 4, '2023-09-10', 0.50, 'Medium', 'Several service interactions, but still engaged'),
(5, 5, '2023-10-20', 0.20, 'Low', 'Consistent payments and positive history'),
(6, 6, '2023-11-12', 0.60, 'High', 'Multiple unresolved issues, likely to churn'),
(7, 7, '2023-12-03', 0.30, 'Medium', 'Medium satisfaction, moderate account usage'),
(8, 8, '2024-01-15', 0.75, 'High', 'Frequent complaints, negative account behavior'),
(9, 9, '2024-02-07', 0.10, 'Low', 'Long-term stable account with few issues'),
(10, 10, '2024-03-21', 0.55, 'Medium', 'Inconsistent usage patterns, still active'),
(11, 11, '2023-05-17', 0.40, 'Medium', 'Average activity and minor complaints'),
(12, 12, '2023-06-22', 0.80, 'High', 'Dissatisfaction and declining engagement'),
(13, 13, '2023-07-09', 0.15, 'Low', 'Positive transactions and good account history'),
(14, 14, '2023-08-25', 0.65, 'High', 'Multiple unresolved complaints, negative feedback'),
(15, 15, '2023-09-18', 0.50, 'Medium', 'Slight decline in engagement, but no major issues'),
(16, 16, '2023-10-10', 0.20, 'Low', 'Active account, few issues reported'),
(17, 17, '2023-11-02', 0.60, 'High', 'Customer has missed several payments and complaints'),
(18, 18, '2023-12-11', 0.30, 'Medium', 'Occasional complaints, but account remains active'),
(19, 19, '2024-01-05', 0.25, 'Low', 'Stable account, good history of interactions'),
(20, 20, '2024-02-15', 0.50, 'Medium', 'Customer has been unresponsive to recent attempts'),
(21, 21, '2024-03-03', 0.10, 'Low', 'Good account with few service requests'),
(22, 22, '2024-04-09', 0.45, 'Medium', 'Customer shows some dissatisfaction with service'),
(23, 23, '2024-05-25', 0.35, 'Medium', 'Frequent service issues, still retained'),
(24, 24, '2024-06-01', 0.70, 'High', 'Declining usage and several complaints'),
(25, 25, '2023-07-30', 0.55, 'Medium', 'Average activity with occasional complaints'),
(26, 26, '2023-08-16', 0.20, 'Low', 'No major complaints, consistent activity'),
(27, 27, '2023-09-04', 0.10, 'Low', 'Long-term account with no service issues'),
(28, 28, '2023-10-19', 0.65, 'High', 'Negative feedback and declining engagement'),
(29, 29, '2023-11-29', 0.50, 'Medium', 'Some complaints but still active'),
(30, 30, '2024-01-14', 0.30, 'Medium', 'Some dissatisfaction, moderate activity'),
(31, 31, '2024-02-27', 0.75, 'High', 'Customer has had significant issues and complaints'),
(32, 32, '2024-03-15', 0.45, 'Medium', 'Occasional issues, still engaged with service'),
(33, 33, '2024-04-20', 0.35, 'Medium', 'Customer has issues with service quality'),
(34, 34, '2024-05-13', 0.60, 'High', 'Declining engagement and several complaints'),
(35, 35, '2024-06-04', 0.25, 'Low', 'Positive feedback and consistent payments'),
(36, 36, '2023-07-14', 0.10, 'Low', 'Good history, minimal complaints'),
(37, 37, '2023-08-05', 0.50, 'Medium', 'Slight decline in usage, minor complaints'),
(38, 38, '2023-09-12', 0.20, 'Low', 'Consistent payments, few complaints'),
(39, 39, '2024-01-01', 0.80, 'High', 'Customer is extremely dissatisfied and unresponsive'),
(40, 40, '2024-02-05', 0.40, 'Medium', 'Some service issues but still engaged');

-- --------------------------------------------------------

--
-- Table structure for table `churnguard_customers`
--

CREATE TABLE `churnguard_customers` (
  `CustomerID` int NOT NULL,
  `FirstName` varchar(50) COLLATE utf8mb4_general_ci NOT NULL,
  `LastName` varchar(50) COLLATE utf8mb4_general_ci NOT NULL,
  `Email` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  `PhoneNumber` varchar(15) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `Address` text COLLATE utf8mb4_general_ci,
  `DateOfBirth` date DEFAULT NULL,
  `RegionID` int DEFAULT NULL,
  `DateJoined` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `LastLogin` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `churnguard_customers`
--

INSERT INTO `churnguard_customers` (`CustomerID`, `FirstName`, `LastName`, `Email`, `PhoneNumber`, `Address`, `DateOfBirth`, `RegionID`, `DateJoined`, `LastLogin`) VALUES
(1, 'Kudzai', 'Tsenesa', 'kudzai.tsenesa@gmail.com', '+1-555-1234', '123 Main St, Harare, Zimbabwe', '1990-01-15', 1, '2020-12-07 21:13:12', '2024-12-07 21:13:12'),
(2, 'Jane', 'Smith', 'jane.smith@example.com', '+44-555-5678', '45 Baker St, London', '1985-03-22', 2, '2019-12-07 21:13:12', '2024-12-07 21:13:12'),
(3, 'Raj', 'Patel', 'raj.patel@example.com', '+91-555-8765', '12 MG Road, Bangalore', '1992-11-30', 3, '2022-12-07 21:13:12', '2024-12-07 21:13:12'),
(4, 'Thabo', 'Mokoena', 'thabo.mokoena@example.com', '+27-555-2345', '234 Main Road, Johannesburg', '1994-08-19', 3, '2016-12-07 21:13:12', '2024-12-07 21:13:12'),
(5, 'Maria', 'Lopez', 'maria.lopez@example.com', '+55-555-7890', '789 Avenida Paulista, Sao Paulo', '1988-12-02', 3, '2021-12-07 21:13:12', '2024-12-07 21:13:12'),
(6, 'John', 'Williams', 'john.williams@example.com', '+1-555-1234', '123 Main St, New York, NY', '1990-01-15', 1, '2020-12-07 21:13:12', '2024-12-07 21:13:12'),
(7, 'Jaden', 'Smith', 'jaden.smith@example.com', '+44-555-5678', '45 Baker St, London', '1985-03-22', 2, '2019-12-07 21:13:12', '2024-12-07 21:13:12'),
(8, 'Raph', 'Willard', 'raph.patel@example.com', '+91-555-8765', '12 MG Road, Bangalore', '1992-11-30', 3, '2022-12-07 21:13:12', '2024-12-07 21:13:12'),
(9, 'Thabo', 'Makwena', 'thabo@example.com', '+27-555-2345', '234 Main Road, Johannesburg', '1994-08-19', 3, '2016-12-07 21:13:12', '2024-12-07 21:13:12'),
(10, 'Mariam', 'Lopech', 'lopech@example.com', '+55-555-7890', '789 Avenida Paulista, Sao Paulo', '1988-12-02', 3, '2021-12-07 21:13:12', '2024-12-07 21:13:12'),
(11, 'Michael', 'Taylor', 'michael.taylor@example.com', '+1-555-2233', '123 Oak St, Chicago, IL', '1988-07-11', 1, '2022-12-08 01:33:19', '2024-12-08 01:33:19'),
(12, 'Emily', 'Johnson', 'emily.johnson@example.com', '+44-555-8877', '56 Queen St, London', '1990-02-25', 2, '2023-12-08 01:33:19', '2024-12-08 01:33:19'),
(13, 'Sandeep', 'Kumar', 'sandeep.kumar@example.com', '+91-555-4321', '56 Janpath Road, Delhi', '1993-04-18', 3, '2024-12-08 01:33:19', '2024-12-08 01:33:19'),
(14, 'Lunga', 'Dlamini', 'lunga.dlamini@example.com', '+27-555-9876', '12 Park Rd, Cape Town', '1987-09-03', 3, '2024-12-08 01:33:19', '2024-12-08 01:33:19'),
(15, 'Carla', 'Gonzalez', 'carla.gonzalez@example.com', '+55-555-1234', '98 Rio Ave, Rio de Janeiro', '1991-06-10', 3, '2020-12-08 01:33:19', '2024-12-08 01:33:19'),
(16, 'Alice', 'Parker', 'alice.parker@example.com', '+1-555-6543', '73 Elm St, New York, NY', '1992-10-15', 1, '2022-12-08 01:33:19', '2024-12-08 01:33:19'),
(17, 'Ayesha', 'Shah', 'ayesha.shah@example.com', '+91-555-6789', '23 Emaar Road, Mumbai', '1989-01-27', 3, '2024-12-08 01:33:19', '2024-12-08 01:33:19'),
(18, 'Nomsa', 'Mthembu', 'nomsa.mthembu@example.com', '+27-555-4567', '87 Durban St, Durban', '1995-03-09', 3, '2023-03-08 01:33:19', '2024-12-08 01:33:19'),
(19, 'Andre', 'Silva', 'andre.silva@example.com', '+55-555-8765', '54 Avenida Rio, Brasilia', '1994-11-17', 3, '2010-12-08 01:33:19', '2024-12-08 01:33:19'),
(20, 'Isabelle', 'Dubois', 'isabelle.dubois@example.com', '+33-555-9876', '12 Rue de Paris, Paris', '1990-12-02', 3, '2024-12-08 01:33:19', '2024-12-08 01:33:19'),
(21, 'Tariro', 'Chikosha', 'tariro.chikosha@example.com', '+263-771-1234', '45 Samora Machel, Harare, Zimbabwe', '1982-02-14', 1, '2016-05-18 10:23:45', '2024-03-15 12:11:22'),
(22, 'Kwame', 'Mensah', 'kwame.mensah@example.com', '+233-548-5678', '23 Independence Ave, Accra, Ghana', '1996-07-25', 2, '2018-08-09 15:45:30', '2024-06-20 08:33:50'),
(23, 'Emily', 'Johnson', 'emily.johnson@gmail.com', '+1-202-456-7890', '789 Elm St, Washington, DC, USA', '2000-10-12', 3, '2019-03-12 09:25:41', '2024-04-10 16:50:18'),
(24, 'Chenai', 'Mukwena', 'chenai.mukwena@example.com', '+263-778-9876', '67 Chiremba Rd, Harare, Zimbabwe', '1974-11-05', 1, '2017-01-23 12:10:11', '2024-02-27 10:45:32'),
(25, 'Kofi', 'Asante', 'kofi.asante@example.com', '+233-550-2222', '12 Ring Road, Kumasi, Ghana', '1988-05-16', 2, '2021-10-10 20:45:00', '2024-05-18 14:22:29'),
(26, 'Brian', 'Williams', 'brian.williams@example.com', '+1-305-112-3344', '90 Ocean Drive, Miami, FL, USA', '1990-04-02', 3, '2020-06-14 11:55:30', '2024-07-09 19:15:00'),
(27, 'Rudo', 'Mujuru', 'rudo.mujuru@example.com', '+263-772-4567', '21 Jason Moyo, Bulawayo, Zimbabwe', '1965-03-10', 1, '2016-03-30 14:12:01', '2024-08-21 11:18:45'),
(28, 'Nana', 'Owusu', 'nana.owusu@example.com', '+233-544-3456', '5 Labone Street, Accra, Ghana', '1992-09-09', 2, '2022-01-11 08:45:22', '2024-09-15 20:30:33'),
(29, 'Sophia', 'Brown', 'sophia.brown@example.com', '+1-415-987-0001', '111 Market St, San Francisco, CA, USA', '1978-12-20', 3, '2017-11-05 17:15:30', '2024-01-05 23:12:19'),
(30, 'Takudzwa', 'Ncube', 'takudzwa.ncube@example.com', '+263-774-3333', '10 Herbert Chitepo, Mutare, Zimbabwe', '2001-06-17', 1, '2023-02-28 21:13:12', '2024-05-10 09:20:00'),
(31, 'Yaw', 'Boateng', 'yaw.boateng@example.com', '+233-555-9999', '45 Osei Tutu St, Cape Coast, Ghana', '1980-01-22', 2, '2018-12-11 12:30:10', '2024-07-01 18:35:22'),
(32, 'James', 'Smith', 'james.smith@example.com', '+1-212-555-1234', '20 Broadway Ave, New York, NY, USA', '1994-07-07', 3, '2019-09-12 14:00:05', '2024-03-11 11:45:33'),
(33, 'Farai', 'Makoni', 'farai.makoni@example.com', '+263-775-4444', '30 Josiah Tongogara, Gweru, Zimbabwe', '1986-03-03', 1, '2017-04-17 19:21:12', '2024-06-05 08:30:00'),
(34, 'Adwoa', 'Badu', 'adwoa.badu@example.com', '+233-555-1111', '76 Castle Road, Takoradi, Ghana', '1998-05-29', 2, '2021-06-15 10:22:30', '2024-07-30 10:12:55'),
(35, 'Michael', 'Clark', 'michael.clark@example.com', '+1-718-888-4567', '55 Liberty Ave, Brooklyn, NY, USA', '1972-02-14', 3, '2016-10-22 16:45:09', '2024-08-14 12:33:18'),
(36, 'Tatenda', 'Mutasa', 'tatenda.mutasa@example.com', '+263-779-1235', '88 J. Nkomo, Masvingo, Zimbabwe', '1960-11-11', 1, '2022-07-14 13:15:22', '2024-05-22 16:10:11'),
(37, 'Kojo', 'Mensah', 'kojo.mensah@example.com', '+233-559-4444', '32 Adenta Road, Accra, Ghana', '1984-10-01', 2, '2020-12-25 11:00:30', '2024-06-15 18:30:00'),
(38, 'Jessica', 'Taylor', 'jessica.taylor@example.com', '+1-555-5678', '99 Pine St, Seattle, WA, USA', '1999-09-15', 3, '2023-09-18 20:22:11', '2024-09-01 14:45:10'),
(39, 'Chipo', 'Chivanga', 'chipo.chivanga@example.com', '+263-770-5678', '19 Angwa St, Harare, Zimbabwe', '1976-04-30', 1, '2016-02-11 08:22:12', '2024-04-05 19:10:45'),
(40, 'Kwabena', 'Nyarko', 'kwabena.nyarko@example.com', '+233-550-7777', '43 Airport Road, Sunyani, Ghana', '2002-01-01', 2, '2019-08-20 15:10:30', '2024-02-18 17:20:22');

-- --------------------------------------------------------

--
-- Table structure for table `churnguard_customer_accounts`
--

CREATE TABLE `churnguard_customer_accounts` (
  `AccountID` int NOT NULL,
  `CustomerID` int NOT NULL,
  `AccountTypeID` int NOT NULL,
  `AccountNumber` varchar(20) COLLATE utf8mb4_general_ci NOT NULL,
  `Balance` decimal(15,2) DEFAULT '0.00',
  `OpenedAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `account_status` enum('Active','Inactive') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT 'Active'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `churnguard_customer_accounts`
--

INSERT INTO `churnguard_customer_accounts` (`AccountID`, `CustomerID`, `AccountTypeID`, `AccountNumber`, `Balance`, `OpenedAt`, `account_status`) VALUES
(1, 1, 1, 'ACC0001', 1000.00, '2020-12-07 21:13:12', 'Active'),
(2, 2, 2, 'ACC0002', 2000.00, '2019-12-07 21:13:12', 'Active'),
(3, 3, 3, 'ACC0003', 1500.00, '2022-12-07 21:13:12', 'Active'),
(4, 4, 2, 'ACC0004', 1200.00, '2016-12-07 21:13:12', 'Active'),
(5, 5, 1, 'ACC0005', 3000.00, '2021-12-07 21:13:12', 'Active'),
(6, 6, 3, 'ACC0006', 500.00, '2020-12-07 21:13:12', 'Active'),
(7, 7, 2, 'ACC0007', 7000.00, '2019-12-07 21:13:12', 'Active'),
(8, 8, 1, 'ACC0008', 2500.00, '2022-12-07 21:13:12', 'Active'),
(9, 9, 3, 'ACC0009', 10000.00, '2016-12-07 21:13:12', 'Active'),
(10, 10, 2, 'ACC0010', 2000.00, '2021-12-07 21:13:12', 'Active'),
(11, 11, 1, 'ACC0011', 3500.00, '2022-12-08 01:33:19', 'Active'),
(12, 12, 3, 'ACC0012', 4500.00, '2023-12-08 01:33:19', 'Active'),
(13, 13, 2, 'ACC0013', 600.00, '2024-12-08 01:33:19', 'Active'),
(14, 14, 1, 'ACC0014', 2200.00, '2024-12-08 01:33:19', 'Active'),
(15, 15, 3, 'ACC0015', 1300.00, '2020-12-08 01:33:19', 'Active'),
(16, 16, 2, 'ACC0016', 1500.00, '2022-12-08 01:33:19', 'Active'),
(17, 17, 3, 'ACC0017', 2000.00, '2024-12-08 01:33:19', 'Active'),
(18, 18, 2, 'ACC0018', 3000.00, '2023-03-08 01:33:19', 'Active'),
(19, 19, 1, 'ACC0019', 1100.00, '2010-12-08 01:33:19', 'Active'),
(20, 20, 2, 'ACC0020', 5000.00, '2024-12-08 01:33:19', 'Active'),
(21, 21, 1, 'ACC0021', 2500.00, '2016-05-18 10:23:45', 'Active'),
(22, 22, 3, 'ACC0022', 7000.00, '2018-08-09 15:45:30', 'Active'),
(23, 23, 1, 'ACC0023', 1200.00, '2019-03-12 09:25:41', 'Active'),
(24, 24, 2, 'ACC0024', 4000.00, '2017-01-23 12:10:11', 'Active'),
(25, 25, 3, 'ACC0025', 3000.00, '2021-10-10 20:45:00', 'Active'),
(26, 26, 1, 'ACC0026', 1500.00, '2020-06-14 11:55:30', 'Active'),
(27, 27, 2, 'ACC0027', 2200.00, '2016-03-30 14:12:01', 'Active'),
(28, 28, 3, 'ACC0028', 3500.00, '2022-01-11 08:45:22', 'Active'),
(29, 29, 1, 'ACC0029', 4200.00, '2017-11-05 17:15:30', 'Active'),
(30, 30, 2, 'ACC0030', 1300.00, '2023-02-28 21:13:12', 'Active'),
(31, 31, 3, 'ACC0031', 2300.00, '2018-12-11 12:30:10', 'Active'),
(32, 32, 1, 'ACC0032', 1500.00, '2019-09-12 14:00:05', 'Active'),
(33, 33, 2, 'ACC0033', 2700.00, '2017-04-17 19:21:12', 'Active'),
(34, 34, 3, 'ACC0034', 3300.00, '2021-06-15 10:22:30', 'Active'),
(35, 35, 1, 'ACC0035', 4500.00, '2016-10-22 16:45:09', 'Active'),
(36, 36, 2, 'ACC0036', 3200.00, '2022-07-14 13:15:22', 'Active'),
(37, 37, 3, 'ACC0037', 5400.00, '2024-05-22 16:10:11', 'Active'),
(38, 38, 1, 'ACC0038', 6000.00, '2024-07-14 11:55:30', 'Active'),
(39, 39, 2, 'ACC0039', 2100.00, '2024-09-15 20:30:33', 'Active'),
(40, 40, 3, 'ACC0040', 7000.00, '2024-07-30 10:12:55', 'Active');

-- --------------------------------------------------------

--
-- Table structure for table `churnguard_customer_churns`
--

CREATE TABLE `churnguard_customer_churns` (
  `churnID` int NOT NULL,
  `customerID` int NOT NULL,
  `churnDate` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `reason` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `status` enum('churned','active') COLLATE utf8mb4_general_ci DEFAULT 'churned'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `churnguard_customer_churns`
--

INSERT INTO `churnguard_customer_churns` (`churnID`, `customerID`, `churnDate`, `reason`, `status`) VALUES
(1, 20, '2023-08-15 00:00:00', 'Dissatisfaction with service', 'churned'),
(2, 22, '2023-11-10 00:00:00', 'Switching to a competitor', 'churned'),
(3, 24, '2024-01-17 00:00:00', 'High fees', 'churned'),
(4, 26, '2023-09-22 00:00:00', 'Personal financial issues', 'churned'),
(5, 28, '2024-02-05 00:00:00', 'Poor customer support', 'churned'),
(6, 30, '2023-10-12 00:00:00', 'Dissatisfaction with service', 'churned'),
(7, 32, '2024-03-03 00:00:00', 'Switching to a competitor', 'churned'),
(8, 34, '2023-12-08 00:00:00', 'High fees', 'churned'),
(9, 36, '2023-11-25 00:00:00', 'Personal financial issues', 'churned'),
(10, 38, '2024-01-23 00:00:00', 'Dissatisfaction with service', 'churned'),
(11, 40, '2023-12-01 00:00:00', 'Switching to a competitor', 'churned'),
(19, 3, '2024-12-17 18:08:44', 'Customer no longer needs the service.', 'churned');

-- --------------------------------------------------------

--
-- Table structure for table `churnguard_customer_complaints`
--

CREATE TABLE `churnguard_customer_complaints` (
  `ComplaintID` int NOT NULL,
  `CustomerID` int NOT NULL,
  `IssueID` int DEFAULT '1',
  `ComplaintDate` date DEFAULT NULL,
  `ResolvedStatus` enum('Resolved','Unresolved') COLLATE utf8mb4_general_ci DEFAULT 'Unresolved',
  `ResolvedDate` date DEFAULT NULL,
  `Priority` enum('Low','Medium','High') COLLATE utf8mb4_general_ci DEFAULT 'Low'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `churnguard_customer_complaints`
--

INSERT INTO `churnguard_customer_complaints` (`ComplaintID`, `CustomerID`, `IssueID`, `ComplaintDate`, `ResolvedStatus`, `ResolvedDate`, `Priority`) VALUES
(1, 1, 1, '2023-02-15', 'Resolved', '2024-01-10', 'Medium'),
(2, 2, 2, '2023-07-23', 'Resolved', '2024-12-17', 'High'),
(3, 3, 3, '2024-05-10', 'Resolved', '2024-06-25', 'Low'),
(4, 4, 4, '2022-11-01', 'Unresolved', NULL, 'Low'),
(5, 5, 5, '2024-03-19', 'Resolved', '2024-08-05', 'Medium'),
(6, 6, 3, '2023-12-04', 'Unresolved', NULL, 'High'),
(7, 7, 3, '2024-01-20', 'Resolved', '2024-02-15', 'Low'),
(8, 8, 3, '2024-04-14', 'Unresolved', NULL, 'High'),
(9, 9, 3, '2023-09-28', 'Resolved', '2024-10-07', 'Medium'),
(10, 10, 3, '2022-06-30', 'Unresolved', NULL, 'Low'),
(11, 11, 3, '2024-07-12', 'Resolved', '2024-08-25', 'Medium'),
(12, 12, 3, '2023-10-09', 'Unresolved', NULL, 'High'),
(13, 13, 3, '2022-12-18', 'Resolved', '2023-02-22', 'Low'),
(14, 14, 3, '2024-03-04', 'Unresolved', NULL, 'High'),
(15, 15, 3, '2023-11-23', 'Resolved', '2024-04-01', 'Medium');

-- --------------------------------------------------------

--
-- Table structure for table `churnguard_customer_demographics`
--

CREATE TABLE `churnguard_customer_demographics` (
  `CustomerDemographicID` int NOT NULL,
  `CustomerID` int NOT NULL,
  `Age` int DEFAULT NULL,
  `Gender` enum('M','F','Other') COLLATE utf8mb4_general_ci DEFAULT NULL,
  `IncomeLevel` enum('Low','Medium','High') COLLATE utf8mb4_general_ci DEFAULT NULL,
  `DateJoined` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `churnguard_customer_demographics`
--

INSERT INTO `churnguard_customer_demographics` (`CustomerDemographicID`, `CustomerID`, `Age`, `Gender`, `IncomeLevel`, `DateJoined`) VALUES
(1, 1, 34, 'M', 'High', '2020-12-07'),
(2, 2, 39, 'F', 'Medium', '2019-12-07'),
(3, 3, 32, 'M', 'Medium', '2022-12-07'),
(4, 4, 30, 'M', 'Low', '2016-12-07'),
(5, 5, 36, 'F', 'High', '2021-12-07'),
(6, 6, 34, 'M', 'High', '2020-12-07'),
(7, 7, 39, 'M', 'Medium', '2019-12-07'),
(8, 8, 32, 'M', 'Medium', '2022-12-07'),
(9, 9, 30, 'M', 'Low', '2016-12-07'),
(10, 10, 36, 'F', 'High', '2021-12-07'),
(11, 11, 36, 'M', 'Medium', '2022-12-08'),
(12, 12, 34, 'F', 'Low', '2023-12-08'),
(13, 13, 31, 'M', 'Medium', '2024-12-08'),
(14, 14, 37, 'F', 'Medium', '2024-12-08'),
(15, 15, 33, 'F', 'Low', '2020-12-08'),
(16, 16, 32, 'F', 'High', '2022-12-08'),
(17, 17, 35, 'F', 'Medium', '2024-12-08'),
(18, 18, 29, 'F', 'Medium', '2023-03-08'),
(19, 19, 30, 'M', 'High', '2010-12-08'),
(20, 20, 34, 'F', 'High', '2024-12-08'),
(21, 21, 42, 'F', 'Low', '2016-05-18'),
(22, 22, 28, 'M', 'Medium', '2018-08-09'),
(23, 23, 24, 'F', 'High', '2019-03-12'),
(24, 24, 50, 'F', 'Low', '2017-01-23'),
(25, 25, 36, 'M', 'Medium', '2021-10-10'),
(26, 26, 34, 'M', 'High', '2020-06-14'),
(27, 27, 59, 'F', 'Medium', '2016-03-30'),
(28, 28, 32, 'M', 'Medium', '2022-01-11'),
(29, 29, 45, 'F', 'High', '2017-11-05'),
(30, 30, 23, 'M', 'Low', '2023-02-28'),
(31, 31, 44, 'M', 'Medium', '2018-12-11'),
(32, 32, 30, 'F', 'Low', '2019-09-12'),
(33, 33, 38, 'M', 'High', '2017-04-17'),
(34, 34, 26, 'F', 'Medium', '2021-06-15'),
(35, 35, 52, 'M', 'Low', '2016-10-22'),
(36, 36, 64, 'M', 'Medium', '2016-05-18'),
(37, 37, 40, 'F', 'High', '2023-06-20'),
(38, 38, 40, 'M', 'Medium', '2024-07-01'),
(39, 39, 30, 'M', 'Low', '2019-09-12'),
(40, 40, 26, 'F', 'Medium', '2021-06-15');

-- --------------------------------------------------------

--
-- Table structure for table `churnguard_customer_reviews`
--

CREATE TABLE `churnguard_customer_reviews` (
  `ReviewID` int NOT NULL,
  `CustomerID` int NOT NULL,
  `OverallSatisfaction` int DEFAULT NULL,
  `RecommendationLikelihood` int DEFAULT NULL,
  `comments` text COLLATE utf8mb4_general_ci,
  `SentimentLabel` enum('Negative','Neutral','Positive') COLLATE utf8mb4_general_ci DEFAULT NULL,
  `FollowUpContact` tinyint(1) DEFAULT '0',
  `CreatedAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ;

--
-- Dumping data for table `churnguard_customer_reviews`
--

INSERT INTO `churnguard_customer_reviews` (`ReviewID`, `CustomerID`, `OverallSatisfaction`, `RecommendationLikelihood`, `comments`, `SentimentLabel`, `FollowUpContact`, `CreatedAt`) VALUES
(1, 1, 5, 5, 'Excellent service, highly recommend.', 'Positive', 0, '2024-12-07 21:13:12'),
(2, 2, 3, 3, 'Okay service, could improve.', 'Neutral', 0, '2024-11-15 18:25:07'),
(3, 3, 2, 2, 'Very dissatisfied, will not recommend.', 'Negative', 0, '2023-05-12 13:45:33'),
(4, 4, 4, 4, 'Good experience, minor issues with ATM.', 'Neutral', 0, '2024-10-22 11:37:56'),
(5, 5, 5, 5, 'Fantastic experience, will definitely recommend.', 'Positive', 0, '2024-06-07 21:13:12'),
(6, 6, 1, 1, 'Terrible service, very disappointed.', 'Negative', 0, '2023-03-17 19:08:42'),
(7, 7, 3, 3, 'It was fine, but nothing special.', 'Neutral', 0, '2023-08-25 16:53:21'),
(8, 8, 4, 4, 'Good overall, just a few delays.', 'Neutral', 0, '2022-12-11 09:12:03'),
(9, 9, 5, 5, 'Wonderful experience, exceeded expectations.', 'Positive', 0, '2024-09-06 14:21:05'),
(10, 10, 2, 2, 'Not happy with the service, won\'t return.', 'Negative', 0, '2023-06-19 12:48:29'),
(11, 11, 5, 4, 'Great customer service, will recommend to friends.', 'Positive', 0, '2024-08-14 10:34:18'),
(12, 12, 3, 3, 'Service was average, no complaints.', 'Neutral', 0, '2023-01-20 17:02:44'),
(13, 13, 4, 4, 'Pretty good experience, some minor improvements needed.', 'Neutral', 0, '2024-07-01 08:56:47'),
(14, 14, 5, 5, 'Absolutely fantastic service, highly recommend!', 'Positive', 0, '2024-02-25 20:11:22'),
(15, 15, 2, 1, 'Very poor, would not suggest to others.', 'Negative', 0, '2023-10-30 22:45:10'),
(16, 5, 5, 5, 'Excellent service, very satisfied.', 'Positive', 0, '2024-01-05 10:30:00'),
(17, 8, 4, 4, 'Good experience overall.', 'Positive', 0, '2024-01-12 14:15:00'),
(18, 12, 2, 2, 'Service quality needs improvement.', 'Negative', 0, '2024-01-19 16:45:00'),
(19, 15, 3, 3, 'Average experience, nothing exceptional.', 'Neutral', 0, '2024-01-24 11:10:00'),
(20, 20, 4, 5, 'Great support, will recommend.', 'Positive', 0, '2024-01-29 09:20:00'),
(21, 25, 1, 1, 'Extremely dissatisfied with the service.', 'Negative', 0, '2024-01-30 20:00:00'),
(22, 30, 3, 3, 'Service was okay, no issues.', 'Neutral', 0, '2024-01-31 13:30:00'),
(23, 2, 5, 5, 'Fantastic service, very prompt.', 'Positive', 0, '2024-02-03 12:10:00'),
(24, 4, 3, 3, 'Satisfactory, room for improvement.', 'Neutral', 0, '2024-02-07 10:20:00'),
(25, 6, 4, 4, 'Pretty good experience overall.', 'Positive', 0, '2024-02-11 15:00:00'),
(26, 9, 1, 2, 'Not satisfied with the support team.', 'Negative', 0, '2024-02-17 17:45:00'),
(27, 13, 2, 2, 'Could not resolve my issue.', 'Negative', 0, '2024-02-20 09:15:00'),
(28, 18, 4, 4, 'Happy with the service provided.', 'Positive', 0, '2024-02-25 14:30:00'),
(29, 22, 3, 3, 'The overall process was average.', 'Neutral', 0, '2024-02-27 16:00:00'),
(30, 1, 5, 5, 'Outstanding customer support.', 'Positive', 0, '2024-03-02 11:00:00'),
(31, 3, 4, 4, 'Good experience, no complaints.', 'Positive', 0, '2024-03-07 13:45:00'),
(32, 7, 2, 2, 'Disappointed with the resolution time.', 'Negative', 0, '2024-03-11 15:10:00'),
(33, 11, 3, 3, 'Service was acceptable.', 'Neutral', 0, '2024-03-15 16:50:00'),
(34, 14, 5, 5, 'Wonderful service, exceeded expectations.', 'Positive', 0, '2024-03-21 08:30:00'),
(35, 19, 1, 1, 'Poor experience, very dissatisfied.', 'Negative', 0, '2024-03-25 20:10:00'),
(36, 24, 3, 3, 'Mediocre service, could be better.', 'Neutral', 0, '2024-03-29 12:20:00'),
(37, 10, 5, 5, 'Exceptional support and service.', 'Positive', 0, '2024-04-03 09:10:00'),
(38, 16, 2, 2, 'Disappointed with the experience.', 'Negative', 0, '2024-04-07 14:20:00'),
(39, 17, 4, 4, 'Good assistance, satisfied overall.', 'Positive', 0, '2024-04-12 17:00:00'),
(40, 23, 1, 1, 'Very poor and slow service.', 'Negative', 0, '2024-04-15 15:30:00'),
(41, 26, 3, 3, 'It was an okay experience.', 'Neutral', 0, '2024-04-19 11:45:00'),
(42, 31, 5, 5, 'Excellent and reliable team.', 'Positive', 0, '2024-04-23 18:00:00'),
(43, 35, 3, 3, 'Average service, nothing notable.', 'Neutral', 0, '2024-04-29 13:00:00'),
(44, 27, 4, 4, 'Pretty happy with the assistance.', 'Positive', 0, '2024-05-02 11:00:00'),
(45, 28, 5, 5, 'Great experience, very satisfied.', 'Positive', 0, '2024-05-07 09:20:00'),
(46, 29, 2, 2, 'Slow resolution time, unhappy.', 'Negative', 0, '2024-05-10 14:10:00'),
(47, 32, 3, 3, 'Not bad, but could be improved.', 'Neutral', 0, '2024-05-15 15:30:00'),
(48, 33, 5, 5, 'Quick and helpful service.', 'Positive', 0, '2024-05-20 17:45:00'),
(49, 36, 4, 4, 'Good experience overall.', 'Positive', 0, '2024-05-23 16:00:00'),
(50, 40, 2, 2, 'Frustrated with the poor service.', 'Negative', 0, '2024-05-27 20:30:00'),
(51, 2, 5, 5, 'Excellent service, highly satisfied.', 'Positive', 0, '2023-01-05 10:15:00'),
(52, 6, 4, 4, 'Good experience with the support team.', 'Positive', 0, '2023-01-12 14:45:00'),
(53, 10, 2, 2, 'Slow response, not satisfied.', 'Negative', 0, '2023-01-19 17:00:00'),
(54, 14, 3, 3, 'Service was okay, nothing special.', 'Neutral', 0, '2023-01-27 11:30:00'),
(55, 3, 5, 5, 'Fantastic service, exceeded expectations.', 'Positive', 0, '2023-02-04 10:00:00'),
(56, 8, 2, 2, 'Unresolved issues with support.', 'Negative', 0, '2023-02-11 15:45:00'),
(57, 12, 4, 4, 'Satisfied with the overall experience.', 'Positive', 0, '2023-02-18 14:30:00'),
(58, 18, 3, 3, 'Average service, could improve.', 'Neutral', 0, '2023-02-26 09:45:00'),
(59, 5, 4, 4, 'Helpful staff and good support.', 'Positive', 0, '2023-03-05 11:20:00'),
(60, 9, 1, 1, 'Very dissatisfied with the slow service.', 'Negative', 0, '2023-03-12 16:30:00'),
(61, 11, 3, 3, 'Service was acceptable, nothing great.', 'Neutral', 0, '2023-03-20 12:45:00'),
(62, 17, 5, 5, 'Excellent experience, highly recommend.', 'Positive', 0, '2023-03-28 14:10:00'),
(63, 4, 5, 5, 'Outstanding support and reliability.', 'Positive', 0, '2023-04-03 10:30:00'),
(64, 7, 2, 2, 'Issues remain unresolved, unhappy.', 'Negative', 0, '2023-04-10 15:00:00'),
(65, 15, 3, 3, 'Neutral experience, average service.', 'Neutral', 0, '2023-04-19 14:15:00'),
(66, 19, 4, 4, 'Happy with the quick resolution.', 'Positive', 0, '2023-04-27 12:50:00'),
(67, 1, 4, 4, 'Good overall experience.', 'Positive', 0, '2023-05-05 09:45:00'),
(68, 13, 1, 1, 'Extremely dissatisfied with customer care.', 'Negative', 0, '2023-05-12 17:10:00'),
(69, 20, 3, 3, 'Average support, needs improvement.', 'Neutral', 0, '2023-05-21 11:00:00'),
(70, 25, 5, 5, 'Excellent service and prompt support.', 'Positive', 0, '2023-05-30 13:40:00'),
(71, 6, 4, 4, 'Very satisfied with the team.', 'Positive', 0, '2023-06-04 10:15:00'),
(72, 16, 2, 2, 'Response time was very slow.', 'Negative', 0, '2023-06-11 16:50:00'),
(73, 22, 3, 3, 'Neutral experience overall.', 'Neutral', 0, '2023-06-20 14:20:00'),
(74, 30, 5, 5, 'Great experience, highly recommend.', 'Positive', 0, '2023-06-29 12:10:00'),
(75, 9, 5, 5, 'Outstanding customer support!', 'Positive', 0, '2023-07-03 11:10:00'),
(76, 18, 2, 2, 'Unresolved issues, very dissatisfied.', 'Negative', 0, '2023-07-10 15:30:00'),
(77, 21, 4, 4, 'Happy with the service.', 'Positive', 0, '2023-07-18 16:00:00'),
(78, 33, 3, 3, 'It was an okay experience.', 'Neutral', 0, '2023-07-25 12:50:00'),
(79, 2, 4, 4, 'Good support team.', 'Positive', 0, '2023-08-05 09:30:00'),
(80, 12, 1, 1, 'Very slow service, disappointed.', 'Negative', 0, '2023-08-12 16:10:00'),
(81, 23, 3, 3, 'Average experience overall.', 'Neutral', 0, '2023-08-20 10:15:00'),
(82, 36, 5, 5, 'Fantastic assistance and support.', 'Positive', 0, '2023-08-29 14:00:00');

-- --------------------------------------------------------

--
-- Table structure for table `churnguard_employees`
--

CREATE TABLE `churnguard_employees` (
  `EmployeeID` int NOT NULL,
  `FirstName` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `LastName` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `Email` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `Password` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `Role` enum('Employee','Admin') COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'Employee',
  `CreatedAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `lastLogin` datetime DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `churnguard_employees`
--

INSERT INTO `churnguard_employees` (`EmployeeID`, `FirstName`, `LastName`, `Email`, `Password`, `Role`, `CreatedAt`, `lastLogin`) VALUES
(1, 'Alice', 'Johnson', 'alice.johnson@example.com', 'admin123', 'Admin', '2024-12-07 21:13:12', '2024-12-14 16:31:07'),
(2, 'Bob', 'Sower', 'bob.martin@example.com', 'employee123', 'Employee', '2024-12-07 21:13:12', '2024-12-14 16:31:07'),
(4, 'Diana', 'Taylork', 'diana.taylor@example.com', 'admin123', 'Admin', '2024-12-07 21:13:12', '2024-12-14 16:31:07'),
(5, 'Edward', 'Mensah', 'edward.brown@example.com', 'employee123', 'Employee', '2024-12-07 21:13:12', '2024-12-14 16:31:07'),
(6, 'Daisy', 'Tsenesa', 'daisy.tsenesa@gmail.com', '$2y$10$o6JCQSUYA1Dbzi46fAvYDuy85sLX7GHKzN6ArEoJGsNDsRoiXyLx6', 'Admin', '2024-12-07 22:14:15', '2024-12-17 18:20:42'),
(8, 'Chipo', 'Zvarehwa', 'chipo@gmail.com', '$2y$10$vMp8oMCK6XsFy.0qg7wD2umu3UrNvKj/M/M/75sIelfeBtfZTl3Cu', 'Employee', '2024-12-14 22:32:43', '2024-12-14 22:32:43'),
(9, 'Marvelous', 'Siyaka', 'marve@gmail.com', '$2y$10$TVCXQ9mIasDNc737lqUQtOySKxHQphtnIyOWwm6frem5k2EM8Ng6a', 'Employee', '2024-12-14 22:35:08', '2024-12-14 22:35:08'),
(10, 'Justin', 'Tsenesa', 'justin@gmail.com', '$2y$10$N0sKu9nGNx0mScXfYxNGZe6Y0glN82nuano1rmOCZ6YpSAwmDwSVq', 'Employee', '2024-12-14 22:36:13', '2024-12-17 18:10:30'),
(11, 'Gilbert', 'Mada', 'gilbert@gmail.com', '$2y$10$DdPxD93SXd9VpO5OxBmtZuqxQmP6nNInFu6wdRazzx.UC.SQRV9HO', 'Employee', '2024-12-14 22:43:40', '2024-12-14 22:43:40'),
(12, 'Admin', 'Admin', 'admin@gmail.com', '$2y$10$PdQShyRnL2oNWmgb4GyLFOKirR1JhSPi27/.luFYuR9GZdfWUFBlO', 'Employee', '2024-12-14 22:50:04', '2024-12-14 22:50:04'),
(13, 'Amanda', 'Mphosa', 'amanda@gmail.com', '$2y$10$z6J5ix.qdr2zonX61j5IzOPYiIoRXM9dhJ97GuGGctOBqYcuFphU2', 'Admin', '2024-12-16 21:04:07', '2024-12-16 21:04:17');

-- --------------------------------------------------------

--
-- Table structure for table `churnguard_regions`
--

CREATE TABLE `churnguard_regions` (
  `RegionID` int NOT NULL,
  `RegionName` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  `Country` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `RegionDescription` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `churnguard_regions`
--

INSERT INTO `churnguard_regions` (`RegionID`, `RegionName`, `Country`, `RegionDescription`) VALUES
(1, 'Africa', 'Zimbabwe', 'In the Southern Region of Africa'),
(2, 'Africa', 'Ghana', 'Western African region'),
(3, 'America', 'USA', 'Includes North and South America');

-- --------------------------------------------------------

--
-- Table structure for table `churnguard_transactions`
--

CREATE TABLE `churnguard_transactions` (
  `TransactionID` int NOT NULL,
  `CustomerID` int NOT NULL,
  `TransactionDate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `TransactionAmount` decimal(15,2) DEFAULT NULL,
  `TransactionType` enum('Deposit','Withdrawal','Payment','Transfer') COLLATE utf8mb4_general_ci DEFAULT NULL,
  `BalanceAfterTransaction` decimal(15,2) DEFAULT NULL,
  `BranchLocation` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `churnguard_transactions`
--

INSERT INTO `churnguard_transactions` (`TransactionID`, `CustomerID`, `TransactionDate`, `TransactionAmount`, `TransactionType`, `BalanceAfterTransaction`, `BranchLocation`) VALUES
(1, 1, '2020-02-10 14:25:18', 500.00, 'Deposit', 1500.00, 'Harare Main Branch'),
(2, 1, '2021-06-18 09:40:22', 300.00, 'Withdrawal', 1200.00, 'Harare West Branch'),
(3, 1, '2023-03-25 11:05:00', 200.00, 'Transfer', 1000.00, 'Harare East Branch'),
(4, 2, '2021-08-12 16:20:14', 700.00, 'Deposit', 2700.00, 'Ghana Central Branch'),
(5, 2, '2022-04-05 10:12:30', 500.00, 'Payment', 2200.00, 'Ghana Accra Branch'),
(6, 2, '2024-01-25 18:00:45', 150.00, 'Withdrawal', 2050.00, 'Ghana Central Branch'),
(7, 3, '2020-10-30 13:45:00', 1000.00, 'Deposit', 3000.00, 'NYC Main Branch'),
(8, 3, '2022-09-07 17:35:22', 400.00, 'Transfer', 2600.00, 'NYC Downtown Branch'),
(9, 3, '2023-07-12 12:22:10', 150.00, 'Withdrawal', 2450.00, 'NYC Upper East Side Branch'),
(10, 4, '2021-11-18 14:30:10', 200.00, 'Payment', 1400.00, 'Harare East Branch'),
(11, 4, '2023-03-03 11:18:22', 100.00, 'Deposit', 1600.00, 'Harare West Branch'),
(12, 4, '2024-04-01 15:20:55', 300.00, 'Withdrawal', 1300.00, 'Harare North Branch'),
(13, 5, '2020-05-22 09:50:11', 500.00, 'Payment', 2000.00, 'Ghana Kumasi Branch'),
(14, 5, '2021-02-01 11:10:35', 700.00, 'Deposit', 2700.00, 'Ghana Accra Branch'),
(15, 5, '2023-06-14 14:05:50', 400.00, 'Transfer', 2300.00, 'Ghana Takoradi Branch'),
(16, 6, '2020-03-25 10:55:00', 300.00, 'Deposit', 1200.00, 'Harare Central Branch'),
(17, 6, '2022-08-08 12:15:20', 200.00, 'Withdrawal', 1000.00, 'Harare South Branch'),
(18, 6, '2024-02-18 13:40:30', 150.00, 'Transfer', 850.00, 'Harare Main Branch'),
(19, 7, '2021-09-19 16:45:55', 1000.00, 'Deposit', 5000.00, 'Ghana Tema Branch'),
(20, 7, '2022-10-17 12:30:05', 700.00, 'Withdrawal', 4300.00, 'Ghana Takoradi Branch'),
(21, 7, '2024-03-28 14:25:42', 300.00, 'Transfer', 4000.00, 'Ghana Ashanti Branch'),
(22, 8, '2020-04-14 15:50:00', 500.00, 'Deposit', 1500.00, 'NYC Upper West Side Branch'),
(23, 8, '2021-11-23 13:10:30', 300.00, 'Transfer', 1200.00, 'NYC Brooklyn Branch'),
(24, 8, '2023-12-02 17:40:15', 150.00, 'Withdrawal', 1050.00, 'NYC Queens Branch'),
(25, 9, '2020-09-20 11:15:30', 400.00, 'Deposit', 2400.00, 'Harare Central Branch'),
(26, 9, '2021-03-12 09:25:45', 300.00, 'Payment', 2100.00, 'Harare Main Branch'),
(27, 9, '2023-04-28 14:12:20', 200.00, 'Transfer', 1900.00, 'Harare South Branch'),
(28, 10, '2021-05-07 14:35:55', 1000.00, 'Deposit', 3000.00, 'Ghana Accra Branch'),
(29, 10, '2022-12-04 10:45:05', 500.00, 'Payment', 2500.00, 'Ghana Kumasi Branch'),
(30, 10, '2024-03-15 13:22:40', 400.00, 'Withdrawal', 2100.00, 'Ghana Accra Branch');

-- --------------------------------------------------------



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
  ADD KEY `fk_customer_churns_customer` (`customerID`);

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
-- AUTO_INCREMENT for table `churnguard_account_types`
--
ALTER TABLE `churnguard_account_types`
  MODIFY `AccountTypeID` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `churnguard_bank_issues`
--
ALTER TABLE `churnguard_bank_issues`
  MODIFY `IssueID` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `churnguard_churn_prediction`
--
ALTER TABLE `churnguard_churn_prediction`
  MODIFY `PredictionID` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=41;

--
-- AUTO_INCREMENT for table `churnguard_customers`
--
ALTER TABLE `churnguard_customers`
  MODIFY `CustomerID` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=41;

--
-- AUTO_INCREMENT for table `churnguard_customer_accounts`
--
ALTER TABLE `churnguard_customer_accounts`
  MODIFY `AccountID` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=41;

--
-- AUTO_INCREMENT for table `churnguard_customer_churns`
--
ALTER TABLE `churnguard_customer_churns`
  MODIFY `churnID` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=20;

--
-- AUTO_INCREMENT for table `churnguard_customer_complaints`
--
ALTER TABLE `churnguard_customer_complaints`
  MODIFY `ComplaintID` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT for table `churnguard_customer_demographics`
--
ALTER TABLE `churnguard_customer_demographics`
  MODIFY `CustomerDemographicID` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=43;

--
-- AUTO_INCREMENT for table `churnguard_customer_reviews`
--
ALTER TABLE `churnguard_customer_reviews`
  MODIFY `ReviewID` int NOT NULL AUTO_INCREMENT;


-- Constraints for dumped tables
--

--
-- Constraints for table `churnguard_churn_prediction`
--
ALTER TABLE `churnguard_churn_prediction`
  ADD CONSTRAINT `fk_churn_prediction_customer` FOREIGN KEY (`CustomerID`) REFERENCES `churnguard_customers` (`CustomerID`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `churnguard_customers`
--
ALTER TABLE `churnguard_customers`
  ADD CONSTRAINT `fk_customers_region` FOREIGN KEY (`RegionID`) REFERENCES `churnguard_regions` (`RegionID`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `churnguard_customer_accounts`
--
ALTER TABLE `churnguard_customer_accounts`
  ADD CONSTRAINT `fk_customer_accounts_accounttype` FOREIGN KEY (`AccountTypeID`) REFERENCES `churnguard_account_types` (`AccountTypeID`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_customer_accounts_customer` FOREIGN KEY (`CustomerID`) REFERENCES `churnguard_customers` (`CustomerID`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `churnguard_customer_churns`
--
ALTER TABLE `churnguard_customer_churns`
  ADD CONSTRAINT `fk_customer_churns_customer` FOREIGN KEY (`customerID`) REFERENCES `churnguard_customers` (`CustomerID`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `churnguard_customer_complaints`
--
ALTER TABLE `churnguard_customer_complaints`
  ADD CONSTRAINT `fk_customer_complaints_customer` FOREIGN KEY (`CustomerID`) REFERENCES `churnguard_customers` (`CustomerID`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_customer_complaints_issue` FOREIGN KEY (`IssueID`) REFERENCES `churnguard_bank_issues` (`IssueID`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `churnguard_customer_demographics`
--
ALTER TABLE `churnguard_customer_demographics`
  ADD CONSTRAINT `fk_customer_demographics_customer` FOREIGN KEY (`CustomerID`) REFERENCES `churnguard_customers` (`CustomerID`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `churnguard_customer_reviews`
--
ALTER TABLE `churnguard_customer_reviews`
  ADD CONSTRAINT `fk_customer_reviews_customer` FOREIGN KEY (`CustomerID`) REFERENCES `churnguard_customers` (`CustomerID`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `churnguard_transactions`
--
ALTER TABLE `churnguard_transactions`
  ADD CONSTRAINT `fk_transactions_customer` FOREIGN KEY (`CustomerID`) REFERENCES `churnguard_customers` (`CustomerID`) ON DELETE CASCADE ON UPDATE CASCADE;


COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
