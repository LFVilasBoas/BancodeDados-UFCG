
-- Aluno: Luiz Fernando Soares Vilas Boas - Roteiro 1

-- Primeiro passo criar as tabelas:
CREATE TABLE automovel(
	Cartegoria VARCHAR(20),
	Placa_do_carro CHAR(8),
	CPF_do_segurado CHAR(14),
	Chassi CHAR(21),
	Cor VARCHAR(20),
	Ano CHAR(4),
	Modelo VARCHAR(20),
	Cambio VARCHAR(20) 	
);

CREATE TABLE segurado(
	Nome_segurado VARCHAR(30),
	Placa_do_carro CHAR(8),
	CPF_do_segurado CHAR(14),
	AnodeNacimento DATE,
	Email VARCHAR(25),
	Contrato_com_segurado VARCHAR(20)
);

CREATE TABLE perito(
	Nome_perito VARCHAR(30),
	CPF_do_perito CHAR(14),
	Contrato_com_perito VARCHAR(20),
	Email_perito VARCHAR(25)
);

CREATE TABLE oficina(
	Cnpj_da_Oficina VARCHAR(18),
	Endereco TEXT,
	Telefone VARCHAR(20),
	Contrato_com_oficina VARCHAR(20),
	Codigo_do_reparo VARCHAR(20)
);

CREATE TABLE seguro(
	Contrato_com_oficina VARCHAR(20),
	Contrato_com_segurado VARCHAR(20),
	Contrato_com_perito VARCHAR(20),
	Chassi CHAR(21),
	PlacadoCarro CHAR(8),
	Email VARCHAR(25)
);

CREATE TABLE sinistro(
	Ocorrencia VARCHAR(20),
	Local VARCHAR(30),
	Analise TEXT,
	DataHorario TIMESTAMP,
	Contrato_com_perito Varchar(20),
	Placa_do_carro CHAR(8)
);

CREATE TABLE pericia(
	Contrato_com_perito Varchar(20),
	Ocorrencia VARCHAR(20),
	Local VARCHAR(20),
	Chassi CHAR(21),
	Analise TEXT,
	DataHorario TIMESTAMP,
	CPF_do_perito CHAR(14),
	Dano TEXT,
	PlacadoCarro CHAR(8),
	CPF_do_segurado CHAR(14)
);

CREATE TABLE reparo(
	Ocorrencia VARCHAR(20),
	Cnpj_da_Oficina VARCHAR(18),
	Contrato_com_oficina VARCHAR(20),
	Chassi CHAR(21),
	PlacadoCarro CHAR(8),
	Analise TEXT,
	Preco NUMERIC
	Codigo_do_reparo VARCHAR(20)
);

-- Segundo passo adcionar as chaves primárias das tabelas

ALTER TABLE automovel ADD PRIMARY KEY(Placa_do_carro);
ALTER TABLE segurado ADD PRIMARY KEY(CPF_do_segurado);
ALTER TABLE perito ADD PRIMARY KEY(CPF_do_perito);
ALTER TABLE oficina ADD PRIMARY KEY(Cnpj_da_Oficina);
ALTER TABLE seguro ADD PRIMARY KEY(Contrato_com_segurado);
ALTER TABLE sinistro ADD PRIMARY KEY(Ocorrencia, Placa_do_carro);
ALTER TABLE pericia ADD PRIMARY KEY(Ocorrencia, PlacadoCarro, Contrato_com_perito);
ALTER TABLE reparo ADD PRIMARY KEY(Cnpj_da_Oficina, Ocorrencia);

-- Terceiro passo adcionar as chaves estrangeiras das tabelas

ALTER TABLE automovel ADD CONSTRAINT automovel_Placa_do_carro_fkey FOREIGN KEY (Placa_do_carro) REFERENCES segurado (Placa_do_carro);
ALTER TABLE automovel ADD CONSTRAINT automovel_Placa_do_carro_fkey FOREIGN KEY (Placa_do_carro) REFERENCES seguro (Placa_do_carro);
ALTER TABLE automovel ADD CONSTRAINT automovel_Placa_do_carro_fkey FOREIGN KEY (Placa_do_carro) REFERENCES sinistro (Placa_do_carro);
ALTER TABLE automovel ADD CONSTRAINT automovel_Placa_do_carro_fkey FOREIGN KEY (Placa_do_carro) REFERENCES pericia (Placa_do_carro);
ALTER TABLE automovel ADD CONSTRAINT automovel_Placa_do_carro_fkey FOREIGN KEY (Placa_do_carro) REFERENCES reparo (Placa_do_carro);
ALTER TABLE segurado ADD CONSTRAINT segurado_CPF_do_segurado_fkey FOREIGN KEY (CPF_do_segurado) REFERENCES pericia (CPF_do_segurado);
ALTER TABLE seguro ADD CONSTRAINT seguro_Contrato_com_segurado_fkey FOREIGN KEY (Contrato_com_segurado) REFERENCES segurado (Contrato_com_segurado);
ALTER TABLE oficina ADD CONSTRAINT seguro_Cnpj_da_Oficina_fkey FOREIGN KEY (Cnpj_da_Oficina) REFERENCES reparo (Cnpj_da_Oficina);
 
