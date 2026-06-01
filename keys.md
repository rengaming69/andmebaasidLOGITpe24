## KEYS 

[Select laused](select.md) | [ForeginKeys](foreignkey.md) | [Alter_Table](alter_table.md) | [Triggerid](triggerkonspekt.md) | [Kodutöö - Keys](keys.md)

1. Superkey (Supervõti):

Lühike definitsioon: Veerg või veergude kombinatsioon, mis võimaldab tabelis iga rida (kirjet) unikaalselt tuvastada.
Milleks kasutatakse: See on teoreetiline alus teiste võtmete (kandidaat- ja primaarvõtmete) leidmiseks andmebaasi projekteerimise faasis.
Mille poolest erineb teistest võtmetest: Supervõti võib sisaldada "liigseid" või täiendavaid veerge, mis ei ole unikaalsuse tagamiseks otseselt vajalikud (nt isikukood + eesnimi). Teised võtmed (nagu kandidaatvõti) on supervõtme minimaalsed alamhulgad.

SQL-lause näide
Andmebaasis ei märgita supervõtit eraldi märksõnaga, vaid see eksisteerib loogiliselt unikaalsuse kaudu. Luues tabeli Kliendid:

```SQL 

CREATE TABLE Kliendid (
    kliendi_id INT PRIMARY KEY,
    isikukood CHAR(11) UNIQUE,
    eesnimi VARCHAR(50),
    perenimi VARCHAR(50)
);
```

<img width="631" height="514" alt="{5BB005DB-FCAF-4EB6-834A-3BA489F66CBB}" src="https://github.com/user-attachments/assets/d773c050-dbf0-4220-ba2d-08215859e0ab" />


Ekraanipildi selgitus: 
Kombinatsioon kliendi_id (1) + eesnimi (Jaan) on unikaalne supervõti, kuigi "Jaan" üksi seda poleks.


2. Candidate Key (Kandidaatvõti)

Lühike definitsioon: Minimaalne supervõti ehk vähim võimalik veergude hulk, mis suudab rida unikaalselt tuvastada, ilma et sealt saaks ühtegi veergu eemaldada.
Milleks kasutatakse: Disainifaasis potentsiaalsete primaarvõtmete valimiseks.
Mille poolest erineb teistest võtmetest: Erinevalt supervõtmest ei tohi kandidaatvõtmes olla ühtegi üleliigset veergu. Tabelis võib olla mitu kandidaatvõtit, kuid primaarvõtmeks valitakse neist lõpuks ainult üks.

```SQL
CREATE TABLE Autod (
    auto_id INT NOT NULL,          -- Kandidaatvõti 1
    reg_number VARCHAR(10) NOT NULL, -- Kandidaatvõti 2
    vin_kood VARCHAR(17) NOT NULL,   -- Kandidaatvõti 3
    mudel VARCHAR(50),
    CONSTRAINT UQ_reg UNIQUE (reg_number),
    CONSTRAINT UQ_vin UNIQUE (vin_kood)
);
```

<img width="610" height="474" alt="{9388C7FC-D06B-4161-89D8-543358BCE049}" src="https://github.com/user-attachments/assets/dd4188fc-111d-406d-a177-e6f064a77ee5" />



Primary Key (Primaarvõti)
Lühike definitsioon: Andmebaasi arhitekti poolt valitud kandidaatvõti, mis on tabeli peamiseks ja ametlikuks kirjete tuvastajaks.
Milleks kasutatakse: Kirjete kiireks otsimiseks, ridade unikaalsuse tagamiseks ja tabelitevaheliste seoste loomiseks.
Mille poolest erineb teistest võtmetest: Tabelis saab olla ainult üks primaarvõti. Erinevalt teistest võtmetest (nt Unique Key) ei tohi see kunagi sisaldada NULL väärtusi.

```SQL
CREATE TABLE Tooted (
    toode_id INT NOT NULL,
    toote_nimi VARCHAR(100),
    hind DECIMAL(10,2),
    CONSTRAINT PK_Tooted PRIMARY KEY (toode_id)
);
```

