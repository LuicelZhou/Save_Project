-- DROP VIEW MAD;
CREATE VIEW MAD AS
select 
    account_number, 
    merchant_name,
    avg(absolute_deviation) as median_absolute_deviation
from (
select 
    account_number,
    merchant_name,
    absolute_deviation, 
    row_number() over(partition by account_number,merchant_name order by absolute_deviation) rn,
    count(*) over(partition by account_number,merchant_name) cnt
  from absolute_deviation
) as dd
where rn in ( FLOOR((cnt + 1) / 2), FLOOR( (cnt + 2) / 2) )
group by account_number,merchant_name
order by account_number,merchant_name;