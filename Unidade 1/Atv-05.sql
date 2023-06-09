1- Crie uma função para reajustar salários. O reajuste deve ser aplicado para todos os funcionários, e deve seguir a seguinte tabela:
5% de reajuste para os funcionários que não estão envolvidos em nenhuma atividade de projeto;
10% de reajuste para os funcionários que estão envolvidos em até 2 atividades de projeto;
15% de reajuste para os funcionários que estão envolvidos em pelo menos 3 atividades de projeto.

create or replace function reajuste_salario() 
returns void 
language plpgsql
as $$ 
begin  
	update funcionarios
	set salario = case 
					when funcionarios.id not in (
						select distinct f.id
						from funcionarios f 
						join projetos p on p.funcionario_responsavel_id = f.id
						join atividadesprojetos a on a.projeto_id = p.id
					) then salario + salario * 0.05
					when funcionarios.id in (
						select distinct f.id
						from funcionarios f 
						join projetos p on p.funcionario_responsavel_id = f.id
						join atividadesprojetos a on a.projeto_id = p.id
						group by f.id
						having count(a.atividade_id) <= 2
					) then salario + salario * 0.1
					else salario + salario * 0.15
					end;
end;
$$;

2-Execute o reajuste criado na questão 1.
select reajuste_salario();

3-Modifique a tabela Departamentos, acrescentando uma coluna chamada total_atividades (numeric). Essa coluna deve ser preenchida para todos os departamentos, contendo o número de atividades desenvolvidas, somando todos os projetos daquele departamento específico.
alter table departamentos add column total_atividades numeric;

update departamentos d
set total_atividades = subquery.total_atividades
from(
	select p.departamento_id as id_departamento, count(a.projeto_id) as total_atividades
	from atividadesprojetos a
	join projetos p on p.id = a.projeto_id
	group by p.departamento_id
) as subquery
where d.id = subquery.id_departamento;


4-Crie um gatilho na tabela AtividadesProjetos, para que cada vez que uma nova linha seja inserida a tabela Departamentos tenha o seu campo total_atividades ajustado no departamento responsável pelo projeto no qual foi realizada uma nova atividade.

create or replace function atualizar_total_atividades()
returns trigger as
$$
begin
	 
	update departamentos d
	set total_atividades = total_atividades + 1
	where d.id = ( select d.id
	from departamentos d
	join projetos p on p.id = new.projeto_id and p.departamento_id = d.id);
	
	return new;
end;
$$ language plpgsql;

create or replace trigger atualizar_total_atividades after insert on atividadesprojetos
for each row execute function atualizar_total_atividades();

5-Crie uma tabela chamada Prêmios (id, funcionario_id, data, valor).
create table Premios(
	id SERIAL PRIMARY Key,
	funcionario_id Int References Funcionarios (id) On Delete Set Null,
	data Date,
	valor Numeric(8,2)
);

6 - Crie um gatilho na tabela AtividadesProjetos, para que cada vez que uma nova linha seja inserida, caso o funcionário responsável pelo projeto tenha atingido 3 atividades, receba um prêmio de 20% do salário (inserido na tabela prêmio).
create  function premio_atividades()
returns trigger as
$$
declare
	func_id int;
	total_atvs int;
begin
	select p.funcionario_responsavel_id
	from projetos p
	where p.id = new.projeto_id into func_id;
	
	select count(atividade_id)
	from atividadesprojetos
	where projeto_id = new.projeto_id into total_atvs;
	
	if(total_atvs = 3) then 
		insert into premios(funcionario_id, "data", valor) 
		values(func_id,now(),(select salario * 0.2
		from funcionarios
		where id = func_id));
	end if;
	
	return new;
end;
$$ language plpgsql;

create trigger premio_atividades after insert on atividadesprojetos
for each row execute function premio_atividades();

7 - Crie uma visão chamada Total_premios_2022, que contenha o nome do funcionário e o total em prêmios que ele tem a receber em 2022.

create view total_premios_2023 as
select f.nome , sum(p.valor) as total_premio
from funcionarios f
join premios p on p.funcionario_id = f.id
where p.data between '2023-01-01' and '2024-01-01'
group by f.nome;
