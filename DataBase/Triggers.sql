--Para possiveis novas implementacoes no sistema, sera adicionado trigger: para verificar se quantidade de bolsas de sangue no estoque esta baixo e notificar se estiver)

--use DBHemoware
--TRIGGERS.SQL
--Criando as triggers do sistema.


--Essa trigger vai previnir erros, bloqueando doadores que nao passaram na pretriagem de fazerem coleta de sangue:
create trigger ValidarAgendamento ON Agendamento
INSTEAD OF INSERT 
AS
BEGIN
	IF EXISTS(
		SELECT 1 FROM INSERTED I
		INNER JOIN Doadores D ON I.IDDoador = D.IDDoador
		INNER JOIN PreTriagem PT ON D.IDPretriagem = PT.IDPretriagem
		
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


--Essa trigger faz com que, se o resultado do cadastrado na pretriagem e triagem for aprovado ele ira passar para a tabela doadores automaticamente. OBS: Centralizei para a tabela cadastrados, pois ele ira interagir com doadores, triagem e pretriagem que estão relacionadas a cadastrados, então é melhor centralizar tudo logo em cadastrados 
create trigger AprovacaoParaDoador ON Triagem
AFTER INSERT, UPDATE
AS
BEGIN
	IF EXISTS (
		SELECT 1 FROM INSERTED I
        
        INNER JOIN Cadastrados C ON I.IDCadastrado = C.IDCadastrado
        INNER JOIN PreTriagem PT ON C.IDCadastrado = PT.IDCadastrado
        
        WHERE C.Preferencia = 'Doador'
			AND PT.ResultadoPT = 'Aprovado'
			AND I.ResultadoTriagem = 'Aprovado'
			
			AND NOT EXISTS (
				SELECT 1 
				FROM Doadores D 
				WHERE D.IDCadastrado = C.IDCadastrado
		)
	)
	BEGIN
		INSERT INTO Doadores (IDCadastrado, IDPretriagem, IDTriagem)
		SELECT C.IDCadastrado, PT.IDPretriagem, I.IDTriagem FROM INSERTED I
		
		INNER JOIN Cadastrados C ON I.IDCadastrado = C.IDCadastrado
		INNER JOIN PreTriagem PT ON C.IDCadastrado = PT.IDCadastrado
		
		WHERE C.Preferencia = 'Doador'
			AND PT.ResultadoPT = 'Aprovado'
			AND I.ResultadoTriagem = 'Aprovado'
			AND NOT EXISTS (
				SELECT 1 
				FROM Doadores D 
				WHERE D.IDCadastrado = C.IDCadastrado
		);
	END;
END;