-- Quarto passo remover todas as tabelas 

DROP TABLE automovel CASCADE;
DROP TABLE segurado CASCADE;
DROP TABLE perito CASCADE;
DROP TABLE oficina CASCADE;
DROP TABLE seguro CASCADE;
DROP TABLE sinistro CASCADE;
DROP TABLE reparo CASCADE;
DROP TABLE pericia CASCADE;

-- Quinto passo criar as tabelas novamente ja com as chaves primaria, as estrangeiras e os "not null"

CREATE TABLE automovel(
	Cartegoria VARCHAR(20),
	Placa_do_carro CHAR(8) PRIMARY KEY,
	Chassi CHAR(21) ,
	Cor VARCHAR(20) NOT NULL,
	Ano CHAR(4),
	Modelo VARCHAR(20)
	
);

CREATE TABLE seguro(
	Contrato_com_oficina VARCHAR(20),
	Contrato_com_segurado VARCHAR(20),
	Contrato_com_perito VARCHAR(20),
	Chassi CHAR(21),
	Placa_do_carro CHAR(8) REFERENCES automovel(Placa_do_carro),
	Email VARCHAR(25) NOT NULL,
	CPF_do_segurado CHAR(14),
	PRIMARY KEY(Contrato_com_segurado)
	
);

CREATE TABLE segurado(
	Nome_segurado VARCHAR(30),
	Placa_do_carro CHAR(8) REFERENCES automovel(Placa_do_carro),
	CPF_do_segurado CHAR(14),
	AnodeNacimento DATE NOT NULL,
	Email VARCHAR(25) NOT NULL,
	Contrato_com_segurado VARCHAR(20) REFERENCES seguro(Contrato_com_segurado),
	PRIMARY KEY(CPF_do_segurado)
);

CREATE TABLE perito(
	Nome_perito VARCHAR(30),
	CPF_do_perito CHAR(14),
	Contrato_com_perito VARCHAR(20),
	Email_perito VARCHAR(25) NOT NULL,
	PRIMARY KEY(CPF_do_perito)
);

CREATE TABLE oficina(
	Cnpj_da_Oficina VARCHAR(18),
	Endereco TEXT NOT NULL,
	Telefone VARCHAR(20) NOT NULL,
	Contrato_com_oficina VARCHAR(20) ,
	PRIMARY KEY(Cnpj_da_Oficina)
);



CREATE TABLE sinistro(
	Ocorrencia VARCHAR(20),
	Local VARCHAR(30),
	Analise TEXT NOT NULL,
	DataHorario TIMESTAMP NOT NULL,
	Contrato_com_perito Varchar(20),
	Placa_do_carro CHAR(8) REFERENCES automovel(Placa_do_carro),
	PRIMARY KEY(Ocorrencia, Placa_do_carro)
	
);

CREATE TABLE pericia(
	Contrato_com_perito Varchar(20),
	Ocorrencia VARCHAR(20),
	Local VARCHAR(20) NOT NULL,
	Chassi CHAR(21),
	Analise TEXT NOT NULL,
	DataHorario TIMESTAMP NOT NULL,
	CPF_do_perito CHAR(14),
	Dano TEXT NOT NULL,
	Placa_do_carro CHAR(8) REFERENCES automovel(Placa_do_carro),
	CPF_do_segurado CHAR(14)REFERENCES segurado(CPF_do_segurado),
	PRIMARY KEY(Ocorrencia, Placa_do_carro, Contrato_com_perito)
);

CREATE TABLE reparo(
	Ocorrencia VARCHAR(20),
	Cnpj_da_Oficina VARCHAR(18) REFERENCES oficina(Cnpj_da_Oficina),
	Contrato_com_oficina VARCHAR(20),
	Chassi CHAR(21) NOT NULL,
	Placa_do_carro CHAR(8) REFERENCES automovel(Placa_do_carro),
	Analise TEXT NOT NULL,
	Preco NUMERIC,
	PRIMARY KEY(Cnpj_da_Oficina, Ocorrencia)
);

