CREATE TYPE estado AS ENUM('PB','RN','SE','AL','BA','PI','PE','CE','MA');

CREATE TYPE endereco AS ENUM('residencia','trabalho','outro');


CREATE TABLE farmacias (
    id SERIAL PRIMARY KEY,
    tipo CHAR(1) NOT NULL,
    gerente_cpf CHAR(11) UNIQUE NOT NULL,
    bairro TEXT NOT NULL,
    cidade TEXT NOT NULL,
    estado_farm estado NOT NULL,
    tipo_gerente CHAR(1) NOT NULL,

    CONSTRAINT tp_verifc CHECK(tipo = 'S' OR tipo = 'F'),
    CONSTRAINT fc_verifc CHECK(tipo_gerente= 'F' OR tipo_gerente='A'),
    CONSTRAINT sede_unica EXCLUDE USING gist (tipo WITH =) WHERE (tipo = 'S'),
    CONSTRAINT farm_unica_bairro EXCLUDE USING gist (bairro WITH =, cidade WITH=)
);


CREATE TABLE funcionarios (
    cpf CHAR(11) UNIQUE PRIMARY KEY,
    nome TEXT NOT NULL,
    funcao CHAR(1) NOT NULL,
    id_farmacia INTEGER,

    CONSTRAINT fc_verifc CHECK(funcao= 'F' OR funcao= 'V' OR funcao= 'E' OR funcao= 'C' OR funcao= 'A')
);

ALTER TABLE farmacias ADD CONSTRAINT key_geren FOREIGN KEY (gerente_cpf) REFERENCES funcionarios(cpf);


CREATE TABLE clientes (
    cpf CHAR(11) UNIQUE PRIMARY KEY,
    nome TEXT NOT NULL,
    data_nascimento DATE NOT NULL,

    CONSTRAINT mais_dezoito CHECK(((EXTRACT(YEAR FROM data_nascimento) = 2000 AND EXTRACT(MONTH FROM data_nascimento) < 9 AND EXTRACT(DAY FROM data_nascimento) < 28)) OR (EXTRACT(YEAR FROM data_nascimento) < 2000))
);


CREATE TABLE enderecos_clientes (
    id SERIAL PRIMARY KEY,
    cpf_cliente CHAR(11) REFERENCES clientes(cpf),
    cidade VARCHAR(20) NOT NULL,
    estado estado NOT NULL,
    rua VARCHAR(20) NOT NULL,
    bairro VARCHAR(20) NOT NULL,
    numero VARCHAR(30) NOT NULL,
    tipo endereco NOT NULL
);

CREATE TABLE medicamentos (
    id SERIAL PRIMARY KEY,
    nome TEXT NOT NULL,
    venda_exclusiva_rec BOOLEAN NOT NULL
);

CREATE TABLE vendas (
    codigo INTEGER PRIMARY KEY,
    id_medicamento INTEGER NOT NULL REFERENCES medicamentos(id),
    cliente_cpf CHAR(11) REFERENCES clientes(cpf),
    func_cpf CHAR(11) REFERENCES funcionarios(cpf),
    receita_exclusiva BOOLEAN NOT NULL,
    func_funcionario CHAR(1) NOT NULL,
    
    CONSTRAINT func_verifc CHECK(func_funcionario= 'V'),
    CONSTRAINT exclu_verif CHECK ((cliente_cpf IS NULL AND receita_exclusiva = false) OR (cliente_cpf IS NOT NULL)) 
);

CREATE TABLE entregas (
    codigo SERIAL PRIMARY KEY,
    cliente_cpf CHAR(11) REFERENCES clientes(cpf),
    tipo_endereco endereco NOT NULL,
    codigo_venda INTEGER REFERENCES vendas(codigo)
    
);

-- inserindo funcionario normal
INSERT INTO funcionarios VALUES ('12345678905', 'Antenor', 'V', 1);

-- insere um funcionário que não está alocado em nenhuma farmácia
INSERT INTO funcionarios VALUES ('12345678901', 'Joao', 'V', null);

