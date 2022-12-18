
CREATE VIEW absolute_deviation AS
SELECT 
    Transactions.account_number, Transactions.merchant_name, ABS(transaction_amount - median) AS absolute_deviation
FROM
    Transactions
        INNER JOIN
    Median ON Transactions.account_number = Median.account_number
        AND Transactions.merchant_name = Median.merchant_name
ORDER BY Transactions.account_number , Transactions.merchant_name;