-- Sexto passo remover as tabelas, mas agora com a ordem pre determinada pelas relacoes das tabelas 

DROP TABLE reparo CASCADE;
DROP TABLE pericia CASCADE;
DROP TABLE sinistro CASCADE;
DROP TABLE perito CASCADE;
DROP TABLE oficina CASCADE;
DROP TABLE segurado CASCADE;
DROP TABLE seguro CASCADE;
DROP TABLE automovel CASCADE;

-- Setimo passo adcionar as tabelas de forma final com alguma tabela a mais se necessario

CREATE TABLE automovel(
	Cartegoria VARCHAR(20),
	Placa_do_carro CHAR(8) PRIMARY KEY,
	Chassi CHAR(21) ,
	Cor VARCHAR(20) NOT NULL,
	Ano CHAR(4),
	Modelo VARCHAR(20)
	
);

CREATE TABLE seguro(
	Contrato_com_oficina VARCHAR(20),
	Contrato_com_segurado VARCHAR(20),
	Contrato_com_perito VARCHAR(20),
	Chassi CHAR(21),
	Placa_do_carro CHAR(8) REFERENCES automovel(Placa_do_carro),
	Email VARCHAR(25) NOT NULL,
	CPF_do_segurado CHAR(14),
	PRIMARY KEY(Contrato_com_segurado)
	
);

CREATE TABLE segurado(
	Nome_segurado VARCHAR(30),
	Placa_do_carro CHAR(8) REFERENCES automovel(Placa_do_carro),
	CPF_do_segurado CHAR(14),
	AnodeNacimento DATE NOT NULL,
	Email VARCHAR(25) NOT NULL,
	Contrato_com_segurado VARCHAR(20) REFERENCES seguro(Contrato_com_segurado),
	PRIMARY KEY(CPF_do_segurado)
);

CREATE TABLE perito(
	Nome_perito VARCHAR(30),
	CPF_do_perito CHAR(14),
	Contrato_com_perito VARCHAR(20),
	Email_perito VARCHAR(25) NOT NULL,
	PRIMARY KEY(CPF_do_perito)
);

CREATE TABLE oficina(
	Cnpj_da_Oficina VARCHAR(18),
	Endereco TEXT NOT NULL,
	Telefone VARCHAR(20) NOT NULL,
	Contrato_com_oficina VARCHAR(20) ,
	PRIMARY KEY(Cnpj_da_Oficina)
);


CREATE TABLE sinistro(
	Ocorrencia VARCHAR(20),
	Local VARCHAR(30),
	Analise TEXT NOT NULL,
	DataHorario TIMESTAMP NOT NULL,
	Contrato_com_perito Varchar(20),
	CPF_do_segurado CHAR(14) REFERENCES segurado(CPF_do_segurado),
	Placa_do_carro CHAR(8) REFERENCES automovel(Placa_do_carro),
	PRIMARY KEY(Ocorrencia, Placa_do_carro)
	
);

CREATE TABLE pericia(
	Contrato_com_perito Varchar(20),
	Ocorrencia VARCHAR(20),
	Local VARCHAR(20) NOT NULL,
	Chassi CHAR(21),
	Analise TEXT NOT NULL,
	DataHorario TIMESTAMP NOT NULL,
	CPF_do_perito CHAR(14),
	Dano TEXT NOT NULL,
	Placa_do_carro CHAR(8) REFERENCES automovel(Placa_do_carro),
	CPF_do_segurado CHAR(14)REFERENCES segurado(CPF_do_segurado),
	PRIMARY KEY(Ocorrencia, Placa_do_carro, Contrato_com_perito)
);

CREATE TABLE reparo(
	Ocorrencia VARCHAR(20),
	Cnpj_da_Oficina VARCHAR(18) REFERENCES oficina(Cnpj_da_Oficina),
	Contrato_com_oficina VARCHAR(20),
	CPF_do_segurado CHAR(14) REFERENCES segurado(CPF_do_segurado),
	Chassi CHAR(21) NOT NULL,
	Placa_do_carro CHAR(8) REFERENCES automovel(Placa_do_carro),
	Analise TEXT NOT NULL,
	Preco NUMERIC,
	PRIMARY KEY(Cnpj_da_Oficina, Ocorrencia)
);









