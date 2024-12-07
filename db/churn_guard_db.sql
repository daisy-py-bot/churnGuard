-- Drop existing database if it exists
DROP DATABASE IF EXISTS churnguard;
CREATE DATABASE IF NOT EXISTS churnguard;
USE churnguard;

-- Regions table for mapping customers
CREATE TABLE churnguard_regions (
    RegionID INT PRIMARY KEY AUTO_INCREMENT,
    RegionName VARCHAR(100) NOT NULL,
    Country VARCHAR(100),
    RegionDescription VARCHAR(255),
    CustomerCount INT
);

-- Customers table with reference to regions
CREATE TABLE churnguard_customers (
    CustomerID INT PRIMARY KEY AUTO_INCREMENT,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    Email VARCHAR(100) UNIQUE NOT NULL,
    PhoneNumber VARCHAR(15),
    Address TEXT,
    DateOfBirth DATE,
    RegionID INT,
    DateJoined TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    LastLogin TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (RegionID) REFERENCES churnguard_regions(RegionID)
);

-- Demographic information for customers
CREATE TABLE churnguard_customer_demographics (
    CustomerDemographicID INT PRIMARY KEY AUTO_INCREMENT,
    CustomerID INT NOT NULL,
    Age INT,
    Gender ENUM('M', 'F', 'Other'),
    IncomeLevel ENUM('Low', 'Medium', 'High'),
    AccountType ENUM('Savings', 'Checking', 'Business', 'Other'),
    DateJoined DATE,
    FOREIGN KEY (CustomerID) REFERENCES churnguard_customers(CustomerID)
);

-- Transactions table with reference to customers and accounts
CREATE TABLE churnguard_transactions (
    TransactionID INT PRIMARY KEY AUTO_INCREMENT,
    CustomerID INT NOT NULL,
    TransactionDate TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    TransactionAmount DECIMAL(15, 2),
    TransactionType ENUM('Deposit', 'Withdrawal', 'Payment', 'Transfer'),
    BalanceAfterTransaction DECIMAL(15, 2),
    BranchLocation VARCHAR(100),
    FOREIGN KEY (CustomerID) REFERENCES churnguard_customers(CustomerID)
);

-- Bank Issues table where admin logs issues
CREATE TABLE churnguard_bank_issues (
    IssueID INT PRIMARY KEY AUTO_INCREMENT,
    IssueType ENUM('Product', 'Service', 'Billing', 'Other'),
    IssueDescription VARCHAR(255),
    IssueStatus ENUM('Resolved', 'Unresolved') DEFAULT 'Unresolved',
    IssueDate DATE,
    IssueResolvedDate DATE,
    IssueResolvedBy VARCHAR(255)
);

-- Complaints table linking customers to issues they face
CREATE TABLE churnguard_customer_complaints (
    ComplaintID INT PRIMARY KEY AUTO_INCREMENT,
    CustomerID INT NOT NULL,
    IssueID INT NOT NULL,
    ComplaintDate DATE,
    ResolvedStatus ENUM('Resolved', 'Unresolved') DEFAULT 'Unresolved',
    FollowUpStatus ENUM('Pending', 'In Progress', 'Completed'),
    FollowUpDate DATE,
    FOREIGN KEY (CustomerID) REFERENCES churnguard_customers(CustomerID),
    FOREIGN KEY (IssueID) REFERENCES churnguard_bank_issues(IssueID)
);


-- Churn Prediction table to track customer churn risk
CREATE TABLE churnguard_churn_prediction (
    PredictionID INT PRIMARY KEY AUTO_INCREMENT,
    CustomerID INT NOT NULL,
    PredictionDate DATE,
    ChurnProbability DECIMAL(3, 2),
    RiskLevel ENUM('Low', 'Medium', 'High'),
    PredictionNotes VARCHAR(255),
    FOREIGN KEY (CustomerID) REFERENCES churnguard_customers(CustomerID)
);

-- Employees table for managing user roles (admin/employee)
CREATE TABLE churnguard_employees (
    EmployeeID INT PRIMARY KEY AUTO_INCREMENT,
    FirstName VARCHAR(255) NOT NULL,
    LastName VARCHAR(255) NOT NULL,
    Email VARCHAR(255) NOT NULL,
    Password VARCHAR(255) NOT NULL,
    Role ENUM('Employee', 'Admin') NOT NULL DEFAULT 'Employee',
    CreatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Account Types table (e.g., savings, checking)
CREATE TABLE churnguard_account_types (
    AccountTypeID INT AUTO_INCREMENT PRIMARY KEY,
    AccountTypeName VARCHAR(50) NOT NULL,
    InterestRate DECIMAL(5, 2),
    CreatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Customer accounts linked to account types
CREATE TABLE churnguard_customer_accounts (
    AccountID INT AUTO_INCREMENT PRIMARY KEY,
    CustomerID INT NOT NULL,
    AccountTypeID INT NOT NULL,
    AccountNumber VARCHAR(20) UNIQUE NOT NULL,
    Balance DECIMAL(15, 2) DEFAULT 0.00,
    OpenedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (CustomerID) REFERENCES churnguard_customers(CustomerID),
    FOREIGN KEY (AccountTypeID) REFERENCES churnguard_account_types(AccountTypeID)
);

-- Reviews table for customer satisfaction and likelihood to recommend
CREATE TABLE churnguard_customer_reviews (
    ReviewID INT PRIMARY KEY AUTO_INCREMENT,
    CustomerID INT NOT NULL,
    OverallSatisfaction INT CHECK (OverallSatisfaction BETWEEN 1 AND 5),
    RecommendationLikelihood INT CHECK (RecommendationLikelihood BETWEEN 1 AND 5),
    AdditionalComments TEXT,
    SentimentLabel ENUM()
    FollowUpContact BOOLEAN DEFAULT FALSE,
    CreatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (CustomerID) REFERENCES churnguard_customers(CustomerID)
);



