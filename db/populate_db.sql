-- Populate Regions table
INSERT INTO Regions (RegionName, Country, RegionDescription, CustomerCount)
VALUES 
('North America', 'USA', 'Includes all customers in North America', 1500),
('Europe', 'Germany', 'Customers in Europe region', 1200),
('Asia', 'India', 'Customers from the Indian subcontinent', 2000),
('Africa', 'Nigeria', 'Customers from African countries', 800),
('South America', 'Brazil', 'Customers in South American countries', 900);

-- Populate Customers table
INSERT INTO Customers (Name, Email, PasswordHash, PhoneNumber, Status, RegionID, Address, AccountType)
VALUES 
('Alice Johnson', 'alice@example.com', 'hashedpassword1', '123-456-7890', 'active', 1, '123 Elm St, NY', 'Savings'),
('Bob Smith', 'bob@example.com', 'hashedpassword2', '234-567-8901', 'inactive', 2, '456 Oak St, Berlin', 'Checking'),
('Charlie Davis', 'charlie@example.com', 'hashedpassword3', '345-678-9012', 'active', 3, '789 Pine St, Mumbai', 'Business'),
('Dana Lee', 'dana@example.com', 'hashedpassword4', '456-789-0123', 'active', 4, '101 Maple St, Lagos', 'Savings'),
('Eve Martin', 'eve@example.com', 'hashedpassword5', '567-890-1234', 'suspended', 5, '202 Birch St, Sao Paulo', 'Checking');

-- Populate Employees table
INSERT INTO Employees (Name, Email, PasswordHash, PhoneNumber, Status, RegionID, Address, Role, EmployeeIDNumber)
VALUES 
('John Doe', 'john.doe@bank.com', 'hashedpassword1', '123-321-4321', 'active', 1, '500 Bank St, NY', 'bank_employee', 'E001'),
('Jane Smith', 'jane.smith@bank.com', 'hashedpassword2', '234-432-5432', 'inactive', 2, '600 Bank St, Berlin', 'manager', 'E002'),
('Chris Brown', 'chris.brown@bank.com', 'hashedpassword3', '345-543-6543', 'active', 3, '700 Bank St, Mumbai', 'admin', 'E003'),
('Diana White', 'diana.white@bank.com', 'hashedpassword4', '456-654-7654', 'active', 4, '800 Bank St, Lagos', 'bank_employee', 'E004'),
('Kevin Green', 'kevin.green@bank.com', 'hashedpassword5', '567-765-8765', 'suspended', 5, '900 Bank St, Sao Paulo', 'manager', 'E005');

-- Populate CustomerDemographics table
INSERT INTO CustomerDemographics (CustomerID, Age, Gender, Region, IncomeLevel, AccountType, DateJoined)
VALUES 
(1, 28, 'F', 'North America', 'Medium', 'Savings', '2023-05-01'),
(2, 34, 'M', 'Europe', 'High', 'Checking', '2022-08-15'),
(3, 40, 'M', 'Asia', 'Low', 'Business', '2021-10-12'),
(4, 29, 'F', 'Africa', 'Medium', 'Savings', '2023-01-20'),
(5, 25, 'F', 'South America', 'Low', 'Checking', '2023-02-10');

-- Populate Transactions table
INSERT INTO Transactions (CustomerID, TransactionDate, TransactionAmount, TransactionType, BalanceAfterTransaction, BranchLocation)
VALUES 
(1, '2024-01-01', 100.00, 'Deposit', 500.00, 'New York Branch'),
(2, '2024-01-02', 150.00, 'Withdrawal', 350.00, 'Berlin Branch'),
(3, '2024-01-03', 200.00, 'Transfer', 800.00, 'Mumbai Branch'),
(4, '2024-01-04', 50.00, 'Deposit', 150.00, 'Lagos Branch'),
(5, '2024-01-05', 75.00, 'Payment', 275.00, 'Sao Paulo Branch');

-- Populate CustomerFeedback table
INSERT INTO CustomerFeedback (CustomerID, FeedbackText, SentimentScore, SentimentLabel, ResolvedStatus)
VALUES 
(1, 'Great service and easy to use!', 0.9, 'positive', 'resolved'),
(2, 'Too many fees for transfers, not happy.', 0.3, 'negative', 'unresolved'),
(3, 'Customer support was very helpful.', 0.8, 'positive', 'resolved'),
(4, 'I had trouble accessing my account online.', 0.4, 'negative', 'unresolved'),
(5, 'Excellent experience with the new app features.', 0.7, 'positive', 'resolved');

-- Populate ChurnPredictions table
INSERT INTO ChurnPredictions (CustomerID, PredictionDate, ChurnProbability, RiskLevel, PredictionNotes, FollowUpStatus)
VALUES 
(1, '2024-01-01', 0.05, 'Low', 'Customer has been loyal for over a year.', 'Completed'),
(2, '2024-01-02', 0.75, 'High', 'Multiple negative feedback received from this customer.', 'Pending'),
(3, '2024-01-03', 0.1, 'Low', 'Recently made a large deposit, likely stable.', 'In Progress'),
(4, '2024-01-04', 0.55, 'Medium', 'Frequent issues with login, potential risk.', 'Pending'),
(5, '2024-01-05', 0.2, 'Low', 'Customer has shown interest in new features.', 'Completed');

-- Populate CustomerInteractions table
INSERT INTO CustomerInteractions (CustomerID, InteractionDate, InteractionType, InteractionDescription, InteractionOutcome, FollowUpRequired, FollowUpDate)
VALUES 
(1, '2024-01-01', 'Call', 'Resolved account access issue.', 'Resolved', FALSE, NULL),
(2, '2024-01-02', 'Email', 'Explained new transfer fees.', 'Escalated', TRUE, '2024-01-10'),
(3, '2024-01-03', 'Meeting', 'Discussed new business loan options.', 'Resolved', FALSE, NULL),
(4, '2024-01-04', 'Chat', 'Troubleshooted login issue.', 'Pending', TRUE, '2024-01-07'),
(5, '2024-01-05', 'Call', 'Walked through app navigation changes.', 'Resolved', FALSE, NULL);
