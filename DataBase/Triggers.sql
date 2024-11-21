--Para possiveis novas implementacoes no sistema, sera adicionado triggers: 
-- 1: para ajustar o estoque de sangue após entrada/saida de uma bolsa (lembrando que vai ser necessario excluir a view 'VW_EstoqueSangue' e criar uma tabela de estoque de bolsas 
--		(nao deixando apenas na tabela bolsa). 
-- 2: para verificar se quantidade de bolsas de sangue no estoque esta baixo e notificar se estiver)

--use DBHemoware
--vai se chamar triggers.sql

--Essa trigger vai previnir erros, bloqueando doadores que nao passaram na pretriagem de fazerem coleta de sangue:

create trigger ValidarAgendamento ON Agendamento
INSTEAD OF INSERT 
AS
BEGIN
	IF EXISTS(
		SELECT 1 FROM INSERTED I
		INNER JOIN Doadores D ON I.IDDoador = D.IDDoador
		INNER JOIN PreTriagem PT ON I.IDPretriagem = PT.IDPretriagem
		
		WHERE I.TipoAgendamento = 'Coleta' AND PT.ResultadoPT = 'Reprovado'
	)
	BEGIN 
		RAISERROR('Doador não foi aprovado na Pre-Triagem, portando não pode realizar doações', 16, 1);
		ROLLBACK;
		return;
	END;

	INSERT INTO Agendamento(IDPaciente, IDDoador, TipoAgendamento, DataHoraAgendamento, Observacoes)
	SELECT IDPaciente, IDDoador, TipoAgendamento, DataHoraAgendamento, Observacoes 
	FROM INSERTED;
END
