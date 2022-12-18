DROP VIEW median;
create view median as
select 
    account_number, 
    merchant_name,
    avg(transaction_amount) as median
from (
select 
    account_number,
    merchant_name,
    transaction_amount, 
    row_number() over(partition by account_number,merchant_name order by transaction_amount) rn,
    count(*) over(partition by account_number,merchant_name) cnt
  from Transactions
) as dd
where rn in ( FLOOR((cnt + 1) / 2), FLOOR( (cnt + 2) / 2) )
group by account_number,merchant_name
order by account_number,merchant_name;