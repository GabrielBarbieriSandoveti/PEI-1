--use DBHemoware
--VIEWS.SQL
--Criando as views do sistema.


--Essa view vai exibir a quantidade de bolsas de cada tipo sanguineo, atualizando automaticamente a cada entrada e saida de bolsas:
create view VW_EstoqueSangue
AS
SELECT
	PT.TipoSanguineo AS 'Tipos Sanguineos',
	COUNT(Bolsas.IDBolsa) AS 'Quantidade de Bolsas',
	SUM(Bolsas.QuantidadeML) AS 'Total de ML'

FROM Bolsas

INNER JOIN Doadores ON Bolsas.IDDoador = Doadores.IDDoador
INNER JOIN PreTriagem PT ON Doadores.IDPretriagem = PT.IDPretriagem
LEFT JOIN Transfusao T ON Bolsas.IDBolsa = T.IDBolsa

WHERE T.IDBolsa IS NULL

GROUP BY PT.TipoSanguineo;


--Essa view vai exibir o históricos de transfusões:
create view VW_HistoricoTransfusoes
AS
SELECT

	T.IDTransfusao,
	C.Nome AS 'Nome do Paciente',
	C.CPF AS 'CPF do Paciente',
	B.IDBolsa,
	D.IDDoador,
	PT.TipoSanguineo AS 'Tipo Sanguineo',
	B.QuantidadeML AS 'Quantidade em ML',
	A.DataHoraAgendamento AS 'Data/Hora Agendada',
	A.Observacoes

FROM Transfusao T

INNER JOIN Pacientes P ON T.IDPaciente = P.IDPaciente
INNER JOIN Cadastrados C ON P.IDCadastrado = C.IDCadastrado
INNER JOIN Agendamento A ON T.IDAgendamento = A.IDAgendamento
INNER JOIN Bolsas B ON T.IDBolsa = B.IDBolsa
INNER JOIN PreTriagem PT ON P.IDPretriagem = PT.IDPretriagem
INNER JOIN Doadores D ON B.IDDoador = D.IDDoador;




