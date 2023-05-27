1 - Crie uma tabela contendo duas colunas: uma coluna id, do tipo uuid, e uma coluna do tipo jsonb. A coluna json deve conter todas as informações do esquema acima (sem os ids, claro, pois será uma única tabela).

create table hospital(
	id uuid default uuid_generate_v4(),
	consultas jsonb
)

2 - Insira ao menos 5 linhas na tabela.
insert into hospital(consultas) values('{
"nome_paciente":"João Miguel", 
"endereco_paciente":"IPU-CE",
"telefone_paciente":"83999445566",
"medico":"Carlos Alberto",
"medico_especialidades":["Cardiologista","Cirurgia Geral"],
"data":"2023-05-21"
}');
insert into hospital(consultas) values('{
"nome_paciente":"Maria Silva", 
"endereco_paciente":"PATOS-PB",
"telefone_paciente":"83988745967",
"medico":"Carlos Alberto",
"medico_especialidades":["Cardiologista","Cirurgia Geral"],
"data":"2023-05-21"
}');
insert into hospital(consultas) values('{
"nome_paciente":"Manoel Gomes", 
"endereco_paciente":"CAMPINA GRANDE-PB",
"telefone_paciente":"83945451247",
"medico":"Carlos Alberto",
"medico_especialidades":["Cardiologista","Cirurgia Geral"],
"data":"2023-05-21"
}');
insert into hospital(consultas) values('{
"nome_paciente":"Rita Martins", 
"endereco_paciente":"PATOS-PB",
"telefone_paciente":"83988745967",
"medico":"Gabriel Aragão",
"medico_especialidades":["Ortopedista","Especialista em Ombro"],
"data":"2023-05-21"
}');
insert into hospital(consultas) values('{
"nome_paciente":"Luan Nogueira", 
"endereco_paciente":"PATOS-PB",
"telefone_paciente":"83988742233",
"medico":"Silvo Lima",
"medico_especialidades":["Psiquiatria","Psiquiatria da infância e adolescência"],
"data":"2023-05-21"
}');

3 - Faça uma consulta nessa tabela para retornar todos os médicos.

select distinct consultas->'medico' as medicos from hospital;

4 - Faça uma consulta para retornar todos os pacientes de um determinado médico (um dos que você inseriu).

select consultas->'nome_paciente' as pacientes
from hospital
where consultas->'medico' = '"Carlos Alberto"';

5 - Faça uma consulta usando a função jsonb_array_elements_text().
Retorna as especialidades de um determinado médico.

select distinct jsonb_array_elements_text(consultas->'medico_especialidades') as especialidades
from hospital
where consultas->'medico' = '"Silvo Lima"';