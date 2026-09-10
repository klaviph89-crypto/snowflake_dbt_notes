

create database months;
create table months(m_id int,month_name string,amount int);
insert into months(m_id,month_name,amount)values
(1,'jan',2000),
(1,'feb',1000),
(1,'march',4000),
(1,'april',5000),
(1,'may',3000),
(1,'june',1000),
(1,'july',2000),
(1,'aug',4000),
(1,'sep',5000),
(1,'oct',3000),
(1,'nov',5000),
(1,'dec',2000);

select * from months;

SELECT 
    m_id,
    month_name,
    amount AS current_amount,
    LAG(amount, 1) OVER (ORDER BY m_id) AS previous_amount,
    
    
    amount - LAG(amount, 1) OVER (ORDER BY m_id) AS difference,
    
    
    CASE 
        WHEN amount - LAG(amount, 1) OVER (ORDER BY m_id) > 0 THEN 'Profit'
        WHEN amount - LAG(amount, 1) OVER (ORDER BY m_id) < 0 THEN 'Loss'
        WHEN amount - LAG(amount, 1) OVER (ORDER BY m_id) = 0 THEN 'No Change'
        ELSE 'N/A (First Month)'
    END AS status
FROM months
ORDER BY m_id;


