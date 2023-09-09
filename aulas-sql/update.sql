UPDATE games set city = 'Paris' WHERE yr = 2012;

1-Fazer insert de um paciente na tabela pacientes.
INSERT INTO pacientes VALUES (1,'Miguel Silva','Patos-PB','88993697283',21);

2-Fazer update no paciente cadastrado para mudar seu endereço. 
UPDATE pacientes set endereco = 'IPU-CE' WHERE id = 1;
 
3-Deletar a especialidade Neurologia. 
DELETE FROM especialidades WHERE descricao = 'Neurologia';

