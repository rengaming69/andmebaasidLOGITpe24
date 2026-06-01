# SQL Triggerid – Konspekt

[Select laused](select.md) | [ForeginKeys](foreignkey.md) | [Alter_Table](alter_table.md) | [Triggerid](triggerkonspekt.md) | [Kodutöö - Keys](keys.md) | [Kasutaja loomine SQL Server](Kasutajad.md)

## Mis on trigger?

SQL trigger on andmebaasi objekt, mis **käivitub automaatselt** teatud sündmuse toimumisel (INSERT, UPDATE, DELETE). Triggeri abil saab näiteks logida muutusi, kontrollida andmeid või teha lisatoiminguid.

---

## 1. Andmebaasi ja tabelite loomine

```
CREATE DATABASE trigerLOGitpe24;
USE trigerLOGitpe24;

-- Põhitabel
CREATE TABLE linnad (
    linnID   INT PRIMARY KEY IDENTITY(1,1),
    linnanimi VARCHAR(15) NOT NULL,
    rahvaarv  INT
);

-- Logitabel
CREATE TABLE logi (
    id      INT PRIMARY KEY IDENTITY(1,1),
    kasutaja VARCHAR(100),
    aeg     DATETIME,
    toiming  VARCHAR(100),
    andmed   TEXT
);
```
<img width="730" height="596" alt="image" src="https://github.com/user-attachments/assets/fd0a9b76-ca24-48d6-9ef1-29770031cd1a" />

---

## 2. INSERT-trigger

Jälgib uute kirjete lisamist tabelisse `linnad` ja salvestab info tabelisse `logi`.

```
CREATE TRIGGER linnaLisamine
ON linnad
FOR INSERT
AS
INSERT INTO logi (kasutaja, aeg, toiming, andmed)
SELECT
    SUSER_NAME(),
    GETDATE(),
    'on tehtud INSERT käsk',
    CONCAT('linn: ', inserted.linnanimi, ', elanike arv: ', inserted.rahvaarv)
FROM inserted;
```
<img width="829" height="511" alt="{595DA609-4183-4D0A-9B89-91F8AB21F210}" src="https://github.com/user-attachments/assets/4bb8f390-df37-4cd7-ae10-a17079370f35" />

> **`inserted`** – SQL Serveri virtuaaltabel, mis sisaldab äsja lisatud ridu.  
> **`SUSER_NAME()`** – tagastab sisselogitud kasutaja nime.  
> **`GETDATE()`** – tagastab praeguse kuupäeva ja kellaaja.

### Kontrollimine

```
INSERT INTO linnad (linnanimi, rahvaarv) VALUES ('Tallinn', 600000);
SELECT * FROM linnad;
SELECT * FROM logi;
```
<img width="667" height="412" alt="{F1FC7CEC-80DE-4030-8604-6AAFBF239C6F}" src="https://github.com/user-attachments/assets/cf0b879d-d2a3-4366-8825-27380781593f" />

---

## 3. DELETE-trigger

Jälgib kirjete kustutamist tabelist `linnad`.

```
CREATE TRIGGER linnaKustutamine
ON linnad
FOR DELETE
AS
INSERT INTO logi (kasutaja, aeg, toiming, andmed)
SELECT
    SUSER_NAME(),
    GETDATE(),
    'on tehtud DELETE käsk',
    CONCAT('linn: ', deleted.linnanimi, ', elanike arv: ', deleted.rahvaarv)
FROM deleted;
```
<img width="813" height="377" alt="{83194206-EED7-4057-9B02-53E467125B13}" src="https://github.com/user-attachments/assets/ba9b3488-b5b2-4ffd-9dcb-f6771b020087" />

> **`deleted`** – virtuaaltabel, mis sisaldab kustutatud ridu.

### Kontrollimine

```
DELETE FROM linnad WHERE linnID = 1;
SELECT * FROM linnad;
SELECT * FROM logi;
```
<img width="734" height="402" alt="{BFB0759C-9F60-433B-B4CB-C426705D3A84}" src="https://github.com/user-attachments/assets/eef5bebe-a3b5-4c02-bc04-eb4426bbb6db" />

