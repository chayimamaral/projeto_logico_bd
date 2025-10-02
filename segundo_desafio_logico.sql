--1. Mapeamento ER → Relacional
--Principais Entidades e Relacionamentos:

--Cliente (clients)

--Produto (product)

--Fornecedor (supplier) fornece produtos (N:N → productSupplier)

--Vendedor (seller) vende produtos (N:N → productSeller)

--Pedido (orders) pertence a um cliente

--Pedido (orders) contém produtos (N:N → productOrder)

--Estoque (productStorage) guarda produtos (N:N → storageLocation)

--Pagamentos (payments) são vinculados a clientes

--2. Script SQL Corrigido e Melhorado

-- criação do banco
CREATE DATABASE ecommerce;
USE ecommerce;

-- tabela clientes
CREATE TABLE clients(
    idClient INT AUTO_INCREMENT PRIMARY KEY,
    Fname VARCHAR(30),
    Minit CHAR(3),
    Lname VARCHAR(30),
    CPF CHAR(11) NOT NULL,
    Address VARCHAR(100),
    CONSTRAINT unique_cpf_client UNIQUE (CPF)
);

-- tabela produtos
CREATE TABLE product(
    idProduct INT AUTO_INCREMENT PRIMARY KEY,
    Pname VARCHAR(50) NOT NULL,
    classification_kids BOOLEAN DEFAULT FALSE,
    category ENUM('Eletrônico', 'Vestimenta', 'Brinquedos', 'Alimentos', 'Móveis') NOT NULL,
    avaliacao FLOAT DEFAULT 0,
    size VARCHAR(20)
);

-- tabela pagamentos
CREATE TABLE payments(
    idClient INT,
    idPayment INT AUTO_INCREMENT,
    typePayment ENUM ('Boleto', 'Cartão', 'Dois cartões'),
    limitAvailable FLOAT,
    PRIMARY KEY(idClient, idPayment),
    CONSTRAINT fk_payment_client FOREIGN KEY (idClient) REFERENCES clients(idClient)
);

-- tabela pedidos
CREATE TABLE orders(
    idOrder INT AUTO_INCREMENT PRIMARY KEY,
    idOrderClient INT,
    orderStatus ENUM('Cancelado', 'Confirmado', 'Em processamento') DEFAULT 'Em processamento',
    orderDescription VARCHAR(255),
    sendValue FLOAT DEFAULT 10,
    paymentCash BOOLEAN DEFAULT FALSE,
    CONSTRAINT fk_orders_client FOREIGN KEY (idOrderClient) REFERENCES clients(idClient)
);

-- tabela estoque
CREATE TABLE productStorage(
    idProdStorage INT AUTO_INCREMENT PRIMARY KEY,
    storageLocation VARCHAR(255),
    quantity INT DEFAULT 0
);

-- tabela fornecedor
CREATE TABLE supplier(
    idSupplier INT AUTO_INCREMENT PRIMARY KEY,
    SocialName VARCHAR(255) NOT NULL,
    CNPJ CHAR(14) NOT NULL,
    contact CHAR(11) NOT NULL,
    CONSTRAINT unique_supplier UNIQUE (CNPJ)
);

-- tabela vendedor
CREATE TABLE seller(
    idSeller INT AUTO_INCREMENT PRIMARY KEY,
    SocialName VARCHAR(255) NOT NULL,
    AbstName VARCHAR(255),
    CNPJ CHAR(14),
    CPF CHAR(11),
    location VARCHAR(255),
    contact CHAR(11) NOT NULL,
    CONSTRAINT unique_cnpj_seller UNIQUE (CNPJ),
    CONSTRAINT unique_cpf_seller UNIQUE (CPF)
);

-- produtos vendidos por vendedores (N:N)
CREATE TABLE productSeller(
    idSeller INT,
    idProduct INT,
    prodQuantity INT DEFAULT 1,
    PRIMARY KEY (idSeller, idProduct),
    CONSTRAINT fk_product_seller FOREIGN KEY (idSeller) REFERENCES seller(idSeller),
    CONSTRAINT fk_product_product FOREIGN KEY (idProduct) REFERENCES product(idProduct)
);

