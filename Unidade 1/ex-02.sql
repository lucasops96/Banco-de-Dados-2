1 - Qual o nome do projeto que tem mais atividades realizadas? 
select p.descricao, count(a.projeto_id)
from projetos p 
join atividadesprojetos a on a.projeto_id = p.id
group by p.descricao
order by count(a.projeto_id) DESC 
limit 1;

2 - Exibir nome de cada projeto e de seu funcionário responsável. Exibir o nome do projeto mesmo que não haja funcionário responsável.

select p.descricao, f.nome
from projetos p
left join funcionarios f on f.id = p.funcionario_responsavel_id;

3 - Liste os nomes dos funcionários e dos projetos pelos quais eles são responsáveis.
O funcionário deve aparecer mesmo que não seja responsável por nenhum projeto.

select f.nome, p.descricao
from funcionarios f 
left join projetos p on p.funcionario_responsavel_id = f.id;

4 - Aumente em 20% o salário dos funcionários que são responsáveis por projetos. 

5 - Aloque para o projeto Gama a atividade Implantacao do produto. 
insert into atividadesprojetos values (3,7);

6 - Reduza em 10% o salário dos funcionários dos departamentos cuja média salarial seja maior que a média salarial da empresa.