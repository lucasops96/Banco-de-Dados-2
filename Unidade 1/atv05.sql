CREATE FUNCTION reajustar_salarios() RETURNS VOID AS $$
BEGIN
    UPDATE Funcionarios
    SET salario = CASE
        WHEN Funcionarios.id NOT IN (
            SELECT DISTINCT Funcionarios.id
            FROM Funcionarios
            LEFT JOIN Projetos ON Funcionarios.id = Projetos.funcionario_responsavel_id
            LEFT JOIN AtividadesProjetos ON Projetos.id = AtividadesProjetos.projeto_id
            WHERE AtividadesProjetos.projeto_id IS NOT NULL
        ) THEN salario * 1.05
        WHEN Funcionarios.id IN (
            SELECT DISTINCT Funcionarios.id
            FROM Funcionarios
            LEFT JOIN Projetos ON Funcionarios.id = Projetos.funcionario_responsavel_id
            LEFT JOIN AtividadesProjetos ON Projetos.id = AtividadesProjetos.projeto_id
            WHERE AtividadesProjetos.projeto_id IS NOT NULL
            GROUP BY Funcionarios.id
            HAVING COUNT(AtividadesProjetos.atividade_id) <= 2
        ) THEN salario * 1.1
        ELSE salario * 1.15
    END;
END;
$$ LANGUAGE plpgsql;


6-Usando PostgreSQL faça um script, para criar um gatilho na tabela AtividadesProjetos, para que cada vez que uma nova linha seja inserida, caso o funcionário responsável pelo projeto(na tabela projetos) tenha atingido 3 atividades, receba um prêmio de 20% do salário (inserido na tabela prêmio).
As tabelas são : Create Table AtividadesProjetos (
   projeto_id Int Not Null References Projetos (id),
   atividade_id Int Not Null References Atividades (id),
   data_inicio Date,
   data_fim Date,
   Constraint PkAtividadesProjetos Primary Key (projeto_id, atividade_id)
);   Create Table Projetos (
   id Int Primary Key,
   descricao Varchar(30) Not Null,
   departamento_id Int References Departamentos (id) On Delete Set Null,
   funcionario_responsavel_id Int References Funcionarios (id) On Delete Set Null
);   create table Premios(
	id SERIAL PRIMARY Key,
	funcionario_id Int References Funcionarios (id) On Delete Set Null,
	data Date,
	valor Numeric(8,2)
); Create Table Funcionarios (
   id Int Primary Key,
   nome Varchar(30) Not Null,
   sexo Char(1) Not Null Check (Sexo IN ('F','M')),
   salario Numeric(8,2) Not Null,
   departamento_id Int
);

