-- Rule 2: Identify customer transactions that occurred in a different state from the customers’ primary state. 
-- For example, if a customer’s state in the account info table is Texas, but there is a transaction in California, 
-- the customer should be flagged. You should print the customer’s name, account number, transaction number, 
-- expected transaction location, actual transaction location to both the screen and a file.

SELECT 
    CONCAT(Account_Info.first_name, ' ', Account_Info.last_name) AS 'Name',
    Account_Info.account_number AS 'Account Number', 
    Transactions.transaction_number AS 'Transaction Number', 
    Account_Info.state AS 'Expected Transaction Location', 
    Transactions.merchant_state AS 'Actual Transaction Location'
FROM
    Account_Info
        INNER JOIN
    Transactions ON Account_Info.account_number = Transactions.account_number
WHERE
    Account_Info.state <> Transactions.merchant_state
ORDER BY Account_Info.account_number , Transactions.transaction_number;
