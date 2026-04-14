# andmebaasidLOGITpe24
Andmebaasidega seotud sql kood ja konspektid

- SQL - structured query langauge
- DDL - Data Definition langauge - create, alter
- DML - Data manipulation langauge - insert, update, delete

## SISUKORD
- tunnis me kasutame andmebaasihaldussüsteemid:
- 

## tunnis me kasutame andmebaasihaldussüsteemid:
1. SQL Server Managment Stuudio (SQL Serveri haldamiseks)
 <img width="471" height="508" alt="{242019DC-0ECC-4CFD-B9FC-9F44665B022E}" src="https://github.com/user-attachments/assets/205152dc-dd05-49be-87ee-973edfe79093" />

3. XAMPP -phpmyAdmin (mariaDB andmebaas) -vabavara

 ##              Põhimõisted


- Andmebaas - struktueeritud andmete kogum
- Tabel - olem (enetity)
- veerg - väli (field)
- rida  kirje (record)
- primaarne võti -PK, Primary key - veerg (tavaliselt nimega id) unikaalse identifikaatoriga , mis eristab iga kirjet
- välisvõti (võõrvõti) -FK ,Forgen key - veerg, mis loob seose teise tabeli primaarvõtmega


## Andmetüübid
INT
SMALLINT
DECIMAL (6,2)
FLOAT
CHAR (6)
VARCHAR(50)
TEXT
DATE 
TIME
DATETIME
BOOLEAN

## Piirangud
1.  primary key
2.  foreign key
3.  unique
4.  not null
5.  check


## tabelivahelised seosed
- üks - ühele (nt mees --naine)
- üks - mitmele (õpilane käib erinvates õppeainetes)
   <img width="310" height="196" alt="{CC87DBFA-31A5-424B-AAE3-4792ABC6FB48}" src="https://github.com/user-attachments/assets/356d9df0-d9de-4a16-b351-121654863442" />
   - mitu - mitmele (nt suhted õpilasted vahel)
