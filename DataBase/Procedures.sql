--use DBHemoware
--PROCEDURES.SQL

--Essa procedure vai gerar relatorio de entrada e saida das bolsas com datas especificadas pelo usuario:
create procedure RelatorioEspecificoDeBolsas
	@DataInicio DATE,
	@DataFinal DATE
AS
BEGIN
	SELECT 
		CONVERT(VARCHAR(10), B.DataColeta, 120) AS 'Data',
		SUM(CASE WHEN TipoAgendamento = 'Coleta' THEN 1 ELSE 0 END) AS 'Entradas de Bolsas',
		SUM(CASE WHEN T.IDBolsa IS NOT NULL THEN 1 ELSE 0 END) AS 'Saida de Bolsas',
		
		SUM(CASE WHEN TipoAgendamento = 'Coleta' THEN 1 ELSE 0 END) - SUM(CASE WHEN T.IDBolsa IS NOT NULL THEN 1 ELSE 0 END) AS 'Total'
		
		FROM Bolsas B
		
		INNER JOIN Agendamento A ON B.IDDoador = A.IDDoador 
		LEFT JOIN Transfusao T ON B.IDBolsa = T.IDBolsa
		
		WHERE 
			B.DataColeta BETWEEN @DataInicio AND @DataFinal
		GROUP BY CONVERT(VARCHAR(10), B.DataColeta, 120)
		ORDER BY CONVERT(VARCHAR(10), B.DataColeta, 120);
END;

--Executando essa procedure, colocando as datas que deseja o relatorio:
EXEC RelatorioEspecificoDeBolsas @DataInicio = '2024-01-01', @DataFinal = '2025-01-02';



--Essa procedure vai gerar relatorio de entrada e saida das bolsas semanalmente:
create procedure RelatorioSemanalDeBolsas
AS
BEGIN
	SELECT 
		CONVERT(VARCHAR(10), DATEADD(DAY, -DATEPART(WEEKDAY, MIN(DataColeta)) + 1, MIN(DataColeta)), 103) AS 'Inicio da Semana',
		CONVERT(VARCHAR(10), DATEADD(DAY, -DATEPART(WEEKDAY, MIN(DataColeta)) + 7, MIN(DataColeta)), 103) AS 'Final da Semana',
		SUM(CASE WHEN A.TipoAgendamento = 'Coleta' THEN 1 ELSE 0 END) AS 'Entradas de Bolsas',
		SUM(CASE WHEN T.IDBolsa IS NOT NULL THEN 1 ELSE 0 END) AS 'Saida de Bolsas',
		
		SUM(CASE WHEN A.TipoAgendamento = 'Coleta' THEN 1 ELSE 0 END) - SUM(CASE WHEN T.IDBolsa IS NOT NULL THEN 1 ELSE 0 END) AS 'Total'
		
	FROM Bolsas B
	JOIN Agendamento A ON B.IDDoador = A.IDDoador
	LEFT JOIN Transfusao T ON B.IDBolsa = T.IDBolsa
	GROUP BY DATEADD(DAY, -DATEPART(WEEKDAY, DataColeta) + 1, DataColeta)
	ORDER BY DATEADD(DAY, -DATEPART(WEEKDAY, DataColeta) + 1, DataColeta);
END;

--Executando essa procedure:
EXEC RelatorioSemanalDeBolsas;









