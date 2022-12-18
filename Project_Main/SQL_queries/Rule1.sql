SELECT DISTINCT 
    CONCAT(Account_Info.first_name, ' ', Account_Info.last_name) AS 'Name',
    Account_Info.account_number AS 'Account Number', 
    Transactions.transaction_number AS 'Transaction Number', 
    Transactions.merchant_name AS 'Merchant',
    Transactions.transaction_amount AS 'Transaction Amount'
FROM
    MAD
        INNER JOIN
	Median ON MAD.account_number = Median.account_number AND MAD.merchant_name = Median.merchant_name
    INNER JOIN
    Transactions ON MAD.account_number = Transactions.account_number AND MAD.merchant_name = Transactions.merchant_name
    INNER JOIN Account_Info ON Account_Info.account_number = Transactions.account_number
WHERE
    ABS(Transactions.transaction_amount - MAD.median_absolute_deviation) /  MAD.median_absolute_deviation > 10
   AND ABS(Transactions.transaction_amount - Median.median) > 10 * MAD.median_absolute_deviation
   AND Transactions.transaction_amount > 100
ORDER BY Account_Info.account_number , Transactions.transaction_number;