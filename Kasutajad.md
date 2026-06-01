## Kasutajad

## SISUKORD

[Select laused](select.md) | [ForeginKeys](foreignkey.md) | [Alter_Table](alter_table.md) | [Triggerid](triggerkonspekt.md) | [Kodutöö - Keys](keys.md)


Mis on autentimine SQL Serveris?
Autentimine tähendab kasutaja identiteedi tuvastamist ehk kontrollimist, kas kasutajal on üldse õigus SQL Serveri instantsi sisse logida.

SQL Server toetab kahte peamist autentimise tüüpi:

Windows Authentication (Soovitatav ja turvalisem): Kasutatakse samu kasutajaandmeid, millega logitakse sisse Windowsi operatsioonisüsteemi või Active Directory domeeni. Paroole haldab Windows, mis tagab kõrge turvalisuse (keerukusreeglid, aegumine) ja kasutaja ei pea eraldi parooli teadma (Single Sign-On).

SQL Server Authentication: Kasutajakonto luuakse otse SQL Serveri siseselt ja see ei sõltu Windowsist. Määratakse unikaalne kasutajanimi ja parool. Sobib hästi veebirakenduste ja platvormiüleste liideste ühendamiseks.

Näide: Kasutajanimi: DirectorRokk, Parool: director

 Veaotsing (Error 18456): Kui SQL Serveriga ühendumisel tekib viga 18456, on serveris lubatud vaid Windowsi autentimine.

<img width="703" height="655" alt="{9A8EBD0C-C317-487F-B5FB-E1CC94EC366A}" src="https://github.com/user-attachments/assets/bf67144f-a1b7-4815-888b-06a85d481c51" />

<img width="706" height="656" alt="{71B7DCCA-FA15-43A0-8538-A1493373012F}" src="https://github.com/user-attachments/assets/332eb1af-8dd4-4ddd-adab-6137912015c7" />

<img width="1043" height="714" alt="{DFFD6B7D-3113-434E-A2C2-937F46EEC279}" src="https://github.com/user-attachments/assets/361b0cc5-40ff-47e5-9bbc-2b5a2a8da078" />

<img width="345" height="326" alt="{BF63C107-3742-4F5B-A9F8-54E2B5175D63}" src="https://github.com/user-attachments/assets/f43fef7b-02b1-4736-92e0-59fa612fba83" />


