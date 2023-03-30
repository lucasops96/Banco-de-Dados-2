1- Crie uma função para reajustar salários. O reajuste deve ser aplicado para todos os funcionários, e deve seguir a seguinte tabela:
5% de reajuste para os funcionários que não estão envolvidos em nenhuma atividade de projeto;
10% de reajuste para os funcionários que estão envolvidos em até 2 atividades de projeto;
15% de reajuste para os funcionários que estão envolvidos em pelo menos 3 atividades de projeto.

create function reajuste_salario(id_func int) 
returns int 
language plpgsql
as $$
declare 
	qted_atvs int;
begin  
	select count(projeto_id)
	from atividadesprojetos
	where projeto_id in (select id
						from projetos
						where departamento_id = (select departamento_id
							 					from funcionarios 
							 					where id = id_func) ) into qted_atvs;
	if (qted_atvs = 0) then 
		update funcionarios
		set salario = salario + salario * 0.05
		where id = id_func;
	elsif (qted_atvs <= 2 and qted_atvs >= 1 ) then 
		update funcionarios
		set salario = salario + salario * 0.10
		where id = id_func;
	elsif (qted_atvs >= 3 ) then 
		update funcionarios
		set salario = salario + salario * 0.15
		where id = id_func;
	end if;
	
	return qted_atvs;
end;
$$;

2-Execute o reajuste criado na questão 1.
select reajuste_salario(5);