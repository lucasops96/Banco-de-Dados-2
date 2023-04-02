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