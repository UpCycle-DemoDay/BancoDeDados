DROP DATABASE IF EXISTS upcycle_data;

CREATE DATABASE IF NOT EXISTS upcycle_data;
USE upcycle_data;

CREATE TABLE IF NOT EXISTS endereco_admin(
	id_endereco_admin INT PRIMARY KEY AUTO_INCREMENT,
	rua_admin VARCHAR(120) NOT NULL,
	estado_admin VARCHAR(120) NOT NULL, 
	bairro_admin VARCHAR(120) NOT NULL, 
	cidade_admin VARCHAR(120) NOT NULL, 
	uf_admin VARCHAR(2) NOT NULL, 
	complemento_admin VARCHAR(120) NOT NULL, 
	numero_admin INT NOT NULL,
	cep_admin VARCHAR(10) NOT NULL
);

CREATE TABLE IF NOT EXISTS fale_conosco (
    id_fale_conosco INT PRIMARY KEY AUTO_INCREMENT,
    nome_usuario VARCHAR(255) NOT NULL,
    email_usuario VARCHAR(255) NOT NULL,
    assunto_usuario VARCHAR(255) NOT NULL,
    resposta_admin VARCHAR(255) NOT NULL,
    hr_requisicao VARCHAR(15) NOT NULL,
    hr_resposta VARCHAR(15) NOT NULL,
    dt_resposta VARCHAR(15) NOT NULL,
    dt_fechamento VARCHAR(15) NOT NULL
);


CREATE TABLE IF NOT EXISTS endereco_comum (
	id_endereco_comum INT PRIMARY KEY AUTO_INCREMENT,
	rua_comum VARCHAR (120) NOT NULL,
    numero_comum VARCHAR (10) NOT NULL,
    bairro_comum VARCHAR(120) NOT NULL,
    cidade_comum VARCHAR(120) NOT NULL,
	estado_comum VARCHAR(120) NOT NULL,
	uf_comum VARCHAR(2) NOT NULL, 
    cep_comum VARCHAR(120) NOT NULL,
	complemento_comum VARCHAR(120)
);

CREATE TABLE endereco_ferrovelho(
	id_enderecoferrovelho INT PRIMARY KEY AUTO_INCREMENT,
    rua_ferrovelho VARCHAR(150) NOT NULL,
    numero_ferrovelho VARCHAR(10) NOT NULL,
    bairro_ferrovelho VARCHAR(150) NOT NULL,
    cidade_ferrovelho VARCHAR(100) NOT NULL,
    estado_ferrovelho VARCHAR(100) NOT NULL,
    uf_ferrovelho VARCHAR(3) NOT NULL,
    cep_ferrovelho VARCHAR(50) NOT NULL,
    complemento_ferrovelho VARCHAR(150)
);

