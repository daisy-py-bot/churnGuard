-- Database: churn_guard
DROP DATABASE IF EXISTS churn_guard;
CREATE DATABASE IF NOT EXISTS churn_guard;
USE churn_guard;

-- Create Regions table first, as it's referenced by both Customers and Employees
CREATE TABLE Regions (
    RegionID INT PRIMARY KEY AUTO_INCREMENT,
    RegionName VARCHAR(100) NOT NULL,
    Country VARCHAR(100),
    RegionDescription VARCHAR(255),
    CustomerCount INT
);

-- Create Customers table
CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY AUTO_INCREMENT,
    Name VARCHAR(255) NOT NULL,
    Email VARCHAR(255) UNIQUE NOT NULL,
    PasswordHash VARCHAR(255) NOT NULL,
    DateJoined TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    LastLogin TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    PhoneNumber VARCHAR(15),
    Status ENUM('active', 'inactive', 'suspended') DEFAULT 'active',
    RegionID INT,
    Address VARCHAR(255),
    AccountType VARCHAR(50),
    FOREIGN KEY (RegionID) REFERENCES Regions(RegionID)
);

-- Create Employees table
CREATE TABLE Employees (
    EmployeeID INT PRIMARY KEY AUTO_INCREMENT,
    Name VARCHAR(255) NOT NULL,
    Email VARCHAR(255) UNIQUE NOT NULL,
    PasswordHash VARCHAR(255) NOT NULL,
    DateJoined TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    LastLogin TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    PhoneNumber VARCHAR(15),
    Status ENUM('active', 'inactive', 'suspended') DEFAULT 'active',
    RegionID INT,
    Address VARCHAR(255),
    Role ENUM('bank_employee', 'manager', 'admin') NOT NULL, 
    EmployeeIDNumber VARCHAR(255) UNIQUE NOT NULL, -- unique employee ID
    FOREIGN KEY (RegionID) REFERENCES Regions(RegionID)
);

-- Create CustomerDemographics table with reference to Customers
CREATE TABLE CustomerDemographics (
    CustomerDemographicID INT PRIMARY KEY AUTO_INCREMENT,
    CustomerID INT NOT NULL,
    Age INT,
    Gender ENUM('M', 'F', 'Other'),
    Region VARCHAR(50),
    IncomeLevel ENUM('Low', 'Medium', 'High'),
    AccountType ENUM('Savings', 'Checking', 'Business', 'Other'),
    DateJoined DATE,
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);

-- Create Transactions table with reference to CustomerDemographics
CREATE TABLE Transactions (
    TransactionID INT PRIMARY KEY AUTO_INCREMENT,
    CustomerID INT NOT NULL,
    TransactionDate DATE,
    TransactionAmount DECIMAL(10, 2),
    TransactionType ENUM('Deposit', 'Withdrawal', 'Payment', 'Transfer'),
    BalanceAfterTransaction DECIMAL(10, 2),
    BranchLocation VARCHAR(100),
    FOREIGN KEY (CustomerID) REFERENCES CustomerDemographics(CustomerID)
);

-- Create CustomerFeedback table with reference to Customers
CREATE TABLE CustomerFeedback (
    FeedbackID INT PRIMARY KEY AUTO_INCREMENT,
    CustomerID INT NOT NULL,
    FeedbackText TEXT NOT NULL,
    SentimentScore DECIMAL(3, 2),
    SentimentLabel ENUM('negative', 'neutral', 'positive'),
    Timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    ResolvedStatus ENUM('resolved', 'unresolved') DEFAULT 'unresolved',
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);

-- Create ChurnPredictions table with reference to CustomerDemographics
CREATE TABLE ChurnPredictions (
    PredictionID INT PRIMARY KEY AUTO_INCREMENT,
    CustomerID INT NOT NULL,
    PredictionDate DATE,
    ChurnProbability DECIMAL(3, 2),
    RiskLevel ENUM('Low', 'Medium', 'High'),
    PredictionNotes VARCHAR(255),
    FollowUpStatus ENUM('Pending', 'In Progress', 'Completed'),
    FOREIGN KEY (CustomerID) REFERENCES CustomerDemographics(CustomerID)
);

-- Create CustomerInteractions table with reference to CustomerDemographics
CREATE TABLE CustomerInteractions (
    InteractionID INT PRIMARY KEY AUTO_INCREMENT,
    CustomerID INT NOT NULL,
    InteractionDate DATE,
    InteractionType ENUM('Call', 'Email', 'Meeting', 'Chat', 'Other'),
    InteractionDescription VARCHAR(255),
    InteractionOutcome ENUM('Resolved', 'Escalated', 'Pending'),
    FollowUpRequired BOOLEAN,
    FollowUpDate DATE,
    FOREIGN KEY (CustomerID) REFERENCES CustomerDemographics(CustomerID)
);

