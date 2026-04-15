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
