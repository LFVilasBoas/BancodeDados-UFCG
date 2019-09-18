-- Questao 1
CREATE TABLE tarefas(
	Id_do_trabalhador INTEGER,
	Tarefa VARCHAR(70),
	Id_da_tarefa char(11),
	Id_do_local INTEGER,
	Setor_da_ufcg char(1) 
);

INSERT INTO tarefas Values
	(2147483646, 'limpar chão do corredor central', '98765432111', 0, 'F');
INSERT INTO tarefas Values
	(2147483647, 'limpar janelas da sala 203', '98765432122', 1, 'F');
INSERT INTO tarefas Values
	(null, null, null, null, null);

-- INSERT INTO tarefas Values
	(2147483644, 'limpar chão do corredor superior', '987654323211', 0, 'F');
-- NAO AUTORIZADA

-- INSERT INTO tarefas Values
	(2147483643, 'limpar chão do corredor superior', '98765432321', 0, 'FF');
-- NAO AUTORIZADA

-- Questao 2
ALTER TABLE tarefas ALTER COLUMN Id_do_trabalhador TYPE BIGINT;

INSERT INTO tarefas Values
	(2147483648, 'limpar portas do térreo', '32323232955', 4, 'A');

-- Questao 3

ALTER TABLE tarefas CONSTRAINT chk_id_localvalido Check (Id_do_local < 32768); 

INSERT INTO Tarefas VALUES (2147483651, 'limpar portas do 1o andar', '32323232911',32767,'A');

INSERT INTO Tarefas VALUES (2147483652, 'limpar portas do 2o andar', '32323232911',32766,'A');

-- Questao 4

DELETE FROM tarefas WHERE id_do_trabalhador is null;

ALTER TABLE Tarefas RENAME COLUMN Id_do_trabalhador TO id;
ALTER TABLE Tarefas RENAME COLUMN Tarefa TO descricao;
ALTER TABLE Tarefas RENAME COLUMN Id_da_tarefa TO func_resp_cpf;
ALTER TABLE Tarefas RENAME COLUMN Id_do_local TO prioridade;
ALTER TABLE Tarefas RENAME COLUMN Setor_da_ufcg TO status;

ALTER TABLE Tarefas ALTER COLUMN id SET NOT NULL;
ALTER TABLE Tarefas ALTER COLUMN descricao SET NOT NULL;
ALTER TABLE Tarefas ALTER COLUMN func_resp_cpf SET NOT NULL;
ALTER TABLE Tarefas ALTER COLUMN prioridade SET NOT NULL;
ALTER TABLE Tarefas ALTER COLUMN status SET NOT NULL;

-- Questao 5

ALTER TABLE Tarefas ADD CONSTRAINT key PRIMARY KEY (func_resp_cpf, id);

INSERT INTO Tarefas VALUES (2147483653, 'limpar portas do 1o andar', '32323232911',2,'A');

--INSERT INTO TAREFAS VALUES (2147483653, 'aparar a grama da área frontal', '32323232911',3,'A'); - NAO AUTORIZADO

-- Questao 6 - A

ALTER TABLE Tarefas ADD CONSTRAINT validaCPF CHECK (LENGTH(func_resp_cpf) = 11);

-- INSERT INTO TAREFAS VALUES (2147483653, 'limpar portas do 1o andar', '323232329115',2,'A'); -NAO AUTORIZADO

-- Questao 6 - B

UPDATE tarefas SET status = 'P' WHERE status = 'A';
UPDATE Tarefas SET status = 'E' WHERE status = 'R';
UPDATE Tarefas SET status = 'C' WHERE status = 'F';

ALTER TABLE Tarefas ADD CONSTRAINT verifcStatus CHECK (status = 'P' OR status = 'E' OR status = 'C');

-- Questao 7

UPDATE Tarefas SET prioridade = 5 WHERE prioridade = 32767;
UPDATE Tarefas SET prioridade = 5 WHERE prioridade = 32766;

ALTER TABLE Tarefas ADD CONSTRAINT verifcPrioridade CHECK (prioridade >= 0 AND prioridade <= 5);

-- Questao 8

CREATE TABLE funcionario(
	cpf VARCHAR(11) PRIMARY KEY,
	data_nasc DATE NOT NULL,
 	nome VARCHAR(30) NOT NULL,
 	funcao VARCHAR(11) NOT NULL,
	nivel CHAR(1),
	superior_cpf VARCHAR(11) REFERENCES funcionario(cpf)
);
 