---

## 4. UPDATE-trigger

Jälgib kirjete muutmist ja salvestab nii vanad kui uued andmed.

```
CREATE TRIGGER linnaUuendamine
ON linnad
FOR UPDATE
AS
INSERT INTO logi (kasutaja, aeg, toiming, andmed)
SELECT
    SUSER_NAME(),
    GETDATE(),
    'on tehtud UPDATE käsk',
    CONCAT(
        'vanad andmed - linn: ', deleted.linnanimi, ', elanike arv: ', deleted.rahvaarv,
        ' | uued andmed - linn: ', inserted.linnanimi, ', elanike arv: ', inserted.rahvaarv
    )
FROM deleted
INNER JOIN inserted ON deleted.linnID = inserted.linnID;
```
<img width="890" height="616" alt="{DBF22B3F-C0E4-4A37-A6FF-E76A1BD85918}" src="https://github.com/user-attachments/assets/2426db9f-a5ab-4cb2-bdcd-068d792f5fd3" />

> UPDATE-triggers on saadaval **mõlemad** virtuaaltabelid: `deleted` (vanad väärtused) ja `inserted` (uued väärtused).

---

## 5. Triggeri muutmine (ALTER TRIGGER)

```
ALTER TRIGGER [dbo].[linnaLisamine]
ON [dbo].[linnad]
FOR INSERT
AS
INSERT INTO logi (kasutaja, aeg, toiming, andmed)
SELECT
    SUSER_NAME(),
    GETDATE(),
    'on tehtud INSERT käsk',
    CONCAT('linn: ', inserted.linnanimi, ', elanike arv: ', inserted.rahvaarv)
FROM inserted;
```
<img width="964" height="638" alt="{0FCA5BC0-78E6-4C76-BE1E-F1E2C804BF0F}" src="https://github.com/user-attachments/assets/e377ea27-12b5-48fe-8a98-7dd0e82987e2" />

> Triggeri muutmiseks SSMS-is: **Leia trigger → Paremklõps → Modify → Muuda → Execute**

---

## 6. Kombineeritud INSERT ja DELETE trigger

```
CREATE TRIGGER linnaLisamineJaKustutamine
ON linnad
FOR INSERT, DELETE
AS
-- INSERT osa
INSERT INTO logi (kasutaja, aeg, toiming, andmed)
SELECT
    SUSER_NAME(), GETDATE(),
    'INSERT',
    CONCAT('linn: ', inserted.linnanimi, ', elanike arv: ', inserted.rahvaarv)
FROM inserted
WHERE EXISTS (SELECT 1 FROM inserted)

UNION ALL

-- DELETE osa
SELECT
    SUSER_NAME(), GETDATE(),
    'DELETE',
    CONCAT('linn: ', deleted.linnanimi, ', elanike arv: ', deleted.rahvaarv)
FROM deleted
WHERE EXISTS (SELECT 1 FROM deleted);
```
<img width="745" height="565" alt="{1E92605B-B9DC-4B65-8271-667EFB756BAD}" src="https://github.com/user-attachments/assets/9b6b333c-3433-436c-ae38-0fffbfbcdc3e" />

---

## Kokkuvõte

| Trigger | Virtuaaltabel(id) | Käivitub |
|---------|-------------------|----------|
| INSERT  | `inserted`        | Uue rea lisamisel |
| DELETE  | `deleted`         | Rea kustutamisel |
| UPDATE  | `inserted` + `deleted` | Rea muutmisel |

### Kasulikud funktsioonid

| Funktsioon | Selgitus |
|------------|----------|
| `GETDATE()` | Praegune kuupäev ja kellaaeg |
| `SUSER_NAME()` | Sisselogitud kasutaja nimi |
| `CONCAT(...)` | Tekstide liitmine |

---

*Konspekt põhineb tunnis tehtud harjutustel – LOGITpe24*
