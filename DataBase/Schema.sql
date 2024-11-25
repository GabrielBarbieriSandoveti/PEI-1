--SCHEMA.SQL
--Criando as tabelas, primary keys e foreign keys do sistema.

create DBHemoware
use DBHemoware

create table Funcionarios
(
	IDFuncionario INT not null PRIMARY KEY IDENTITY,
	Nome VARCHAR(100) not null,
	CPF CHAR(11) not null UNIQUE,
	Cargo VARCHAR (80) not null,
	Telefone VARCHAR(11) not null,
	Email VARCHAR(100) not null,
	Endereco VARCHAR(250)
);

create table Cadastrados
(
	IDCadastrado INT not null PRIMARY KEY IDENTITY,
	Nome VARCHAR(100) not null,
	CPF CHAR(11) not null UNIQUE,
	Genero VARCHAR(10) CHECK (Genero IN ('Masculino', 'Feminino')) not null,
	DataNascimento DATE not null,
	Email VARCHAR(100) not null,
	Endereco VARCHAR(250) not null,
	Preferencia VARCHAR(8) CHECK (Preferencia IN ('Doador', 'Paciente')) not null
);

create table PreTriagem
(
	IDPretriagem INT not null PRIMARY KEY IDENTITY,
	IDCadastrado INT not null,
	Peso DECIMAL (5,2) not null,
	Altura DECIMAL(5,2) not null,
	PressaoArterial VARCHAR(6) CHECK (PressaoArterial IN ('Baixa', 'Alta', 'Normal')) not null,
	TipoSanguineo CHAR(3) CHECK (TipoSanguineo IN ('A+', 'B+', 'AB+', 'O+', 'O-', 'A-', 'B-', 'AB-')) not null,
	TesteHemoglobina DECIMAL(4,1) not null,
	ResultadoPT VARCHAR(9) CHECK (ResultadoPT IN ('Aprovado', 'Reprovado')) not null,
	CONSTRAINT FK_PretriagemXCadastrado foreign key (IDCadastrado) references Cadastrados(IDCadastrado)
);

create table Triagem
(
	IDTriagem INT not null PRIMARY KEY IDENTITY,
	IDCadastrado INT not null,
	ResultadoTriagem VARCHAR(9) CHECK (ResultadoTriagem IN ('Aprovado', 'Reprovado')) not null,
	EstadoSaude VARCHAR(250),
	UsoMedicamentos VARCHAR(250),
	DoencasInfecciosas VARCHAR(250),
	DoencasCronicas VARCHAR(250),
	CirurgiaAnteriores VARCHAR(250),
	Alergias VARCHAR(250),
	Observacao VARCHAR(250),
	CONSTRAINT FK_TriagemXCadastrado foreign key (IDCadastrado) references Cadastrados(IDCadastrado)
);

create table Pacientes
(
    IDPaciente INT not null PRIMARY KEY IDENTITY,
    IDPretriagem INT not null,
    IDTriagem INT null,
	IDCadastrado INT not null,
    CONSTRAINT FK_PacienteXCadastrado foreign key (IDCadastrado) references Cadastrados(IDCadastrado),
    CONSTRAINT FK_PacienteXPretriagem foreign key (IDPretriagem) references PreTriagem (IDPretriagem),
    CONSTRAINT FK_PacienteXTriagem foreign key (IDTriagem) references Triagem (IDTriagem)
);

create table Doadores
(
	IDDoador INT not null PRIMARY KEY IDENTITY,
	IDCadastrado INT not null,
	IDPretriagem INT not null,
    IDTriagem INT not null,
    CONSTRAINT FK_DoadorXCadastrado foreign key (IDCadastrado) references Cadastrados(IDCadastrado),
    CONSTRAINT FK_DoadorXPretriagem foreign key (IDPretriagem) references PreTriagem(IDPretriagem),
    CONSTRAINT FK_DoadorXTriagem foreign key (IDTriagem) references Triagem(IDTriagem)
);

create table Bolsas
(
	IDBolsa INT not null PRIMARY KEY IDENTITY,
	IDDoador INT not null,
	DataColeta DATETIME2 not null,
	QuantidadeML INT not null,
	Validade DATE null,
	CONSTRAINT FK_BolsaXDoador foreign key (IDDoador) references Doadores(IDDoador)
);

create table Agendamento
(
	IDAgendamento INT not null PRIMARY KEY IDENTITY,
	IDPaciente INT null,
	IDDoador INT null,
	TipoAgendamento VARCHAR(10) CHECK (TipoAgendamento IN ('Coleta', 'Transfusao')) not null,
	DataHoraAgendamento DATETIME2 not null,
	Observacoes VARCHAR(250),
	CONSTRAINT FK_AgendamentoXPaciente foreign key (IDPaciente) references Pacientes (IDPaciente),
	CONSTRAINT FK_AgendamentoXDoador foreign key (IDDoador) references Doadores (IDDoador)
);


create table Transfusao
(
	IDTransfusao INT not null PRIMARY KEY IDENTITY,
	IDBolsa INT not null,
	IDPaciente INT not null,
	IDAgendamento INT not null,
	CONSTRAINT FK_TransfusaoXBolsa foreign key (IDBolsa) references Bolsas(IDBolsa),
	CONSTRAINT FK_TransfusaoXPaciente foreign key (IDPaciente) references Pacientes (IDPaciente),
	CONSTRAINT FK_TransfusaoXAgendamento foreign key (IDAgendamento) references Agendamento(IDAgendamento)
);


