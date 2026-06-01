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
);```

kliendi_id (PK),isikukood (UQ),eesnimi,perenimi
1,39501010011,Jaan,Tamm
2,49602020022,Mari,Maasikas

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
);```

Table: Autod
Indexes / Constraints:
  - auto_id (Määratlemata loogiline kandidaat, hiljem PK)
  - UQ_reg (UNIQUE Constraint veerul reg_number)
  - UQ_vin (UNIQUE Constraint veerul vin_kood)


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
);```

Query OK, 0 rows affected (0.04 sec)


4. Alternate Key (Alternatiivvõti)
Lühike definitsioon: Kandidaatvõti, mida andmebaasi disainimisel ei valitud primaarvõtmeks.
Milleks kasutatakse: Andmete teisejärguliseks unikaalsuse kontrolliks (rakendades UNIQUE piirangut).
Mille poolest erineb teistest võtmetest: Funktsionaalselt tagab sama unikaalsuse mis primaarvõti, kuid see on n-ö "asendusliige". Erinevalt primaarvõtmest võib see (sõltuvalt reeglitest) lubada NULL väärtust.

```SQL
CREATE TABLE Kasutajad (
    kasutaja_id INT PRIMARY KEY,       -- Valitud Primaarvõtmeks
    kasutajanimi VARCHAR(50) UNIQUE,   -- Alternatiivvõti (Alternating Key)
    parool_hash VARCHAR(255)
);```

kasutaja_id (PK),kasutajanimi (Alternate Key / UQ),parool_hash
1,küber_karu,8f39b1...
2,it_tigu,9a2c1b...


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
);```

INSERT INTO Töötajad VALUES (1, 'Mari', 'mari@firma.ee'); -> OK
INSERT INTO Töötajad VALUES (2, 'Jüri', 'mari@firma.ee'); -> ERROR

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
);```


7. Simple Key (Lihtvõti)
Lühike definitsioon: Võti, mis koosneb täpselt ühest veerust.
Milleks kasutatakse: Kirjete lihtsaks, kiireks ja ressursisäästlikuks tuvastamiseks ning indekseerimiseks.
Mille poolest erineb teistest võtmetest: Erineb struktuurselt liitvõtmetest (Composite/Compound), kuna ei haara endaga kaasa mitut veergu.

```SQL
CREATE TABLE Riigid (
    riigi_kood CHAR(2) PRIMARY KEY, -- Simple Key (ainult üks veerg)
    riigi_nimi VARCHAR(100)
);```
Columns:
  * riigi_kood (CHAR(2), PK, Not Null)
    riigi_nimi (VARCHAR(100), Nullable)


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
);```

rea_number (PK part 1),istekoha_number (PK part 2),kliendi_nimi
5,10,Karl
5,11,Liis
6,10,Peeter

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

Table: Õpib_Kursusel
Constraints:
  - PRIMARY KEY (tudeng_id, kursuse_id) -> [Compound Key]
  - FOREIGN KEY (tudeng_id) REFERENCES Tudengid(tudeng_id)
  - FOREIGN KEY (kursuse_id) REFERENCES Kursused(kursuse_id)

Kasutatud allikate loetelu
Date, C. J. (2004). An Introduction to Database Systems (8th Edition). Pearson Addison Wesley. (Teoreetiline ülevaade super- ja kandidaatvõtmete kohta).

W3Schools SQL Tutorial. Database Keys. Saadaval: https://www.w3schools.com/sql/

GeeksforGeeks. Types of Keys in Relational Database Management System (RDBMS). Saadaval: https://www.geeksforgeeks.org/types-of-keys-in-relational-database-management-system-rdbms/

Oracle SQL Documentation. Integrity Constraints. Saadaval: https://docs.oracle.com/
