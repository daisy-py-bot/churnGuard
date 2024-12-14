-- Populating churnguard_regions
INSERT INTO churnguard_regions (RegionName, Country, RegionDescription, CustomerCount)
VALUES 
('North America', 'USA', 'Includes USA and Canada', 200),
('Europe', 'Germany', 'Central European region', 150),
('Asia Pacific', 'India', 'Asia Pacific region', 300),
('Africa', 'South Africa', 'African continent', 100),
('South America', 'Brazil', 'Latin American region', 50);

-- Populating churnguard_customers
INSERT INTO churnguard_customers (FirstName, LastName, Email, PhoneNumber, Address, DateOfBirth, RegionID)
VALUES
('John', 'Doe', 'john.doe@example.com', '+1-555-1234', '123 Main St, New York, NY', '1990-01-15', 1),
('Jane', 'Smith', 'jane.smith@example.com', '+44-555-5678', '45 Baker St, London', '1985-03-22', 2),
('Raj', 'Patel', 'raj.patel@example.com', '+91-555-8765', '12 MG Road, Bangalore', '1992-11-30', 3),
('Thabo', 'Mokoena', 'thabo.mokoena@example.com', '+27-555-2345', '234 Main Road, Johannesburg', '1994-08-19', 4),
('Maria', 'Lopez', 'maria.lopez@example.com', '+55-555-7890', '789 Avenida Paulista, Sao Paulo', '1988-12-02', 5);

-- Populating churnguard_customer_demographics
INSERT INTO churnguard_customer_demographics (CustomerID, Age, Gender, IncomeLevel, AccountType, DateJoined)
VALUES
(1, 34, 'M', 'High', 'Checking', '2020-05-01'),
(2, 39, 'F', 'Medium', 'Savings', '2018-02-15'),
(3, 32, 'M', 'Medium', 'Business', '2021-07-10'),
(4, 29, 'M', 'Low', 'Checking', '2022-06-05'),
(5, 36, 'F', 'High', 'Savings', '2020-11-12');

-- Populating churnguard_transactions
INSERT INTO churnguard_transactions (CustomerID, TransactionAmount, TransactionType, BalanceAfterTransaction, BranchLocation)
VALUES
(1, 1000.00, 'Deposit', 5000.00, 'NYC Main Branch'),
(2, 200.00, 'Withdrawal', 1500.00, 'London Central Branch'),
(3, 500.00, 'Transfer', 3000.00, 'Bangalore Main Branch'),
(4, 150.00, 'Deposit', 1200.00, 'Johannesburg East Branch'),
(5, 800.00, 'Payment', 4000.00, 'Sao Paulo West Branch');

-- Populating churnguard_bank_issues
INSERT INTO churnguard_bank_issues (IssueType, IssueDescription, IssueStatus, IssueDate, IssueResolvedDate, IssueResolvedBy)
VALUES
('Product', 'Customer unable to access mobile banking app.', 'Resolved', '2024-01-01', '2024-01-02', 'Admin 1'),
('Service', 'Delayed response from customer support.', 'Unresolved', '2024-02-10', NULL, 'Admin 2'),
('Billing', 'Incorrect charges on monthly statement.', 'Resolved', '2024-03-05', '2024-03-06', 'Admin 3'),
('Other', 'ATM machine malfunctioned.', 'Unresolved', '2024-04-18', NULL, 'Admin 4'),
('Product', 'Online banking transaction failed.', 'Resolved', '2024-05-25', '2024-05-26', 'Admin 5');

-- Populating churnguard_customer_complaints
INSERT INTO churnguard_customer_complaints (CustomerID, IssueID, ComplaintDate, ResolvedStatus, FollowUpStatus, FollowUpDate)
VALUES
(1, 1, '2024-01-01', 'Resolved', 'Completed', '2024-01-02'),
(2, 2, '2024-02-10', 'Unresolved', 'Pending', NULL),
(3, 3, '2024-03-05', 'Resolved', 'In Progress', '2024-03-06'),
(4, 4, '2024-04-18', 'Unresolved', 'Pending', NULL),
(5, 5, '2024-05-25', 'Resolved', 'Completed', '2024-05-26');


