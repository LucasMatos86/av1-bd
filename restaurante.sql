CREATE DATABASE restaurante;

USE restaurante;

/***** TABELA CLIENTES *****/
CREATE TABLE cliente (
    id_cliente INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    sobrenome VARCHAR(100) NOT NULL,
    telefone VARCHAR(15) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE
);


CREATE TABLE cardapio (
    id_cardapio INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    descricao TEXT NOT NULL,
    preco DECIMAL(10, 2) NOT NULL,
    categoria VARCHAR(50) NOT NULL
);

CREATE TABLE pedido (
    id_pedido INT AUTO_INCREMENT PRIMARY KEY,
    data_hora DATETIME NOT NULL,
    Status ENUM('em preparo', 'pronto para entrega', 'entregue') NOT NULL,
    id_cliente INT,
    FOREIGN KEY (id_cliente) REFERENCES cliente(id_cliente)
);

CREATE TABLE item_pedido (
    id_item_pedido INT AUTO_INCREMENT PRIMARY KEY,
    id_pedido INT,
    id_item INT,
    quantidade INT NOT NULL,
    FOREIGN KEY (id_pedido) REFERENCES pedido(id_pedido),
    FOREIGN KEY (id_item) REFERENCES cardapio(id_cardapio) 
);
CREATE TABLE reserva (
    id_reserva INT AUTO_INCREMENT PRIMARY KEY,
    data_hora DATETIME NOT NULL,
    numero_pessoas INT NOT NULL,
    Status ENUM('confirmada', 'pendente', 'cancelada') NOT NULL,
    id_cliente INT,
    FOREIGN KEY (id_cliente) REFERENCES cliente(id_cliente)
);

/***** INSERIR CLIENTES *****/
INSERT INTO cliente (nome, sobrenome, telefone, email) VALUES
('Lucas', 'Silva', '123456789', 'lucas.silva@email.com'),
('Ana', 'Oliveira', '987654321', 'ana.oliveira@email.com'),
('Carlos', 'Pereira', '555123456', 'carlos.pereira@email.com');

/***** INSERIR CARDÁPIO *****/
INSERT INTO cardapio (nome, descricao, preco, categoria) VALUES
('Hambúrguer', 'Delicioso hambúrguer de carne com queijo e molho especial', 25.00, 'Prato Principal'),
('Cachorro Quente', 'Salsicha suculenta em um pão macio', 10.00, 'Lanche'),
('Salada Caesar', 'Salada fresca com molho Caesar e croutons', 15.00, 'Salada');

/***** INSERIR PEDIDOS *****/
INSERT INTO pedido (data_hora, Status, id_cliente) VALUES
(NOW(), 'em preparo', 1),
(NOW(), 'pronto para entrega', 2),
(NOW(), 'entregue', 3);

/***** INSERIR ITENS DO PEDIDO *****/
INSERT INTO item_pedido (id_pedido, id_item, quantidade) VALUES
(1, 1, 2),  -- 2 Hambúrgueres no pedido 1
(1, 2, 1),  -- 1 Cachorro Quente no pedido 1
(2, 3, 1);  -- 1 Salada Caesar no pedido 2

/***** INSERIR RESERVAS *****/
INSERT INTO reserva (data_hora, numero_pessoas, Status, id_cliente) VALUES
('2024-10-20 19:00:00', 4, 'confirmada', 1),
('2024-10-21 20:00:00', 2, 'pendente', 2),
('2024-10-22 18:00:00', 5, 'cancelada', 3);

/***** EXIBIR CLIENTES *****/
SELECT * FROM cliente;

/***** EXIBIR CARDAPIO *****/
SELECT * FROM cardapio;

/***** EXIBIR PEDIDO COM DADOS DO CLIENTE *****/
SELECT 
    p.id_pedido,
    p.data_hora,
    p.Status,
    c.nome AS nome_cliente,
    c.sobrenome AS sobrenome_cliente
FROM 
    pedido p
JOIN 
    cliente c ON p.id_cliente = c.id_cliente;


/***** EXIBIR ITENS DO PEDIDO COM DADOS DO PEDIDO E CARDAPIO *****/
SELECT 
    ip.id_item_pedido,
    p.id_pedido,
    c.nome AS nome_item,
    ip.quantidade
FROM 
    item_pedido ip
JOIN 
    pedido p ON ip.id_pedido = p.id_pedido
JOIN 
    cardapio c ON ip.id_item = c.id_cardapio;


/***** EXIBIR RESERVA COM DADOS DO CLIENTE *****/
SELECT 
    r.id_reserva,
    r.data_hora,
    r.numero_pessoas,
    r.Status,
    c.nome AS nome_cliente,
    c.sobrenome AS sobrenome_cliente
FROM 
    reserva r
JOIN 
    cliente c ON r.id_cliente = c.id_cliente;

