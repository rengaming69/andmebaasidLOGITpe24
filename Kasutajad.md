## Kasutajad

## SISUKORD

[Select laused](select.md) | [ForeginKeys](foreignkey.md) | [Alter_Table](alter_table.md) | [Triggerid](triggerkonspekt.md) | [Kodutöö - Keys](keys.md) | [Kasutaja loomine SQL Server](Kasutajad.md)


Mis on autentimine SQL Serveris?
Autentimine tähendab kasutaja identiteedi tuvastamist ehk kontrollimist, kas kasutajal on üldse õigus SQL Serveri instantsi sisse logida.

SQL Server toetab kahte peamist autentimise tüüpi:

Windows Authentication (Soovitatav ja turvalisem): Kasutatakse samu kasutajaandmeid, millega logitakse sisse Windowsi operatsioonisüsteemi või Active Directory domeeni. Paroole haldab Windows, mis tagab kõrge turvalisuse (keerukusreeglid, aegumine) ja kasutaja ei pea eraldi parooli teadma (Single Sign-On).

SQL Server Authentication: Kasutajakonto luuakse otse SQL Serveri siseselt ja see ei sõltu Windowsist. Määratakse unikaalne kasutajanimi ja parool. Sobib hästi veebirakenduste ja platvormiüleste liideste ühendamiseks.

Näide: Kasutajanimi: DirectorRokk, Parool: director

 Veaotsing (Error 18456): Kui SQL Serveriga ühendumisel tekib viga 18456, on serveris lubatud vaid Windowsi autentimine.

<img width="703" height="655" alt="{9A8EBD0C-C317-487F-B5FB-E1CC94EC366A}" src="https://github.com/user-attachments/assets/bf67144f-a1b7-4815-888b-06a85d481c51" />

<img width="701" height="663" alt="{B8C771EF-AFBE-4E22-902F-6B791652AD76}" src="https://github.com/user-attachments/assets/a050b36c-69fa-44a4-89f5-89b4256b4722" />

<img width="1043" height="714" alt="{DFFD6B7D-3113-434E-A2C2-937F46EEC279}" src="https://github.com/user-attachments/assets/361b0cc5-40ff-47e5-9bbc-2b5a2a8da078" />

<img width="345" height="326" alt="{BF63C107-3742-4F5B-A9F8-54E2B5175D63}" src="https://github.com/user-attachments/assets/f43fef7b-02b1-4736-92e0-59fa612fba83" />

<img width="679" height="645" alt="{6D6A179E-6B85-4CAC-B1CE-A8D256ED0B66}" src="https://github.com/user-attachments/assets/66701e73-de09-486e-a5f8-3a9aea1f8ccb" />

<img width="528" height="651" alt="{8616F3AE-0779-4D46-A9AF-CD08AAB8DD0F}" src="https://github.com/user-attachments/assets/1c1e664d-1a99-429d-bd92-06484993efed" />