<img width="618" height="520" alt="{D083A85C-05B0-4D23-8A53-BB04298F5213}" src="https://github.com/user-attachments/assets/1a71edd8-29cd-4d2d-8d4a-8f2dcf5c1511" />



4. Alternate Key (Alternatiivvõti)
Lühike definitsioon: Kandidaatvõti, mida andmebaasi disainimisel ei valitud primaarvõtmeks.
Milleks kasutatakse: Andmete teisejärguliseks unikaalsuse kontrolliks (rakendades UNIQUE piirangut).
Mille poolest erineb teistest võtmetest: Funktsionaalselt tagab sama unikaalsuse mis primaarvõti, kuid see on n-ö "asendusliige". Erinevalt primaarvõtmest võib see (sõltuvalt reeglitest) lubada NULL väärtust.

```SQL
CREATE TABLE Kasutajad (
    kasutaja_id INT PRIMARY KEY,       -- Valitud Primaarvõtmeks
    kasutajanimi VARCHAR(50) UNIQUE,   -- Alternatiivvõti (Alternating Key)
    parool_hash VARCHAR(255)
);
```

<img width="781" height="499" alt="{78E3D57C-B8E8-4EDD-913B-7625D5939B4A}" src="https://github.com/user-attachments/assets/95d517f4-f1db-45ab-8c29-226b124942bc" />


5. Unique Key (Unikaalne võti / piirang)
Lühike definitsioon: Piirang, mis keelab veerus või veergude grupis duatsete (korduvate) väärtuste olemasolu.
Milleks kasutatakse: Ärireeglite tagamiseks väljadel, mis pole primaarvõtmed, kuid peavad olema unikaalsed (nt e-maili aadressid, telefoninumbrid).
Mille poolest erineb teistest võtmetest: Erinevalt primaarvõtmest võib unikaalne võti tavaliselt sisaldada NULL väärtust (enamikus SQL mootorites isegi mitut NULL väärtust). Ühes tabelis võib olla lõpmatu arv unikaalseid võtmeid.

```SQL
CREATE TABLE Töötajad (
    töötaja_id INT PRIMARY KEY,
    eesnimi VARCHAR(50),
    email VARCHAR(100),
    CONSTRAINT UQ_Töötaja_Email UNIQUE (email)
);
```

<img width="583" height="528" alt="{6D6A9C98-40E6-43AA-945D-CDF683084427}" src="https://github.com/user-attachments/assets/e1591c72-31c6-4ca4-b42d-0dd45f1136b9" />


ERROR: duplicate key value violates unique constraint "UQ_Töötaja_Email"
DETAIL: Key (email)=(mari@firma.ee) already exists.

6. Foreign Key (Välisvõti)
Lühike definitsioon: Veerg või veergude kogum ühes tabelis, mis viitab mõne teise (või sama) tabeli primaarvõtmele või unikaalsele võtmele.
Milleks kasutatakse: Tabelitevaheliste seoste loomiseks ja referentsiaalse terviklikkuse (andmete kooskõla) säilitamiseks.
Mille poolest erineb teistest võtmetest: See on ainus võti, mille eesmärk ei ole oma tabeli rea unikaalsuse tagamine. Välisvõtme väärtused võivad korduda ja sisaldada NULL-e.

```SQL
CREATE TABLE Tellimused (
    tellimus_id INT PRIMARY KEY,
    toode_id INT,                     -- Välisvõti
    kogus INT,
    CONSTRAINT FK_Tellimus_Toode FOREIGN KEY (toode_id) REFERENCES Tooted(toode_id)
);
```
<img width="720" height="529" alt="{0F431274-BBDC-4CCD-88BA-812B8D7AB30A}" src="https://github.com/user-attachments/assets/b19e2c03-7be1-4f49-8fe0-b53b33a4cd35" />


7. Simple Key (Lihtvõti)
Lühike definitsioon: Võti, mis koosneb täpselt ühest veerust.
Milleks kasutatakse: Kirjete lihtsaks, kiireks ja ressursisäästlikuks tuvastamiseks ning indekseerimiseks.
Mille poolest erineb teistest võtmetest: Erineb struktuurselt liitvõtmetest (Composite/Compound), kuna ei haara endaga kaasa mitut veergu.

