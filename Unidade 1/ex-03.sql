1- Quais os nomes dos representantes de vendas que trabalham na região oeste?
select name
from sqlchallenge1.sales_resps
where regio_id in (select id
from sqlchallenge1.region
where name = 'West')

2- Quais os nomes dos representantes de vendas que trabalham na região oeste ou na região Nordeste?

3- Quais os nomes dos representantes de vendas que não trabalham na região oeste ou na região Nordeste?

4- Quais os nomes dos representantes de vendas que trabalham na região oeste e que começam com a letra E?

5- Quais as contas que não fizeram nenhum pedido?
 
6- Quantas contas nunca compraram poster?