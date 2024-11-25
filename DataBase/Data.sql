--use DBHemoware
--DATA.SQL
--Adicionando dados nas tabelas do sistema para realização de testes.

INSERT INTO Cadastrados (Nome, CPF, Genero, DataNascimento, Email, Endereco, Preferencia)
VALUES 
	('João Silva', '12345678901', 'Masculino', '1985-05-20', 'joao.silva@example.com', 'Rua A, 123', 'Doador'),
	('Maria Santos', '98765432109', 'Feminino', '1990-08-15', 'maria.santos@example.com', 'Rua B, 456', 'Paciente'),
	('Carlos Oliveira', '45678912300', 'Masculino', '1982-03-10', 'carlos.oliveira@example.com', 'Rua C, 789', 'Doador'),
	('Ana Paula', '78912345611', 'Feminino', '1995-07-25', 'ana.paula@example.com', 'Rua D, 321', 'Paciente'),
	('Luiz Fernando', '12312312312', 'Masculino', '1992-04-12', 'luiz.fernando@example.com', 'Rua E, 10', 'Doador'),
	('Beatriz Lima', '32132132132', 'Feminino', '1987-09-30', 'beatriz.lima@example.com', 'Rua F, 20', 'Paciente'),
	('Renato Costa', '45645645645', 'Masculino', '1995-06-18', 'renato.costa@example.com', 'Rua G, 30', 'Doador'),
	('Fernanda Almeida', '65465465465', 'Feminino', '2000-12-01', 'fernanda.almeida@example.com', 'Rua H, 40', 'Paciente'),
	('Diego Souza', '78978978978', 'Masculino', '1980-08-22', 'diego.souza@example.com', 'Rua I, 50', 'Doador'),
	('Carla Mendes', '98798798798', 'Feminino', '1993-03-15', 'carla.mendes@example.com', 'Rua J, 60', 'Paciente'),
	('Victor Hugo', '11111111111', 'Masculino', '1990-11-25', 'victor.hugo@example.com', 'Rua K, 70', 'Doador'),
	('Juliana Ramos', '22222222222', 'Feminino', '1985-05-17', 'juliana.ramos@example.com', 'Rua L, 80', 'Paciente'),
	('Roberto Oliveira', '33333333333', 'Masculino', '1998-07-10', 'roberto.oliveira@example.com', 'Rua M, 90', 'Doador'),
	('Sabrina Cardoso', '44444444444', 'Feminino', '2001-01-05', 'sabrina.cardoso@example.com', 'Rua N, 100', 'Paciente'),
	('Marcos Paulo', '55555555555', 'Masculino', '1994-10-12', 'marcos.paulo@example.com', 'Rua O, 110', 'Doador'),
	('Patrícia Freitas', '66666666666', 'Feminino', '1992-02-20', 'patricia.freitas@example.com', 'Rua P, 120', 'Paciente'),
	('Alexandre Silva', '77777777777', 'Masculino', '1988-09-14', 'alexandre.silva@example.com', 'Rua Q, 130', 'Doador'),
	('Larissa Martins', '88888888888', 'Feminino', '1999-03-22', 'larissa.martins@example.com', 'Rua R, 140', 'Paciente'),
	('Tiago Pereira', '99999999999', 'Masculino', '1997-06-03', 'tiago.pereira@example.com', 'Rua S, 150', 'Doador');


INSERT INTO PreTriagem (IDCadastrado, Peso, Altura, PressaoArterial, TipoSanguineo, TesteHemoglobina, ResultadoPT)
VALUES 
	(1, 70.5, 1.75, 'Baixa', 'O+', 13.5, 'Reprovado'),
	(2, 60.0, 1.65, 'Normal', 'A+', 14.0, 'Aprovado'),
	(3, 85.0, 1.80, 'Alta', 'B+', 12.8, 'Reprovado'),
	(4, 55.0, 1.60, 'Baixa', 'O-', 14.2, 'Aprovado'),
	(5, 68.0, 1.70, 'Normal', 'O+', 13.8, 'Aprovado'),
	(6, 58.0, 1.65, 'Alta', 'A-', 14.1, 'Aprovado'),
	(7, 80.0, 1.85, 'Baixa', 'B+', 12.9, 'Aprovado'),
	(8, 62.0, 1.60, 'Normal', 'AB+', 14.0, 'Aprovado'),
	(9, 75.0, 1.78, 'Alta', 'O-', 13.5, 'Aprovado'),
	(10, 50.0, 1.55, 'Baixa', 'A+', 14.3, 'Reprovado'),
	(11, 90.0, 1.90, 'Normal', 'B-', 13.0, 'Aprovado'),
	(12, 68.0, 1.67, 'Alta', 'AB-', 14.4, 'Aprovado'),
	(13, 70.0, 1.75, 'Baixa', 'O+', 13.7, 'Aprovado'),
	(14, 55.0, 1.60, 'Normal', 'A-', 14.2, 'Aprovado'),
	(15, 72.0, 1.80, 'Alta', 'B+', 13.6, 'Aprovado'),
	(16, 66.0, 1.65, 'Baixa', 'AB+', 14.1, 'Reprovado'),
	(17, 78.0, 1.77, 'Normal', 'O-', 13.8, 'Aprovado'),
	(18, 60.0, 1.68, 'Alta', 'A+', 14.3, 'Aprovado'),
	(19, 82.0, 1.85, 'Baixa', 'B+', 13.9, 'Aprovado');