ALTER TABLE funcionario ADD CONSTRAINT nivelJPS CHECK (nivel = 'J' OR nivel = 'P' OR nivel = 'S');
ALTER TABLE funcionario ADD CONSTRAINT funcaoDuo CHECK (funcao = 'SUP_LIMPEZA' OR funcao = 'LIMPEZA');
ALTER TABLE FUNCIONARIO ALTER COLUMN nivel SET NOT NULL;
ALTER TABLE funcionario ADD CONSTRAINT funcaoVERIFC CHECK(funcao = 'LIMPEZA' AND superior_cpf IS NOT NULL OR (funcao = 'SUP_LIMPEZA' and superior_cpf is null));

INSERT INTO funcionario(cpf,data_nasc,nome,funcao,nivel,superior_cpf) VALUES ('12345678911', '1982-05-07','Pedro da Silva', 'SUP_LIMPEZA', 'S', null);

INSERT INTO funcionario(cpf,data_nasc,nome,funcao,nivel,superior_cpf) VALUES ('12345678912', '1980-03-08','Jose da Silva', 'LIMPEZA', 'J', '12345678911');

-- INSERT INTO funcionario(cpf,data_nasc,nome,funcao,nivel,superior_cpf) VALUES ('12345678913', '1980-04-09','joao da Silva', 'LIMPEZA', 'J', null);
--não deve funcionar

-- Questao 9

INSERT INTO funcionario(cpf,data_nasc,nome,funcao,nivel,superior_cpf) VALUES ('12345678913', '1972-04-15','Seiya', 'SUP_LIMPEZA', 'P', null);
INSERT INTO funcionario(cpf,data_nasc,nome,funcao,nivel,superior_cpf) VALUES ('12345678914', '1972-03-25','Pikachu', 'LIMPEZA', 'J', '12345678913');
INSERT INTO funcionario(cpf,data_nasc,nome,funcao,nivel,superior_cpf) VALUES ('12345678915', '1972-03-27','Ash Ketchum', 'SUP_LIMPEZA', 'S', null);
INSERT INTO funcionario(cpf,data_nasc,nome,funcao,nivel,superior_cpf) VALUES ('12345678916', '1972-01-08','Ikki', 'LIMPEZA', 'P', '12345678915');
INSERT INTO funcionario(cpf,data_nasc,nome,funcao,nivel,superior_cpf) VALUES ('12345678917', '1972-01-01','Atena', 'LIMPEZA', 'J', '12345678916');
INSERT INTO funcionario(cpf,data_nasc,nome,funcao,nivel,superior_cpf) VALUES ('12345678918', '1972-01-31','Cirilo', 'LIMPEZA', 'P', '12345678917');
INSERT INTO funcionario(cpf,data_nasc,nome,funcao,nivel,superior_cpf) VALUES ('12345678919', '1972-01-10','Maria Joaquina', 'SUP_LIMPEZA', 'S', null);
INSERT INTO funcionario(cpf,data_nasc,nome,funcao,nivel,superior_cpf) VALUES ('12345678920', '1972-01-08','Paulao', 'SUP_LIMPEZA', 'P', null);
INSERT INTO funcionario(cpf,data_nasc,nome,funcao,nivel,superior_cpf) VALUES ('12345678921', '1972-01-08','Daniel Alves', 'LIMPEZA', 'S', '12345678920');
INSERT INTO funcionario(cpf,data_nasc,nome,funcao,nivel,superior_cpf) VALUES ('12345678922', '1972-01-08','Pablwo Matteus', 'SUP_LIMPEZA', 'P', null);

--INSERT INTO funcionario(cpf,data_nasc,nome,funcao,nivel,superior_cpf) VALUES ('123456789154', '1972-03-27','Yoga Telles', 'SUP_LIMPEZA', 'S', null); ERROR:  value too long for type character(11)

--INSERT INTO funcionario(cpf,data_nasc,nome,funcao,nivel,superior_cpf) VALUES ('12345678913', '1972-04-15','Dona Leila', 'SUP_LIMPEZA', 'P', null); ERROR:  duplicate key value violates unique constraint "funcionario_pkey"
--DETAIL:  Key (cpf)=(12345678913) already exists.

--INSERT INTO funcionario(cpf,data_nasc,nome,funcao,nivel,superior_cpf) VALUES ('12345678923', '1972-03-25','Gabriel Dantas', 'SUP_LIMPEZA', 'J', '12345678913'); ERROR:  new row for relation "funcionario" violates check constraint "funcaoVERIFC"
--DETAIL:  Failing row contains (12345678923, 1972-03-25, Gabriel Dantas, SUP_LIMPEZA, J, 12345678913).

