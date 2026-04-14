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
