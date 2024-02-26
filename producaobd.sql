create database producaobd
go

use producaobd
go

--Tabela Fabricante
create table Fabricante(
codfabricante smallint primary key identity(1,1),
nomefabricante varchar(30) not null
);

--Tabela Produto
create table Produto(
codproduto int primary key identity(10,1),
nomeproduto varchar(30) not null,
codfabricante smallint,
foreign key(codfabricante) references Fabricante(codfabricante)
);

--Tabela Lote
create table Lote(
numlote int primary key,
datavalidade date not null,
precounitario decimal(5,2) not null,
quantidade smallint,
valorlote decimal(10,2),
codproduto int,
foreign key(codproduto) references Produto(codproduto)
);

truncate table Lote;

-- Inserindo registros na tabela FABRICANTE
insert into Fabricante (nomefabricante) values
('Clear'),
('Rexona'),
('Jhonson & Jhonson'),
('Coleston');

-- Inserindo registros na tabela PRODUTO
insert into Produto (nomeproduto, codfabricante) values
('Sabonete em Barra', '2'),
('Shampoo Anticaspa', '1'),
('Desodorante Aerosol Neutro', '2'),
('Sabonete Liquido', '2'),
('Protetor Solar 30', '3'),
('Shampoo 2 em 1', '2'),
('Desosorante Aerosol Morango', '2'),
('Shampoo Anticaspa', '2'),
('Protetor Solar 60', '3'),
('Desodorante Rollon', '1');

-- Inserindo registros na tabela LOTE.
INSERT INTO Lote (numlote, datavalidade, precounitario, quantidade, valorlote, codproduto) VALUES (100, '05-08-2028', 9.90, 500, DEFAULT, 18);
INSERT INTO Lote (numlote, datavalidade, precounitario, quantidade, valorlote, codproduto) VALUES (101, '01-05-2027', 8.47, 100, DEFAULT,10);
INSERT INTO Lote (numlote, datavalidade, precounitario, quantidade, valorlote, codproduto) VALUES (102, '02-06-2028', 11.50, 750, DEFAULT, 19); 
INSERT INTO Lote (numlote, datavalidade, precounitario, quantidade, valorlote, codproduto) VALUES (103, '01-02-2026', 12.37, 383, DEFAULT, 18); 
INSERT INTO Lote (numlote, datavalidade, precounitario, quantidade, valorlote, codproduto) VALUES (104, '01-01-2027', 10.00, 400, DEFAULT, 17); 
INSERT INTO Lote (numlote, datavalidade, precounitario, quantidade, valorlote, codproduto) VALUES (105, '07-04-2026', 11.50, 100, DEFAULT, 15); 
INSERT INTO Lote (numlote, datavalidade, precounitario, quantidade, valorlote, codproduto) VALUES (106, '08-06-2023', 10.30, 320, DEFAULT, 17); 
INSERT INTO Lote (numlote, datavalidade, precounitario, quantidade, valorlote, codproduto) VALUES (107, '20-10-2024', 13.90, 456, DEFAULT, 12); 
INSERT INTO Lote (numlote, datavalidade, precounitario, quantidade, valorlote, codproduto) VALUES (108, '20-07-2026', 7.53, 750, DEFAULT, 13); 
INSERT INTO Lote (numlote, datavalidade, precounitario, quantidade, valorlote, codproduto) VALUES (109, '13-05-2025', 8.00, 720, DEFAULT, 11); 
INSERT INTO Lote (numlote, datavalidade, precounitario, quantidade, valorlote, codproduto) VALUES (110, '05-06-2027', 9.50, 860, DEFAULT, 13); 
INSERT INTO Lote (numlote, datavalidade, precounitario, quantidade, valorlote, codproduto) VALUES (111, '02-03-2028', 14.50, 990, DEFAULT, 14); 
INSERT INTO Lote (numlote, datavalidade, precounitario, quantidade, valorlote, codproduto) VALUES (112, '05-04-2028', 11.40, 430, DEFAULT, 14); 
INSERT INTO Lote (numlote, datavalidade, precounitario, quantidade, valorlote, codproduto) VALUES (113, '04-06-2025', 11.30, 200, DEFAULT, 12); 
INSERT INTO Lote (numlote, datavalidade, precounitario, quantidade, valorlote, codproduto) VALUES (114, '06-10-2027', 12.76, 380, DEFAULT, 19); 
INSERT INTO Lote (numlote, datavalidade, precounitario, quantidade, valorlote, codproduto) VALUES (115, '06-11-2028', 8.30, 420, DEFAULT, 17); 
INSERT INTO Lote (numlote, datavalidade, precounitario, quantidade, valorlote, codproduto) VALUES (116, '20-10-2027', 8.99, 361, DEFAULT, 19); 
INSERT INTO Lote (numlote, datavalidade, precounitario, quantidade, valorlote, codproduto) VALUES (117, '15-11-2024', 10.09, 713, DEFAULT, 11);