--INSERT INTO funcionario(cpf,data_nasc,nome,funcao,nivel,superior_cpf) VALUES ('12345678916', '1972-01-08','Thiaguinho', 'LIMPEZA', 'P', null);ERROR:  new row for relation "funcionario" violates check constraint "checksuperior"
--DETAIL:  Failing row contains (12345678916, 1972-01-08, Rafaela Dantas, LIMPEZA, P, null).

--INSERT INTO funcionario(cpf,data_nasc,nome,funcao,nivel,superior_cpf) VALUES ('12345678925', '1972-01-01',null, 'SUP_LIMPEZA', 'J', null); ERROR:  null value in column "nome" violates not-null constraint
--DETAIL:  Failing row contains (12345678925, 1972-01-01, null, SUP_LIMPEZA, J, null).

--INSERT INTO funcionario(cpf,data_nasc,nome,funcao,nivel,superior_cpf) VALUES ('12345678945', '1972-01-314','Aline Miranda', 'LIMPEZA', 'P', '12345678917');ERROR:  date/time field value out of range: "1972-01-314"
--LINE 1: ...funcao,nivel,superior_cpf) VALUES ('12345678945', '1972-01-3...

--INSERT INTO funcionario(cpf,data_nasc,nome,funcao,nivel,superior_cpf) VALUES ('12345678932', '1972-01-10','Alic Miranda', 'SUP_LIMPEZA', 'S', '13245'); ERROR:  new row for relation "funcionario" violates check constraint "checksuperior"
--DETAIL:  Failing row contains (12345678932, 1972-01-10, Alic Miranda, SUP_LIMPEZA, S, 13245      ).

--INSERT INTO funcionario(cpf,data_nasc,nome,funcao,nivel,superior_cpf) VALUES (null, '1972-01-08','Helena Miranda', 'SUP_LIMPEZA', 'P', null); ERROR:  null value in column "cpf" violates not-null constraint
--DETAIL:  Failing row contains (null, 1972-01-08, Helena Miranda, SUP_LIMPEZA, P, null).

--INSERT INTO funcionario(cpf,data_nasc,nome,funcao,nivel,superior_cpf) VALUES ('12345678921', '1972-01-08','Marli Miranda', 'LIMPEZA', 'S', '12345678920'); ERROR:  duplicate key value violates unique constraint "funcionario_pkey"
--DETAIL:  Key (cpf)=(12345678921) already exists.

--INSERT INTO funcionario(cpf,data_nasc,nome,funcao,nivel,superior_cpf) VALUES ('12345678938', '1972-01-08','Julia Vitoria', 'SUP_LIMPEZA', 'L', null); ERROR:  new row for relation "funcionario" violates check constraint "checknivel"
--DETAIL:  Failing row contains (12345678938, 1972-01-08, Julia Vitoria, SUP_LIMPEZA, L, null).

-- Questao 10

INSERT INTO tarefas(id,descricao,func_resp_cpf,prioridade,status) VALUES ('2147483653','Limpeza da sala de Campelo','12345678913',5,'C');

INSERT INTO funcionario(cpf,data_nasc,nome,funcao,nivel,superior_cpf) VALUES ('32323232911', '1972-01-08','Gaviao Arqueiro', 'SUP_LIMPEZA', 'P', null);
INSERT INTO funcionario(cpf,data_nasc,nome,funcao,nivel,superior_cpf) VALUES ('32323232955', '1972-01-08','Pelé', 'SUP_LIMPEZA', 'P', null);
INSERT INTO funcionario(cpf,data_nasc,nome,funcao,nivel,superior_cpf) VALUES ('98765432122', '1972-01-08','Cebolinha da Turma da Monica', 'LIMPEZA', 'P', '32323232911');
INSERT INTO funcionario(cpf,data_nasc,nome,funcao,nivel,superior_cpf) VALUES ('98765432111', '1972-03-30','Anita', 'LIMPEZA', 'J', '32323232911');

ALTER TABLE tarefas ADD CONSTRAINT key_cpf_verific FOREIGN KEY (func_resp_cpf) REFERENCES funcionario (cpf) ON DELETE CASCADE;

-- Questao 11

ALTER TABLE tarefas ADD CONSTRAINT caso_e CHECK ((status = 'E' AND id IS NOT NULL) OR status = 'C' or status = 'P');

ALTER TABLE tarefas DROP CONSTRAINT fgkey_cpf;

ALTER TABLE tarefas ADD CONSTRAINT fgkey_cpf FOREIGN KEY (func_resp_cpf) REFERENCES funcionario (cpf) ON DELETE CASCADE SET NULL;



-- ssh -o ServerAliveInterval=30 luiz@150.165.85.37 -p 45600
-- psql -d luiz_db

 



































