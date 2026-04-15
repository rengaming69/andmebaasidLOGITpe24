--uue veeru lisamine
alter table opilane2 add telefon varchar(1);

--tabli struktuuri muutmine -veeru kustutamine
alter table opilane2 drop column telefon 

--tabeli muutmine -veeru andmetüübi vahetamine
alter table opilane2 alter column  telefon varchar(13);
--store procedure help mis näitab tabeli struktuuri ja veerude andmetüübid
sp_help opilane2

create table ryhm(
ryhmID int not null,
ryhmNimi varchar (10))
select * from ryhm;
--muudame tabeli ryhm ja lisame Primary key
alter table ryhm add primary key (ryhmID);
--muudame tabeli ryhm ja lisamine primary key
alter table ryhm add constraint pk_ryhm Primary key (ryhmID);

--muudame tabeli ryhm ja teeme ryhmnimi unikaalseks unique
alter table ryhm add constraint un_ryhm unique (ryhmNimi);

sp_help ryhm

--taidame tabeli rühm
insert into ryhm(ryhmID, ryhmNimi)
values (1, 'logitpe24'),(2, 'titpe24');
select * from ryhm

--foreign key --opilane tabelis
--lisame opilane tabelisse uus veerg
alter table opilane add ryhmID int;
select * from opilane
--lisame ryhmID foreign key
alter table opilane add constraint fk_ryhm
foreign key (ryhmID) references ryhm(ryhmID) --link tabel (pk veerg)
-- Tabel: Category (Liik)
CREATE TABLE Category (
    idCategory INT PRIMARY KEY,
    CategoryName VARCHAR(100) NOT NULL UNIQUE
);

-- Tabel: Product (Kaup)
CREATE TABLE Product (
    idProduct INT PRIMARY KEY,
    ProductName VARCHAR(100) NOT NULL,
    idCategory INT,
    Price DECIMAL(10, 2) CHECK (Price >= 0),
    CONSTRAINT FK_Product_Category FOREIGN KEY (idCategory) 
        REFERENCES Category(idCategory)
);

-- Tabel: Customer (Ostja) - Lisatud vastavalt tekstile pildi all
CREATE TABLE Customer (
    idCustomer INT PRIMARY KEY,
    Name VARCHAR(100) NOT NULL,
    Contact VARCHAR(255)
);

-- Tabel: Sale (Müük)
CREATE TABLE Sale (
    idSale INT PRIMARY KEY,
    idProduct INT NOT NULL,
    idCustomer INT NOT NULL,
    Count_pr INT DEFAULT 1 CHECK (Count_pr > 0),
    Date_of_sale DATE DEFAULT CURRENT_DATE,
    CONSTRAINT FK_Sale_Product FOREIGN KEY (idProduct) 
        REFERENCES Product(idProduct),
    CONSTRAINT FK_Sale_Customer FOREIGN KEY (idCustomer) 
        REFERENCES Customer(idCustomer)
);
-- Muudame toote nime välja pikkust 255 sümbolini
ALTER TABLE Product 
ALTER COLUMN ProductName VARCHAR(255);
-- Lisame mõõtühikute välja
ALTER TABLE Sale 
ADD Units VARCHAR(20);
-- Eemaldame nime unikaalsuse piirangu (eeldades, et nimi on teada)
-- NB! Piirangu nimi sõltub süsteemist, kui seda pole loomisel ise määratud
ALTER TABLE Category 
DROP CONSTRAINT CategoryName;