CREATE TABLE IF NOT EXISTS admim (
	id_admin INT PRIMARY KEY AUTO_INCREMENT,
	nome_admin VARCHAR(120) NOT NULL,
	email_admin VARCHAR(120) NOT NULL,
	senha_admin VARCHAR(120) NOT NULL, 
	cpf_admin VARCHAR(15) NOT NULL,  
	telefone_admin VARCHAR(20) NOT NULL, 
	data_nascimento_admin DATE NULL,
	id_endereco_admin INT,
	FOREIGN KEY (id_endereco_admin) REFERENCES endereco_admin(id_endereco_admin) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE cadastro_ferrovelho(
	id_ferrovelho INT PRIMARY KEY AUTO_INCREMENT,
    nome_ferrovelho VARCHAR(150) NOT NULL,
    cnpj VARCHAR(20) UNIQUE NOT NULL,
    email_ferrovelho VARCHAR(150) UNIQUE NOT NULL,
    telefone_ferrovelho VARCHAR(20),
    descricao_materiais text NOT NULL,
    senha_ferrovelho VARCHAR(150) NOT NULL,
    id_enderecoferrovelho INT,
    FOREIGN KEY(id_enderecoferrovelho) REFERENCES endereco_ferrovelho(id_enderecoferrovelho) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE cliente_comum (
	id_cliente_comum INT PRIMARY KEY AUTO_INCREMENT,
	nome_comum VARCHAR(120) NOT NULL, 
	cpf_comum VARCHAR(15) NOT NULL,
	email_comum VARCHAR(120) NOT NULL,
    telefone_comum VARCHAR(20) NOT NULL,
	data_nascimento_comum DATE NOT NULL,
	senha_comum VARCHAR(120) NOT NULL, 
	id_endereco_comum INT,
	FOREIGN KEY(id_endereco_comum) REFERENCES endereco_comum(id_endereco_comum) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE produto_cliente (
	id_produto_cliente INT PRIMARY KEY AUTO_INCREMENT,
	nome_produto_cliente VARCHAR(120) NOT NULL, 
	descricao_produto_cliente VARCHAR(120) NOT NULL,
	valor_produto_cliente VARCHAR(120) NOT NULL, 
	quantidade_produto_cliente int(255) NOT NULL, 
	medida_produto_cliente VARCHAR(120) NOT NULL, 
	id_cliente_comum INT NOT NULL,
	FOREIGN KEY(id_cliente_comum) REFERENCES cliente_comum(id_cliente_comum) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS endereco_transporte (
	id_endereco_transporte INT PRIMARY KEY AUTO_INCREMENT,
	rua_transporte VARCHAR(120) NOT NULL,
	estado_transporte VARCHAR(120) NOT NULL,
	bairro_transporte VARCHAR(120) NOT NULL, 
	cidade_transporte VARCHAR(120) NOT NULL,  
	uf_transporte VARCHAR(2) NOT NULL, 
	complemento_transporte VARCHAR(120) NOT NULL,
	numero_transporte INT NOT NULL,
	cep_transporte VARCHAR(120) NOT NULL
);

CREATE TABLE parceria_transporte (
	id_parceria_transporte INT PRIMARY KEY AUTO_INCREMENT,
	nome_parceria_transporte VARCHAR(120) NOT NULL, 
	email_parceria_transporte VARCHAR(120) NOT NULL, 
	cnpj_parceria_transporte VARCHAR(15) NOT NULL, 
	id_endereco_transporte INT NOT NULL,
	FOREIGN KEY(id_endereco_transporte) REFERENCES endereco_transporte(id_endereco_transporte) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE ordem_servico (
    id_ordem_servico INT PRIMARY KEY AUTO_INCREMENT, 
    dt_criacao DATE NOT NULL, 
    dt_conclusao DATE NOT NULL, 
    desc_estado_ordem TEXT NOT NULL, 
    desc_servico TEXT NOT NULL, 
    id_produto_cliente INT NOT NULL, 
    id_parceria_transporte INT NOT NULL, 
    id_ferrovelho INT NOT NULL,
    id_cliente_comum INT NOT NULL,
    FOREIGN KEY(id_produto_cliente) REFERENCES produto_cliente(id_produto_cliente) ON DELETE CASCADE ON UPDATE CASCADE, 
    FOREIGN KEY(id_parceria_transporte) REFERENCES parceria_transporte(id_parceria_transporte) ON DELETE CASCADE ON UPDATE CASCADE, 
    FOREIGN KEY(id_ferrovelho) REFERENCES cadastro_ferrovelho(id_ferrovelho) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS produto_ordem_servico (
	produto_ordem_servico INT PRIMARY KEY AUTO_INCREMENT,
	id_produto_cliente INT(11) NOT NULL,
	id_ordem_servico INT(11) NOT NULL,
	FOREIGN KEY(id_produto_cliente) REFERENCES produto_cliente (id_produto_cliente) ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY(id_ordem_servico) REFERENCES ordem_servico (id_ordem_servico) ON DELETE CASCADE ON UPDATE CASCADE 
);
