--procedure (de cadastro de doadores ou triagens
--use DBHemoware
--vai se chamar procedure.sql

--Essa procedure vai gerar relatorio de entrada e saida das bolsas com datas especificadas pelo usuario:

create procedure RelatorioEspecificoDeBolsas
	@DataInicio DATE,
	@DataFinal DATE
	
AS
BEGIN
	SELECT 
		format(DataColeta, 'dd/mm/yyyy') AS 'Semana',
		SUM(CASE WHEN TipoAgendamento = 'Coleta' THEN 1 ELSE 0 END) AS 'Entradas de Bolsas',
		SUM(CASE WHEN TipoAgendamento = 'Transfusao' THEN 1 ELSE 0 END) AS 'Saida de Bolsas',
		
		SUM(CASE WHEN TipoAgendamento = 'Coleta' THEN 1 ELSE 0 END) - SUM(CASE WHEN TipoAgendamento = 'Transfusao' THEN 1 ELSE 0 END) AS 'Total'
		
		FROM Bolsas B
		JOIN
			Agendamento A ON B.IDDoador = A.IDDoador 
			
		WHERE
			DataColeta BETWEEN @DataInicio AND @DataFinal
		GROUP BY format(DataColeta, 'dd/mm/yyyy')
		ORDER BY format(DataColeta, 'dd/mm/yyyy')
END;

--Executando essa procedure, colocando as datas que deseja o relatorio:
EXEC RelatorioEspecificoDeBolsas @DataInicio = '01/01/2024', @DataFinal = '31/12/2024';



--Essa procedure vai gerar relatorio de entrada e saida das bolsas semanalmente:

create procedure RelatorioSemanalDeBolsas
AS
BEGIN
	SELECT 
		format(DATEADD(WEEK, DATEDIFF(WEEK, 0, DataColeta), 0), 'dd/mm/yyyy') AS 'Inicio da Semana',
		format(DATEADD(DAY, 6, DATEADD(WEEK, DATEDIFF(WEEK, 0, DataColeta), 0)), 'dd/mm/yyyy') AS 'Final da Semana',
		SUM(CASE WHEN A.TipoAgendamento = 'Coleta' then 1 else 0 end) AS 'Entradas de Bolsas',
		SUM(CASE WHEN A.TipoAgendamento = 'Transfusao' then 1 else 0 end) AS 'Saida de Bolsas',
		
		SUM(CASE WHEN A.TipoAgendamento = 'Coleta' THEN 1 ELSE 0 END) - SUM(CASE WHEN A.TipoAgendamento = 'Transfusao' THEN 1 ELSE 0 END) AS 'Total'
	FROM Bolsas B
	
	JOIN 
		Agendamento A ON B.IDDoador = A.IDDoador
	GROUP BY DATEDIFF(WEEK, 0, DataColeta)
	ORDER BY DATEDIFF(WEEK, 0, DataColeta);
END;

--Executando essa procedure:
EXEC RelatorioSemanalDeBolsas;