-- produtos dentro de pedidos (N:N)
CREATE TABLE productOrder(
    idProduct INT,
    idOrder INT,
    poQuantity INT DEFAULT 1,
    poStatus ENUM('Disponível', 'Sem estoque') DEFAULT 'Disponível',
    PRIMARY KEY (idProduct, idOrder),
    CONSTRAINT fk_productorder_product FOREIGN KEY (idProduct) REFERENCES product(idProduct),
    CONSTRAINT fk_productorder_order FOREIGN KEY (idOrder) REFERENCES orders(idOrder)
);

-- produtos em estoque (N:N)
CREATE TABLE storageLocation(
    idProduct INT,
    idStorage INT,
    location VARCHAR(255) NOT NULL,
    PRIMARY KEY (idProduct, idStorage),
    CONSTRAINT fk_storage_product FOREIGN KEY (idProduct) REFERENCES product(idProduct),
    CONSTRAINT fk_storage_storage FOREIGN KEY (idStorage) REFERENCES productStorage(idProdStorage)
);

-- produtos fornecidos (N:N)
CREATE TABLE productSupplier(
    idSupplier INT,
    idProduct INT,
    quantity INT NOT NULL,
    PRIMARY KEY (idSupplier, idProduct),
    CONSTRAINT fk_product_supplier_supplier FOREIGN KEY (idSupplier) REFERENCES supplier(idSupplier),
    CONSTRAINT fk_product_supplier_product FOREIGN KEY (idProduct) REFERENCES product(idProduct)
);

--3. Persistência de Dados (inserts para teste)

INSERT INTO clients (Fname, Minit, Lname, CPF, Address) 
VALUES ('Carlos', 'A', 'Amaral', '12345678901', 'Rua A, 100'),
       ('Maria', 'B', 'Silva', '98765432100', 'Rua B, 200');

INSERT INTO product (Pname, classification_kids, category, avaliacao, size) 
VALUES ('Notebook', false, 'Eletrônico', 4.5, '15pol'),
       ('Camiseta', true, 'Vestimenta', 4.0, 'M');

INSERT INTO orders (idOrderClient, orderStatus, orderDescription, sendValue, paymentCash) 
VALUES (1, 'Confirmado', 'Compra online', 20, true);

INSERT INTO productOrder (idProduct, idOrder, poQuantity) 
VALUES (1, 1, 2), (2, 1, 3);

INSERT INTO supplier (SocialName, CNPJ, contact) 
VALUES ('Fornecedor A', '11222333444455', '48999998888');

INSERT INTO productSupplier (idSupplier, idProduct, quantity) 
VALUES (1, 1, 50);

INSERT INTO seller (SocialName, AbstName, CNPJ, CPF, location, contact) 
VALUES ('Vendedor X', 'VendX', '99887766554433', NULL, 'Florianópolis', '48988887777');

--4. Recuperação de Informações (Queries de exemplo)
--Perguntas possíveis:

--1. Quais clientes fizeram pedidos confirmados?
SELECT c.Fname, c.Lname, o.idOrder, o.orderStatus
FROM clients c
JOIN orders o ON c.idClient = o.idOrderClient
WHERE o.orderStatus = 'Confirmado';

--2. Quais produtos foram comprados em determinado pedido?

SELECT o.idOrder, p.Pname, po.poQuantity
FROM orders o
JOIN productOrder po ON o.idOrder = po.idOrder
JOIN product p ON po.idProduct = p.idProduct
WHERE o.idOrder = 1;

--3. Quais fornecedores fornecem determinado produto?

SELECT p.Pname, s.SocialName, ps.quantity
FROM product p
JOIN productSupplier ps ON p.idProduct = ps.idProduct
JOIN supplier s ON ps.idSupplier = s.idSupplier;

--4. Qual vendedor vende determinado produto?

SELECT p.Pname, s.SocialName
FROM product p
JOIN productSeller ps ON p.idProduct = ps.idProduct
JOIN seller s ON ps.idSeller = s.idSeller;

--5. Valor médio de envio dos pedidos:

SELECT AVG(sendValue) AS media_envio FROM orders;

