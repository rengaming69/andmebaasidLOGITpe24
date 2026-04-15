create database Reno;
use Reno
--tableli loomine
create table opilane(
opilane int Primary key identity(1,1),
eesnimi varchar(25),
perekonnanimi varchar(30) not null,
synniaeg date, 
pohitoetus bit,
aadress text,
keskminehinne decimal(2,1))

select * from opilane;

--andmete lisamine tabelisse
insert into opilane(perekonnanimi, eesnimi,synniaeg)
values( 'punane', 'sall', '2000-10-23'),
('roheline', 'pall', '2000-10-25')

--uuendame tabeliandmeid
update opilane set aadress='tallinn, eesti'
update opilane set pohitoetus=1 --1= true
update opilane set keskminehinne=4

insert into opilane
values ('nimi', 'perenimi', '2003-10-25', 0, 'tartu, eesti', 3.5)



create database Reno;
use Reno
--tableli loomine
create table opilane(
opilane int Primary key identity(1,1),
eesnimi varchar(25),
perekonnanimi varchar(30) not null,
synniaeg date, 
pohitoetus bit,
aadress text,
keskminehinne decimal(2,1))

select * from opilane;

--andmete lisamine tabelisse
insert into opilane(perekonnanimi, eesnimi,synniaeg)
values( 'punane', 'sall', '2000-10-23'),
('roheline', 'pall', '2000-10-25')

--uuendame tabeliandmeid
update opilane set aadress='tallinn, eesti'
update opilane set pohitoetus=1 --1= true
update opilane set keskminehinne=4

insert into opilane
values ('nimi', 'perenimi', '2003-10-25', 0, 'tartu, eesti', 3.5)

--teine table
create table opilanetunnis(
opilanetunnisId int Primary key identity(1,1),
kuupaev date not null,
opilaneId int,
foreign key (opilaneId) References opilane(opilanetunnisId)
oppeaine varchar(25)
hinne int))
select * from opilane;
select * from opilanetunnis;

--lisame andmeid opilanetunnis tabelisse
insert into opilanetunnis
values ('2025-04-14', 1, 'andmebaasid', 5);


--testtabel
create table testtabel(
id int primary key);
--tabeli kustutamine
drop table testtabel
drop database Lomonosov


--tabelirida kustutamine
select * from opilane
delete from opilane where opilaneId=4;

create table opetaja(
opetajaID int Primary key identity (1, 1),
eesnimi varchar (30)
ruum int not null,)
insert into 




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
