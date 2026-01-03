-- CRIAR BANCO DE DADOS
CREATE DATABASE altoville_market;
-- VISUALIZANDO O BANCO DE DADOS
SHOW DATABASES;
-- USANDO O BANCO DE DADOS CRIADO
USE altoville_market;
-- CRIANDO A TABELA TB_CLIENTES
CREATE TABLE tb_clientes(
cli_id INT AUTO_INCREMENT PRIMARY KEY,
cli_nome VARCHAR(100) NOT NULL,
cli_cpf VARCHAR(15) NOT NULL,
cli_logradouro VARCHAR(250),
cli_numero VARCHAR (10),
cli_bairro VARCHAR(100),
cli_cidade VARCHAR(100),
cli_estado CHAR(2),
cli_cep VARCHAR (10),
cli_telefone VARCHAR(15),
cli_email VARCHAR(100)
);
-- CRIANDO A TABELA TB_COLABORADORES
CREATE TABLE tb_colaboradores(
col_id INT AUTO_INCREMENT PRIMARY KEY,
col_nome VARCHAR(100) NOT NULL,
col_cpf VARCHAR(15) NOT NULL,
col_telefone VARCHAR(15),
col_cargo VARCHAR (100),
col_email VARCHAR (100)
);
-- CRIANDO A TABELA TB_VENDAS
CREATE TABLE tb_vendas(
vend_id INT AUTO_INCREMENT PRIMARY KEY,
vend_data_venda DATE,
vend_valor_total DECIMAL(10,2) NOT NULL,
vend_status_venda ENUM('pendente','pago','cancelado','entregue') DEFAULT 'pendente',
vend_cliid INT,
vend_colid INT,
FOREIGN KEY(vend_cliid) REFERENCES tb_clientes(cli_id),
FOREIGN KEY(vend_colid) REFERENCES tb_colaboradores(col_id)
);
-- VERIFICANDO SE AS TABELAS ESTAO SENDO CRIADAS
SHOW TABLES;
-- CRIANDO A TABELA PAGAMENTOS
CREATE TABLE tb_pagamentos(
pag_id INT AUTO_INCREMENT PRIMARY KEY,
pag_status ENUM('pendente','aprovado','cancelado','estornado','em_processamento') DEFAULT 'pendente',
pag_data DATE,
pag_valor DECIMAL(10,2) NOT NULL,
pag_metodo VARCHAR(50),
pag_cliid INT,
pag_vendid INT,
FOREIGN KEY(pag_cliid) REFERENCES tb_clientes(cli_id),
FOREIGN KEY(pag_vendid) REFERENCES tb_vendas(vend_id)
);
-- CRIANDO A TABELA TB_DEVOLUCAO
CREATE TABLE tb_devolucao(
dev_id INT AUTO_INCREMENT PRIMARY KEY,
dev_data DATE,
dev_motivo TEXT,
dev_vendid INT,
FOREIGN KEY(dev_vendid) REFERENCES tb_vendas(vend_id)
);
-- CRIANDO A TABELA TB_CATEGORIA
CREATE TABLE tb_categoria(
cat_id INT AUTO_INCREMENT PRIMARY KEY,
cat_nome VARCHAR(100) NOT NULL,
cat_descricao TEXT
);
-- CRIANDO A TABELA TB_PROMOCAO
CREATE TABLE tb_promocao(
promo_id INT AUTO_INCREMENT PRIMARY KEY,
promo_nome VARCHAR(100) NOT NULL,
promo_desconto DECIMAL(10,2) NOT NULL,
promo_data_inicio DATE NOT NULL,
promo_data_fim DATE NOT NULL
);
-- CRIANDO A TABELA TB_SETOR
CREATE TABLE tb_setor(
set_id INT AUTO_INCREMENT PRIMARY KEY,
set_nome VARCHAR(100) NOT NULL,
set_descricao TEXT,
set_localizacao VARCHAR(150)
);
-- CRIANDO A TABELA TB_PRODUTOS
CREATE TABLE tb_produtos(
prod_id INT AUTO_INCREMENT PRIMARY KEY,
prod_nome VARCHAR(100) NOT NULL,
prod_descricao TEXT,
prod_qtde_estoque INT NOT NULL DEFAULT 0,
prod_valor_compra DECIMAL(10,2) NOT NULL,
prod_valor_venda DECIMAL(10,2) NOT NULL,
prod_setid INT,
prod_catid INT,
prod_promoid INT,
FOREIGN KEY(prod_setid) REFERENCES tb_setor(set_id),
FOREIGN KEY(prod_catid) REFERENCES tb_categoria(cat_id),
FOREIGN KEY(prod_promoid) REFERENCES tb_promocao(promo_id)
);
-- CRIANDO A TABELA TB_ENTRADA_ESTOQUE
CREATE TABLE tb_entrada_estoque(
entr_id INT AUTO_INCREMENT PRIMARY KEY,
entr_data DATE,
entr_qtde_total INT NOT NULL,
entr_prodid INT,
FOREIGN KEY(entr_prodid) REFERENCES tb_produtos(prod_id)
);
-- CRIANDO A TABELA TB_PRODUTOS_VENDAS
CREATE TABLE tb_produtos_vendas(
prve_id INT AUTO_INCREMENT PRIMARY KEY,
prve_prodid INT,
prve_vendid INT,
FOREIGN KEY(prve_prodid) REFERENCES tb_produtos(prod_id),
FOREIGN KEY(prve_vendid) REFERENCES tb_vendas(vend_id)
);
-- CRIANDO A TABELA TB_DEVOLUCAO_PRODUTOS
CREATE TABLE tb_devolucao_produtos(
depr_id INT AUTO_INCREMENT PRIMARY KEY,
depr_devid INT,
depr_prodid INT,
FOREIGN KEY(depr_devid) REFERENCES tb_devolucao(dev_id),
FOREIGN KEY(depr_prodid) REFERENCES tb_produtos(prod_id)
);
-- VISUALIZANDO TODAS AS TABELAS
SHOW TABLES;
-- INSERINDO DADOS NA TABELA tb_clientes
INSERT INTO tb_clientes (cli_nome, cli_cpf, cli_logradouro, cli_numero, cli_bairro, cli_cidade, cli_estado, cli_cep, cli_telefone, cli_email)
VALUES
('João Silva', '123.456.789-00', 'Rua das Flores', '100', 'Jardim Primavera', 'São Paulo', 'SP', '01234-678', '(11) 98765-4321', 'jsilva@gmail.com'),
('Maria Santos', '987.654.321-00', 'Av. Central', '500', 'Centro', 'Rio de Janeiro', 'RJ', '20000-999', '(21) 91234-5678', 'mariasantos@gmail.com'),
('Pedro Almeida', '222.333.444-55', 'Rua do Sol', '250', 'Vila Nova', 'Belo Horizonte', 'MG', '30123-111', '(31) 97654-3210', 'pedroalmeida@gmail.com'),
('Ana Costa', '333.444.555-66', 'Rua das Acácias', '150', 'Jardim das Flores', 'Curitiba', 'PR', '80010-222', '(41) 95555-1234', 'anacosta@gmail.com'),
('Lucas Pereira', '444.555.666-77', 'Av. Liberdade', '200', 'Centro', 'Porto Alegre', 'RS', '90010-333', '(51) 94444-5678', 'lucaspereira@gmail.com'),
('Mariana Rocha', '555.666.777-88', 'Rua Nova', '75', 'Bela Vista', 'Fortaleza', 'CE', '60010-444', '(85) 93333-9876', 'marianarocha@gmail.com'),
('Rafael Martins', '666.777.888-99', 'Av. Brasil', '300', 'Centro', 'Recife', 'PE', '50010-555', '(81) 92222-6543', 'rafamartins2@gmail.com'),
('Carla Nunes', '777.888.999-00', 'Rua das Palmeiras', '120', 'Vila Nova', 'Salvador', 'BA', '40010-666', '(71) 91111-3210', 'carlanunes@gmail.com'),
('Bruno Lima', '888.999.000-11', 'Av. São João', '400', 'Centro', 'Manaus', 'AM', '69010-777', '(92) 90000-4321', 'brunolima@gmail.com'),
('Fernanda Alves', '999.000.111-22', 'Rua das Orquídeas', '80', 'Jardim Primavera', 'Florianópolis', 'SC', '88010-888', '(48) 98888-5678', 'fealves@gmail.com');
-- INSERINDO DADOS NA TABELA tb_colaboradores
INSERT INTO tb_colaboradores (col_nome, col_cpf, col_telefone, col_cargo, col_email)
VALUES
('Carlos Pereira', '111.222.333-44', '(11) 90000-1111', 'Caixa', 'carlos@altoville.com'),
('Ana Rodrigues', '555.666.777-88', '(11) 91111-2222', 'Gerente', 'ana@altoville.com'),
('Marcos Lima', '999.888.777-66', '(11) 92222-3333', 'Estoque', 'marcos@altoville.com'),
('Patrícia Souza', '222.333.444-55', '(11) 93333-4444', 'Atendimento', 'patricia@altoville.com'),
('Felipe Castro', '333.444.555-66', '(11) 94444-5555', 'Supervisor', 'felipe@altoville.com');
-- INSERINDO DADOS NA TABELA tb_categoria
INSERT INTO tb_categoria (cat_nome, cat_descricao)
VALUES
('Eletrônicos', 'Produtos eletrônicos e acessórios'),
('Alimentos', 'Produtos alimentícios e bebidas'),
('Higiene', 'Produtos de cuidados pessoais'),
('Bebidas', 'Refrigerantes, sucos e água'),
('Limpeza', 'Produtos de limpeza doméstica');
-- INSERINDO DADOS NA TABELA tb_setor
INSERT INTO tb_setor (set_nome, set_descricao, set_localizacao)
VALUES
('Setor de Eletrônicos', 'Produtos de tecnologia', 'Avenida Principal, 100'),
('Setor de Alimentos', 'Produtos alimentícios', 'Rua Secundária, 50'),
('Setor de Higiene', 'Produtos de higiene e limpeza', 'Rua do Comércio, 20'),
('Setor de Bebidas', 'Bebidas e refrigerantes', 'Rua do Lazer, 15'),
('Setor de Limpeza', 'Produtos de limpeza doméstica', 'Rua Industrial, 30');
-- INSERINDO DADOS NA TABELA tb_promocao
INSERT INTO tb_promocao (promo_nome, promo_desconto, promo_data_inicio, promo_data_fim)
VALUES
('Promoção de Verão', 10.00, '2025-11-01', '2025-11-30'),
('Black Friday', 20.00, '2025-11-25', '2025-11-29'),
('Natal Feliz', 15.00, '2025-12-01', '2025-12-24'),
('Semana do Cliente', 5.00, '2025-11-10', '2025-11-16'),
('Liquidação Anual', 25.00, '2025-12-01', '2025-12-10');
-- INSERINDO DADOS NA TABELA tb_produtos
INSERT INTO tb_produtos (prod_nome, prod_descricao, prod_qtde_estoque, prod_valor_compra, prod_valor_venda, prod_setid, prod_catid, prod_promoid)
VALUES
('Smartphone X', 'Smartphone 128GB', 50, 1500.00, 2000.00, 1, 1, 1),
('Notebook Y', 'Notebook 16GB RAM', 30, 2500.00, 3200.00, 1, 1, 2),
('Arroz Tipo 1', 'Pacote 5kg', 200, 15.00, 20.00, 2, 2, 2),
('Feijão Preto', 'Pacote 1kg', 150, 7.00, 10.00, 2, 2, 3),
('Shampoo Hidratante', 'Shampoo 500ml', 100, 10.00, 15.00, 3, 3, 3),
('Sabonete Lux', 'Pacote com 3 unidades', 200, 5.00, 8.00, 3, 3, 4),
('Refrigerante Cola', 'Lata 350ml', 300, 3.00, 5.00, 4, 4, 4),
('Suco Natural', 'Pacote 1L', 250, 4.00, 6.00, 4, 4, 1),
('Detergente Líquido', '500ml', 180, 2.50, 4.00, 5, 5, 5),
('Desinfetante Multiuso', '1L', 120, 6.00, 10.00, 5, 5, 5);
-- INSERINDO DADOS NA TABELA tb_vendas
INSERT INTO tb_vendas (vend_data_venda, vend_valor_total, vend_status_venda, vend_cliid, vend_colid)
VALUES
('2025-11-01', 2000.00, 'pago', 1, 1),
('2025-11-02', 3200.00, 'pendente', 2, 2),
('2025-11-03', 20.00, 'entregue', 3, 3),
('2025-11-04', 10.00, 'cancelado', 4, 1),
('2025-11-05', 15.00, 'pago', 5, 2),
('2025-11-06', 8.00, 'pendente', 6, 3),
('2025-11-07', 5.00, 'entregue', 7, 4),
('2025-11-08', 6.00, 'pago', 8, 5),
('2025-11-09', 4.00, 'pendente', 9, 1),
('2025-11-10', 10.00, 'entregue', 10, 2);
-- INSERINDO DADOS NA TABELA tb_pagamentos
INSERT INTO tb_pagamentos (pag_status, pag_data, pag_valor, pag_metodo, pag_cliid, pag_vendid)
VALUES
('aprovado', '2025-11-01', 2000.00, 'Cartão de Crédito', 1, 1),
('pendente', '2025-11-02', 3200.00, 'PIX', 2, 2),
('aprovado', '2025-11-03', 20.00, 'Dinheiro', 3, 3),
('cancelado', '2025-11-04', 10.00, 'PIX', 4, 4),
('aprovado', '2025-11-05', 15.00, 'Cartão Débito', 5, 5),
('pendente', '2025-11-06', 8.00, 'PIX', 6, 6),
('aprovado', '2025-11-07', 5.00, 'Dinheiro', 7, 7),
('aprovado', '2025-11-08', 6.00, 'Cartão Crédito', 8, 8),
('pendente', '2025-11-09', 4.00, 'PIX', 9, 9),
('aprovado', '2025-11-10', 10.00, 'Dinheiro', 10, 10);
-- INSERINDO DADOS NA TABELA tb_entrada_estoque
INSERT INTO tb_entrada_estoque (entr_data, entr_qtde_total, entr_prodid)
VALUES
('2025-10-30', 50, 1),
('2025-10-30', 30, 2),
('2025-10-31', 200, 3),
('2025-10-31', 150, 4),
('2025-10-31', 100, 5),
('2025-11-01', 200, 6),
('2025-11-01', 300, 7),
('2025-11-02', 250, 8),
('2025-11-02', 180, 9),
('2025-11-03', 120, 10);
-- INSERINDO DADOS NA TABELA tb_produtos_vendas
INSERT INTO tb_produtos_vendas (prve_prodid, prve_vendid)
VALUES
(1,1),(2,2),(3,3),(4,4),(5,5),(6,6),(7,7),(8,8),(9,9),(10,10);
-- INSERINDO DADOS NA TABELA tb_devolucao
INSERT INTO tb_devolucao (dev_data, dev_motivo, dev_vendid)
VALUES
('2025-11-04', 'Produto com defeito', 1),
('2025-11-05', 'Entrega atrasada', 2),
('2025-11-06', 'Produto errado', 3),
('2025-11-07', 'Insatisfação do cliente', 4),
('2025-11-08', 'Produto danificado', 5);
-- INSERINDO DADOS NA TABELA tb_devolucao_produtos
INSERT INTO tb_devolucao_produtos (depr_devid, depr_prodid)
VALUES
(1,1),(2,2),(3,3),(4,4),(5,5);
-- Listando todos os clientes
SELECT * FROM tb_clientes;
-- Listando todos os colaboradores e seus cargos
SELECT col_nome, col_cargo, col_telefone, col_email FROM tb_colaboradores;
-- Listando produtos com categoria, setor e promoção
SELECT p.prod_nome, p.prod_descricao, p.prod_qtde_estoque, 
p.prod_valor_venda, c.cat_nome AS categoria, s.set_nome AS setor, pr.promo_nome AS promocao
FROM tb_produtos p
JOIN tb_categoria c ON p.prod_catid = c.cat_id
JOIN tb_setor s ON p.prod_setid = s.set_id
LEFT JOIN tb_promocao pr ON p.prod_promoid = pr.promo_id;
-- Total vendido por colaborador
SELECT col.col_nome, SUM(v.vend_valor_total) AS total_vendido, COUNT(v.vend_id) AS qtd_vendas
FROM tb_vendas v
JOIN tb_colaboradores col ON v.vend_colid = col.col_id
GROUP BY col.col_nome;
-- Produtos mais vendidos
SELECT p.prod_nome, COUNT(pv.prve_id) AS vezes_vendido
FROM tb_produtos_vendas pv
JOIN tb_produtos p ON pv.prve_prodid = p.prod_id
GROUP BY p.prod_nome
ORDER BY vezes_vendido DESC;
-- Pagamentos pendentes
SELECT p.pag_id, p.pag_valor, p.pag_metodo, c.cli_nome, v.vend_id
FROM tb_pagamentos p
JOIN tb_clientes c ON p.pag_cliid = c.cli_id
JOIN tb_vendas v ON p.pag_vendid = v.vend_id
WHERE p.pag_status = 'pendente';
-- Devoluções realizadas
SELECT d.dev_id, d.dev_data, d.dev_motivo, v.vend_id, c.cli_nome
FROM tb_devolucao d
JOIN tb_vendas v ON d.dev_vendid = v.vend_id
JOIN tb_clientes c ON v.vend_cliid = c.cli_id;
-- Resumo de vendas por status
SELECT vend_status_venda, COUNT(*) AS quantidade, SUM(vend_valor_total) AS total
FROM tb_vendas
GROUP BY vend_status_venda;
-- Produtos em promoção
SELECT p.prod_nome, pr.promo_nome, pr.promo_desconto, pr.promo_data_inicio, pr.promo_data_fim
FROM tb_produtos p
JOIN tb_promocao pr ON p.prod_promoid = pr.promo_id
ORDER BY pr.promo_data_inicio;