-- Populating churnguard_churn_prediction
INSERT INTO churnguard_churn_prediction (CustomerID, PredictionDate, ChurnProbability, RiskLevel, PredictionNotes)
VALUES
(1, '2024-06-01', 0.10, 'Low', 'Stable account with good history'),
(2, '2024-06-02', 0.40, 'Medium', 'Frequent complaints, but good transactions'),
(3, '2024-06-03', 0.60, 'High', 'Customer has had several unresolved issues'),
(4, '2024-06-04', 0.20, 'Low', 'Positive feedback and consistent payments'),
(5, '2024-06-05', 0.30, 'Medium', 'Medium satisfaction, good account activity');

INSERT INTO churnguard_churn_prediction (CustomerID, PredictionDate, ChurnProbability, RiskLevel, PredictionNotes)
VALUES
(1, '2024-01-01', 0.10, 'Low', 'Stable account with good history'),
(2, '2024-02-02', 0.40, 'Medium', 'Frequent complaints, but good transactions'),
(3, '2024-03-03', 0.60, 'High', 'Customer has had several unresolved issues'),
(4, '2024-04-04', 0.20, 'Low', 'Positive feedback and consistent payments'),
(5, '2024-05-05', 0.30, 'Medium', 'Medium satisfaction, good account activity');

INSERT INTO churnguard_churn_prediction (CustomerID, PredictionDate, ChurnProbability, RiskLevel, PredictionNotes)
VALUES
(1, '2024-06-01', 0.10, 'Low', 'Stable account with good history'),
(2, '2024-07-02', 0.40, 'Medium', 'Frequent complaints, but good transactions'),
(3, '2024-08-03', 0.60, 'High', 'Customer has had several unresolved issues'),
(4, '2024-09-04', 0.20, 'Low', 'Positive feedback and consistent payments'),
(5, '2024-10-05', 0.30, 'Medium', 'Medium satisfaction, good account activity');

INSERT INTO churnguard_churn_prediction (CustomerID, PredictionDate, ChurnProbability, RiskLevel, PredictionNotes)
VALUES
(1, '2024-01-01', 0.10, 'Low', 'Stable account with good history'),
(2, '2024-06-02', 0.40, 'Medium', 'Frequent complaints, but good transactions'),
(3, '2024-11-03', 0.60, 'High', 'Customer has had several unresolved issues'),
(4, '2024-12-04', 0.20, 'Low', 'Positive feedback and consistent payments'),
(5, '2024-10-05', 0.30, 'Medium', 'Medium satisfaction, good account activity');

-- Populating churnguard_employees
INSERT INTO churnguard_employees (FirstName, LastName, Email, Password, Role)
VALUES
('Alice', 'Johnson', 'alice.johnson@example.com', 'admin123', 'Admin'),
('Bob', 'Martin', 'bob.martin@example.com', 'employee123', 'Employee'),
('Charlie', 'Williams', 'charlie.williams@example.com', 'employee123', 'Employee'),
('Diana', 'Taylor', 'diana.taylor@example.com', 'admin123', 'Admin'),
('Edward', 'Brown', 'edward.brown@example.com', 'employee123', 'Employee');

-- Populating churnguard_account_types
INSERT INTO churnguard_account_types (AccountTypeName, InterestRate)
VALUES
('Savings', 2.5),
('Checking', 1.0),
('Business', 4.0),
('Other', 0.5),
('Savings', 2.8);

-- Populating churnguard_customer_accounts
INSERT INTO churnguard_customer_accounts (CustomerID, AccountTypeID, AccountNumber, Balance)
VALUES
(1, 1, 'ACC123456', 5000.00),
(2, 2, 'ACC234567', 1500.00),
(3, 3, 'ACC345678', 3000.00),
(4, 2, 'ACC456789', 1200.00),
(5, 1, 'ACC567890', 4000.00);

-- Populating churnguard_customer_reviews
INSERT INTO churnguard_customer_reviews (CustomerID, OverallSatisfaction, RecommendationLikelihood, AdditionalComments, SentimentLabel)
VALUES
(1, 5, 5, 'Excellent service, highly recommend.', 'Positive'),
(2, 3, 3, 'Okay service, could improve.', 'Neutral'),
(3, 2, 2, 'Very dissatisfied, will not recommend.', 'Negative'),
(4, 4, 4, 'Good experience, minor issues with ATM.', 'Neutral'),
(5, 5, 5, 'Fantastic experience, will definitely recommend.', "Positive");

\