-- insere um funcionário alocado em uma farmácia como administrador
INSERT INTO funcionarios VALUES ('12345678902', 'Pedro', 'A', 0);

-- insere um funcionário alocado em uma farmácia como administrador
INSERT INTO funcionarios VALUES ('12454644786', 'Pedro VARGAS', 'A', 0);

-- insere uma farmacia como sede, não deve aceitar outra inserção com esse mesmo tipo
INSERT INTO farmacias (tipo, gerente_cpf, tipo_gerente, cidade, bairro, estado_farm) VALUES ('S', '12345678902', 'A', 'Campina Grande', 'Alto Branco', 'PB');

-- insere uma segunda farmácia como sede (não funciona)
INSERT INTO farmacias (tipo, gerente_cpf, tipo_gerente, cidade, bairro, estado_farm) VALUES ('S', '12454644786', 'A', 'Campina Grande', 'Bodocongó', 'PB');

-- só pode haver uma farmácia por bairro (não funciona)
INSERT INTO farmacias (tipo, gerente_cpf, tipo_gerente, cidade, bairro, estado_farm) VALUES ('F', '12454644786', 'A', 'Campina Grande', 'Alto Branco', 'PB');

-- inserindo cliente
INSERT INTO clientes VALUES ('12345678909', 'João',  '1900-01-01');
INSERT INTO clientes VALUES ('12345678908', 'Josefa',  '1900-01-01');

-- inserindo cliente de menor (não funciona)
INSERT INTO clientes VALUES ('12345678903', 'Enzo',  '2002-01-01');

-- Inserindo endereço de clientes
INSERT INTO enderecos_clientes (cpf_cliente, cidade, estado, rua, bairro, numero, tipo) VALUES ('12345678909', 'Fagundes', 'PB', 'Rua dos Pombos', 'Centro', 0, 'residencia');

-- O mesmo funcionário pode ter vários endereços
INSERT INTO enderecos_clientes (cpf_cliente, cidade, estado, rua, bairro, numero, tipo) VALUES ('12345678909', 'João Pessoa', 'PB', 'Ruy Carneiro', 'Centro', 10, 'residencia');

-- Inserindo endereço de um cliente com tipo inválido (não funciona)
INSERT INTO enderecos_clientes (cpf_cliente, cidade, estado, rua, bairro, numero, tipo) VALUES ('12345678909', 'Fagundes', 'PB', 'Rua dos Pombos', 'Centro', 0, 'pardaria');

-- Inserindo endereço de um cliente que não está cadastrado (não funciona)
INSERT INTO enderecos_clientes (cpf_cliente, cidade, estado, rua, bairro, numero, tipo) VALUES ('12345678910', 'Fagundes', 'PB', 'Rua dos Pombos', 'Centro', 0, 'residencia');

-- INSERINDO MEDICAMENTOS
INSERT INTO medicamentos (nome, venda_exclusiva_rec) VALUES ('dipirona', false);
INSERT INTO medicamentos (nome, venda_exclusiva_rec) VALUES ('tylenol', false);
INSERT INTO medicamentos (nome, venda_exclusiva_rec) VALUES ('viagra', true);

-- Cadastrando vendas
INSERT INTO vendas (codigo, id_medicamento, cliente_cpf, func_cpf, receita_exclusiva, func_funcionario) VALUES (3, 1, '12345678909', '12345678905', false, 'V');
INSERT INTO vendas (codigo, id_medicamento, cliente_cpf, func_cpf, receita_exclusiva, func_funcionario) VALUES (77, 1, '12345678909', '12345678905', false, 'V');

-- Cadastrando venda de quem nao é vendedor(não funciona)
INSERT INTO vendas (codigo, id_medicamento, cliente_cpf, func_cpf, receita_exclusiva, func_funcionario) VALUES (22, 1, '12345678909', '12454644786', false, 'A');

-- Cadastrar entrega 
INSERT INTO entregas (cliente_cpf, tipo_endereco, codigo_venda) VALUES ('12345678909', 'residencia', 3);