INSERT INTO Triagem (IDCadastrado, ResultadoTriagem, EstadoSaude, UsoMedicamentos, DoencasInfecciosas, DoencasCronicas, CirurgiaAnteriores, Alergias, Observacao)
VALUES 
	(1, 'Aprovado', 'Bom', 'Não', 'Não', 'Não', 'Não', 'Não', 'Apto para doação'),
	(2, 'Aprovado', 'Bom', 'Não', 'Não', 'Não', 'Não', 'Não', 'Sem restrições'),
	(3, 'Reprovado', 'Ruim', 'Sim', 'Sim', 'Não', 'Sim', 'Sim', 'Não apto para doação'),
	(4, 'Aprovado', 'Bom', 'Não', 'Não', 'Não', 'Não', 'Não', 'Sem restrições'),
	(5, 'Aprovado', 'Bom', 'Não', 'Não', 'Não', 'Não', 'Não', 'Apto para doação'),
	(6, 'Aprovado', 'Bom', 'Não', 'Não', 'Não', 'Não', 'Não', 'Sem restrições'),
	(7, 'Aprovado', 'Bom', 'Não', 'Não', 'Não', 'Não', 'Não', 'Sem restrições'),
	(8, 'Aprovado', 'Bom', 'Não', 'Não', 'Não', 'Não', 'Não', 'Apto para transfusão'),
	(9, 'Aprovado', 'Bom', 'Não', 'Não', 'Não', 'Não', 'Não', 'Apto para doação'),
	(10, 'Reprovado', 'Ruim', 'Sim', 'Sim', 'Não', 'Não', 'Sim', 'Não apto'),
	(11, 'Aprovado', 'Bom', 'Não', 'Não', 'Não', 'Não', 'Não', 'Apto para doação'),
	(12, 'Aprovado', 'Bom', 'Não', 'Não', 'Não', 'Não', 'Não', 'Sem restrições'),
	(13, 'Aprovado', 'Bom', 'Não', 'Não', 'Não', 'Não', 'Não', 'Sem restrições'),
	(14, 'Aprovado', 'Bom', 'Não', 'Não', 'Não', 'Não', 'Não', 'Sem restrições'),
	(15, 'Aprovado', 'Bom', 'Não', 'Não', 'Não', 'Não', 'Não', 'Sem restrições'),
	(16, 'Reprovado', 'Ruim', 'Sim', 'Sim', 'Não', 'Não', 'Sim', 'Não apto'),
	(17, 'Aprovado', 'Bom', 'Não', 'Não', 'Não', 'Não', 'Não', 'Sem restrições'),
	(18, 'Aprovado', 'Bom', 'Não', 'Não', 'Não', 'Não', 'Não', 'Sem restrições'),
	(19, 'Aprovado', 'Bom', 'Não', 'Não', 'Não', 'Não', 'Não', 'Sem restrições');



--INSERT INTO Doadores (IDCadastrado, IDPreTriagem, IDTriagem)
--VALUES 
--OBS: NÃO PRECISA INSERIR DADOS DOS DOADORES, POIS SE LA NA PREFERENCIA (NO CADASTRADO) FOI COLOCADO 'DOADOR' E ELE FOI APROVADO NA TRIAGEM E PRE-TRIAGEM, A TRIGGER JA VAI PREENCHER A TABELA DOADOR AUTOMATICAMENTE


INSERT INTO Pacientes (IDCadastrado, IDPreTriagem, IDTriagem)
VALUES 
	(2, 2, 2),
	(4, 4, 4);

select * from pacientes


INSERT INTO Agendamento (TipoAgendamento, DataHoraAgendamento, Observacoes, IDPaciente, IDDoador)
VALUES 
	('Coleta', '2024-11-01 08:00:00', 'Coleta rotineira', NULL, 1),
	('Coleta', '2024-10-30 09:00:00', 'Doação especial', NULL, 3),
	('Coleta', '2024-11-15 08:00:00', 'Coleta rotineira', NULL, 2),
	('Coleta', '2024-12-05 09:00:00', 'Doação especial', NULL, 8),
	('Coleta', '2024-12-01 08:00:00', 'Coleta rotineira', NULL, 7),
	('Coleta', '2024-11-01 09:00:00', 'Doação especial', NULL, 5)
	('Coleta', '2025-01-01 07:00:00', 'Doação especial', NULL, 4)
	('Transfusao', '2024-11-01 10:00:00', 'Urgencia', 1, NULL),
	('Transfusao', '2024-10-29 08:00:00', 'Urgencia', 2, NULL)
	

INSERT INTO Bolsas (IDDoador, DataColeta, QuantidadeML, Validade)
VALUES 
	(1, '2024-11-01', 450, '2024-12-16'),
	(2, '2024-11-15', 450, '2024-12-15'),
	(3, '2024-10-30', 450, '2024-12-05'),
	(4, '2024-10-30', 450, '2024-12-05'),
	(5, '2024-11-01', 450, '2024-12-16'),
	(6, '2024-11-01', 450, '2025-01-02'),
	(7, '2024-12-01', 300, '2025-01-16'),
	(8, '2024-12-05', 490, '2025-01-20'),
	(4, '2025-01-01', 450, '2024-02-16')


INSERT INTO Transfusao (IDPaciente, IDBolsa, IDAgendamento)
VALUES 
	(2, 10, 2)
	