```SQL
CREATE TABLE Riigid (
    riigi_kood CHAR(2) PRIMARY KEY, -- Simple Key (ainult üks veerg)
    riigi_nimi VARCHAR(100)
);
```
<img width="1162" height="610" alt="{9702E1BD-E36E-43F4-B00C-B739B0A5543B}" src="https://github.com/user-attachments/assets/0e3d266c-3eb2-4faf-90aa-68896cc0c921" />



8. Composite Key (Liitvõti)
Lühike definitsioon: Võti (tavaliselt primaarvõti), mis koosneb kahest või enamast veerust, et tagada rea unikaalsus.
Milleks kasutatakse: Olukorras, kus ükski veerg eraldiseisvalt ei suuda tagada unikaalsust, kuid nende kombinatsioon suudab.
Mille poolest erineb teistest võtmetest: Erineb lihtvõtmest veergude arvu poolest. Erineb Compound Key-st selle poolest, et liitvõtme osad võivad olla lihtsalt tavalised andmeveerud, mitte tingimata välisvõtmed.

```SQL
CREATE TABLE Broneeringud (
    rea_number INT NOT NULL,
    istekoha_number INT NOT NULL,
    kliendi_nimi VARCHAR(100),
    CONSTRAINT PK_Broneering PRIMARY KEY (rea_number, istekoha_number) -- Composite Key
);
```

<img width="1139" height="515" alt="{EF37451E-87F6-430E-8A27-1B7678B6A79A}" src="https://github.com/user-attachments/assets/4df8c0b4-d002-40e0-b291-6d754b2f1921" />


9. Compound Key (Kombineeritud liitvõti)
Lühike definitsioon: Liitvõtme eriliik, kus vähemalt üks (või kõik) võtme koostises olevatest veergudest on ühtlasi ka teise tabeli välisvõti (Foreign Key).
Milleks kasutatakse: Mitut-mitmele (Many-to-Many) seosetabelite unikaalsuse ja seoste üheaegseks tagamiseks.
Mille poolest erineb teistest võtmetest: Kui tavalise Composite Key osad võivad olla suvalised väljad (nt rida ja koht), siis Compound Key elemendid on kohustuslikult seotud teiste tabelite primaarvõtmetega.

```SQL

CREATE TABLE Tudengid ( tudeng_id INT PRIMARY KEY, nimi VARCHAR(50) );
CREATE TABLE Kursused ( kursuse_id INT PRIMARY KEY, nimetus VARCHAR(50) );

-- Seosetabel Compound Key-ga
CREATE TABLE Õpib_Kursusel (
    tudeng_id INT,
    kursuse_id INT,
    Hinne CHAR(1),
    CONSTRAINT FK_Tudeng FOREIGN KEY (tudeng_id) REFERENCES Tudengid(tudeng_id),
    CONSTRAINT FK_Kursus FOREIGN KEY (kursuse_id) REFERENCES Kursused(kursuse_id),
    CONSTRAINT PK_Õpib PRIMARY KEY (tudeng_id, kursuse_id) -- Compound Key
);
```
<img width="1058" height="501" alt="{FE1608B5-F4C0-425A-BFF8-E31AB6A4FE84}" src="https://github.com/user-attachments/assets/b9c88b68-cdc1-47cd-912b-434bb6cd043f" />

Kasutatud allikate loetelu
Date, C. J. (2004). An Introduction to Database Systems (8th Edition). Pearson Addison Wesley. (Teoreetiline ülevaade super- ja kandidaatvõtmete kohta).

W3Schools SQL Tutorial. Database Keys. Saadaval: https://www.w3schools.com/sql/

GeeksforGeeks. Types of Keys in Relational Database Management System (RDBMS). Saadaval: https://www.geeksforgeeks.org/types-of-keys-in-relational-database-management-system-rdbms/

Oracle SQL Documentation. Integrity Constraints. Saadaval: https://docs.oracle.com/
