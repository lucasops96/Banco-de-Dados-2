1- Quais os nomes dos representantes de vendas que trabalham na região oeste?
select name
from sqlchallenge1.sales_resps
where regio_id in (select id
from sqlchallenge1.region
where name = 'West');

2- Quais os nomes dos representantes de vendas que trabalham na região oeste ou na região Nordeste?
select name
from sqlchallenge1.sales_resps
where region_id in (select id 
from sqlchallenge1.region
where name = 'West' or name = 'Northeast');

3- Quais os nomes dos representantes de vendas que não trabalham na região oeste ou na região Nordeste?
select name
from sqlchallenge1.sales_resps
where region_id not in (select id 
from sqlchallenge1.region
where name = 'West' or name = 'Northeast');

4- Quais os nomes dos representantes de vendas que trabalham na região oeste e que começam com a letra E?
select name
from sqlchallenge1.sales_resps
where region_id in (select id 
from sqlchallenge1.region
where name = 'West') and  name like 'E%';

5- Quais as contas que não fizeram nenhum pedido?
select id,name
from sqlchallenge1.accounts
where id not in (select account_id
from sqlchallenge1.orders);
 
6- Quantas contas nunca compraram poster?
select id,name
from sqlchallenge1.accounts
where id not in (select account_id
from sqlchallenge1.orders
where poster_qty > 0);