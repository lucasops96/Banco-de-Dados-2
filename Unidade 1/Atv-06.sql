1. Crie uma visão materizalizada contendo 3 colunas: nome do projeto, quantidade de atividades realizadas, nome do responsável. Essa visão deve ser criada sem dados;

create materialized view dadosprojetos as
select p.descricao as nome_do_projeto , count(a.atividade_id) as quantidade_atividades,f.nome as nome_responsavel
from projetos p 
join funcionarios f on f.id = p.funcionario_responsavel_id 
join atividadesprojetos a on a.projeto_id = p.id
group by p.descricao, f.nome
with no data;

2. Faça com que a visão seja povoada;

refresh materialized view dadosprojetos;

3. Consulte na visão quais os nomes dos projetos com ao menos três atividades realizadas;

select d.nome_do_projeto  
from dadosprojetos d
where d.quantidade_atividades >= 3;

4. Execute -- INSERT INTO atividadesprojetos VALUES(3,1,null,null);

5. Refaça a consulta 3. Mudou alguma coisa?
Não mudou nada, consulta retorna apenas projeto Alfa
6. Dê um refresh na visão materializada e refaça a consulta 3. Mudou alguma coisa?
Mudou, agora a consulta retorna os projetos Alfa e Gama.