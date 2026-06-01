## FOREIGNKEY

[Select laused](select.md) | [ForeginKeys](foreignkey.md) | [Alter_Table](alter_table.md) | [Triggerid](triggerkonspekt.md) | [Kodutöö - Keys](keys.md)

SQL kood mis on tunnis tehtud

<img width="567" height="607" alt="{8FE68076-E4CD-4229-B6EE-6CF34C4B2561}" src="https://github.com/user-attachments/assets/561a9cee-dd08-4429-82b1-024480374b9e" />

<img width="566" height="539" alt="{6E8C0CB7-D815-4A97-BD0D-0C456D628B98}" src="https://github.com/user-attachments/assets/a85cfe9d-14a0-4f7c-8c25-772a79949485" />

<img width="904" height="672" alt="{35B3C4BE-66E4-463D-9459-76768A4F82F4}" src="https://github.com/user-attachments/assets/610a9237-a072-43fb-a48b-df39d2bc927c" />

```
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
keskminehinne decimal(2,1))```

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
```