update Lote 
set valorlote = quantidade * precounitario
where numlote >= 100;

select * from Lote;

-- Quais os lotes com data de validade para o ano de 2024.
select numlote, codproduto from Lote where year(datavalidade) = 2024;

-- Quantos lotes possuem data de validade para o ano de 2025
select numlote, codproduto from Lote where year(datavalidade) = 2025;

-- Quantos lotes existem para cada produto.
select codproduto, count(numlote) from Lote group by codproduto;

--ou

select p.nomeproduto as NomeProduto,
count(l.codproduto) as numLotes from Lote l 
join Produto p on p.codproduto = l.codproduto
group by p.nomeproduto;

-- Qual o valor total de lotes de um determinado produto.
select p.nomeproduto as NomeProduto,
sum(l.valorlote) as valorTotalLotes from Lote l 
join Produto p on p.codproduto = l.codproduto
group by p.nomeproduto;

-- Criar lista ordenada de lotes por data de validade.
select numlote, datavalidade, codproduto from Lote order by datavalidade asc;

-- Selecionar lotes com validade entre fevereiro de 2024 e junho de 2026.
select numlote, datavalidade, codproduto from Lote 
where month(datavalidade) between 02 and 06;

-- Listar os lotes com valor de lote acima da média entre todos os valores de lote do banco.
select numlote, valorlote from Lote
where valorlote > (select avg(valorlote) from Lote);

--Um pequeno mercado comprou um lote fechado do Sabonete de Glicerina do fabricante Ancora. A validade 
--desses sabonetes está para 28/12/29. Cada unidade desse sabonete custou R $3,78 para nossa empresa.
--Foi encomendado um lote com 1.223 unidades. Registre essas informações no banco de dados.
insert into Fabricante (nomefabricante) values ('Ancora');

insert into Produto (nomeproduto, codfabricante) values ('Sabonete de Glicerina','5');

insert into Lote (numlote, datavalidade, precounitario, quantidade, valorlote, codproduto) VALUES
(118, '28-12-2029', 3.78, 1223, default, 20);

--Alterar o preço do Sabonete de Glicerina com uma redução de 15% no preço cadastrado. 
update Lote
set precounitario = precounitario - (precounitario * 0.15)
where codproduto = 20;

-- Excluir o Shampoo Anticaspa da Rexona.
delete from Lote
where codproduto = 17;

delete from Produto
where codproduto = 17;

-- Altere a tabela lote de forma que o armazenamento do preço unitário do produto seja feito usando
--apenas duas casas decimais.
                                   --Já está no formato.

-- Altere a tabela lote inserindo uma coluna chamada STATUSLOTE. Essa coluna pode armazenar valores
--como “Recall”, “Liberado”. Como padrão, esse campo recebe valor de “Analise”. A coluna deve ser
--varchar e receber no máximo 9 caracteres.
alter table Lote add statuslote varchar(9) default 'Analise';


-- Alterar o status dos lotes de acordo com a tabela abaixo:
update Lote
set statuslote = 'Recall'
where numlote = 107 or numlote = 108 or numlote = 116;

update Lote
set statuslote = 'Liberado'
where numlote = 113 or numlote = 117 or numlote = 112 or numlote = 109 or numlote = 114;

update Lote
set statuslote = 'Analise'
where statuslote is null;

-- Criar uma lista com a quantidade de lotes que estão classificados com cada um dos status existentes.
select statuslote, count(numlote) from Lote group by statuslote;

-- Apresentar uma lista com as quantidades de produtos fornecidas por cada fabricante.
select f.nomefabricante as NomeFabricante,
count(p.codfabricante) as fabricanteProduto from Produto p 
join Fabricante f on f.codfabricante = p.codfabricante
group by f.nomefabricante;
