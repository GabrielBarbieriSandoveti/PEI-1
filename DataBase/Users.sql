--use DBHemoware
--USERS.SQL
--Criando os usuarios, com permissões especificas, para garantir a segurança do sistema.

CREATE LOGIN HemoAdmin WITH PASSWORD '';
CREATE LOGIN HemoAtendente WITH PASSWORD '';
CREATE LOGIN HemoMedico WITH PASSWORD '';
CREATE LOGIN HemoGerente WITH PASSWORD '';



CREATE USER HemoAdmin FOR LOGIN HemoAdmin;
CREATE USER HemoAtendente FOR LOGIN HemoAtendente;
CREATE USER HemoMedico FOR LOGIN HemoMedico;
CREATE USER HemoGerente FOR LOGIN HemoGerente;



CREATE ROLE AdminRole FOR LOGIN HemoAdmin;
	GRANT CONTROL ON DATABASE::DBHemoware TO AdminRole;

CREATE ROLE AtendenteRole FOR LOGIN HemoAtendente;
	GRANT INSERT, UPDATE ON dbo.Cadastrados TO AtendenteRole;
	REVOKE SELECT, DELETE ON dbo.Cadastrados TO AtendenteRole;

CREATE ROLE MedicoRole FOR LOGIN HemoMedico;
	GRANT SELECT, INSERT, UPDATE ON SCHEMA::dbo TO MedicoRole;

CREATE ROLE GerenteRole FOR LOGIN HemoGerente;
	GRANT SELECT, INSERT, UPDATE ON DATABASE::DBHemoware TO GerenteRole;



EXEC sp_addrolemember 'AdminRole', 'HemoAdmin';
EXEC sp_addrolemember 'AtendenteRole', 'HemoAtendente';
EXEC sp_addrolemember 'MedicoRole', 'HemoMedico';
EXEC sp_addrolemember 'GerenteRole', 'HemoGerente';
