--select
--use DBHemoware
--usar convert(VARCHAR(16) dataagendamento, 103)

--Select feito para testar se a trigger esta enviando os dados automaticamente para a tabela de doadores.
SELECT
	D.IDDoador,
	C.Nome,
	C.CPF,
	C.Preferencia,
	PT.IDPretriagem,
	PT.TipoSanguineo,
	PT.PressaoArterial,
	PT.ResultadoPT,
	T.IDTriagem,
	T.ResultadoTriagem,
	T.Observacao
	
FROM Doadores D

INNER JOIN Cadastrados C ON D.IDCadastrado = C.IDCadastrado
INNER JOIN PreTriagem PT ON D.IDPretriagem = PT.IDPretriagem
INNER JOIN Triagem T ON D.IDTriagem = T.IDTriagem;

