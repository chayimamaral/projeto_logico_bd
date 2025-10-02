insert into Clients (Fname, Minit, Lname, CPF, Adress)
	 VALUES ('Maria', 'M', 'Silva', 123456789, 'Rua Silva de Prata 29, Carangola - Cidade das flores'),
			('Matheus', 'O', 'Pimentel', 987654321), 'Rua Alameda, 289, Centro - Cidade das Flores'),
			('Ricardo', 'F', 'Silva', 456789123, 'Avenida Alameda Vinha 1009, Centro - Cidade das Flores'),
			('Julia', 'S', 'França', 789123456, 'Rua lareijras 862, Centro - Cidade das Flores'),
			('Roberta', 'G', 'Assis', 987456312, 'Avenida Koller 19, Centro - Cidade das Flores'),
			('Isabela', 'M', 'Cruz', 654789123, 'rua Alameda das Flores, 28, Centro - Cidade das Flores');


			
INSERT INTO  product (Pname, classification_kids, category, avaliacao, size) 
     VALUES ('Fone de ouvido', FALSE, 'Eletrônico', '4', null),
            ('Barbie Elsa', true, 'Brinquedos', '3', null),
            ('Body Carters', true, 'Vestimenta', '5', null),
            ('Microfone Vedo - Youtube', FALSE, 'Eletrônico', '4', null),
            ('Sofá retrátil', FALSE, 'Móveis', '3', '3x57x80'),
            ('Farinha de arroz', FALSE, 'Alimentos', '2', null),
            ('FireStick Amazon', FALSE, 'Eletrônico', '3', null);


INSERT INTO  orders (idOrderClient, orderStatus, orderDescription, sendValue, PaymentCash) 
     VALUES (1, default, 'compra via aplicativo', null, 1),
            (2, default, 'compra via aplicativo', 50, 0),
            (3, 'Confirmado', null, null, 1),
            (4, default, 'compra via web site', 150, 0);

INSERT INTO  productOrder (idPOproduct, idPOorder, poQuantity, poStatus) 
     VALUES (1, 5, 2, null),
            (2, 5, 1, null),
            (3, 6, 1, null);

INSERT INTO  productStorage (storageLocation, quantity) 
     VALUES ('Rio de Janeiro', 1000),
            ('Rio de Janeiro', 500),
            ('São Paulo', 10),
            ('São Paulo', 100),
            ('São Paulo', 10),
            ('Brasília', 60);

INSERT INTO  storageLocagion (idLproduct, idLstorage, location) 
     VALUES (1, 2, 'RJ'),
            (2, 6, 'GO');

     
INSERT INTO  supplier (SocialName, CNPJ, contact) 
     VALUES ('Almeida e Filhos', 123456789123456, '21985474'),
            ('Eletrônicos Silva', 85456156756210, '21985484'),
            ('Eletrônicos Valma', 45642573531566, '21975474');

INSERT INTO  productSupplier (idPsSupplier, idPsProduct, quantity) 
     VALUES (1, 1, 500),
            (1, 2, 400),
            (2, 4, 633),
            (3, 3, 5),
            (2, 5, 10);

INSERT INTO  seller (SocialName, AbstName, CNPJ, CPF, location, contact) 
     VALUES ('Tech eletronics', NULL, 12345678912345, null, 'Rio de Janeiro', 12345678912),
			('Botique Durgas', NULL, null, 98765432132124, 'Rio de Janeiro', 12345678581),
			('Kids World', NULL, 54687321954678, null, 'São Paulo', 65435678581);


INSERT INTO productSeller (idPseller, idPproduct, prodQuantity)
	 VALUES (1, 6, 80),
	        (2, 7, 10);




     
		