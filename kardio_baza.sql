/*DML (Data Manipulation Language), polecenia: SELECT, INSERT, UPDATE, DELETE
  DDL (Data Definition Language), polecenia: CREATE (CREATE TABLE, CREATE DATABASE),
	   DROP (DROP TABLE, DROP DATABASE), ALTER (ALTER TABLE ADD)
  DCL (Data Control Language), polecenia: GRANT (GRANT SELECT,INSERT,UPDATE ON tab.product TO Kasia)
                                          przyznanie praw do tabeli
	REVOKE – odebranie użytkownikowi praw do tabeli, które zostały przyznane poleceniem GRANT.*/

/* Baza danych dotyczy pacjentów chorych na serce,
kupujących leki w różnych aptekach w Warszawie*/

/*use cardio*/

/* Polecenie CRATE to polecenie DDL*/

/* NIEZNORMALIZOWANA BAZA */
CREATE TABLE kardio_baza (
	id_zamówienia int PRIMARY KEY NOT NULL AUTO_INCREMENT UNIQUE,
    pacjent varchar(255) NOT NULL,
    lek varchar(255) NOT NULL,
    ilość_tabletek int NOT NULL,
    cena int NOT NULL,
    apteka varchar(255) NOT NULL
    );
    
INSERT INTO kardio_baza
VALUES (null,'Jan Kowalski', 'Atenolol', 3, 6, 'Apteka "Zdrowo" ul.Zawiszy 15'),
(null,'Beata Szelna', 'Atenolol', 15, 18, 'Apteka "Familijna" ul.Sobieskiego 99'),
(null,'Jan Kowalski', 'Metocard', 15, 18, 'Apteka "Zdrowo" ul.Zawiszy 15'),
(null,'Kazimierz Szelna', 'Bicardiol', 40, 25, 'Apteka "Familijna" ul.Sobieskiego 99'),
(null,'Beata Szelna', 'Metocard', 40, 25, 'Apteka "Dąb" ul.Kłodarzowa 32'),
(null,'Beata Szelna', 'Atenolol', 40, 25 , 'Apteka "Zdrowo" ul.Zawiszy 15'),
(null,'Jan Kowalski', 'Bicardiol', 3, 6, 'Apteka "Dąb" ul.Kłodarzowa 32'),
(null,'Kazimierz Szelna', 'Atenolol', 15, 18, 'Apteka "Dąb" ul.Kłodarzowa 32');

/* 1 POSTAĆ NORMALNA - wszytkie kolumny atomowe - nie da się ich podzielić 
(w kardiobazie nieatomowa była np. kolumna 'apteka' */

CREATE TABLE kardio_baza_1 (
	id_zamówienia int PRIMARY KEY NOT NULL AUTO_INCREMENT UNIQUE,
    pacjent_imie varchar(255) NOT NULL,
    pacjent_nazwisko varchar(255) NOT NULL,
    lek varchar(255) NOT NULL,
    ilość_tabletek int NOT NULL,
    cena int NOT NULL,
    apteka_nazwa varchar(255) NOT NULL,
    apteka_ulica varchar(255) NOT NULL,
    apteka_nr_ulicy int NOT NULL
    );
    
INSERT INTO kardio_baza_1
VALUES (null,'Jan', 'Kowalski', 'Atenolol', 3, 6, 'Zdrowo', 'Zawiszy', 15),
(null,'Beata', 'Szelna', 'Atenolol', 15, 18, 'Familijna', 'Sobieskiego', 99),
(null,'Jan', 'Kowalski', 'Metocard', 15, 18, 'Zdrowo', 'Zawiszy', 15),
(null,'Kazimierz', 'Szelna', 'Bicardiol', 40, 25, 'Familijna', 'Sobieskiego', 99),
(null,'Beata', 'Szelna', 'Metocard', 40, 25, 'Dąb', 'Kłodarzowa', 32),
(null,'Beata', 'Szelna', 'Atenolol', 40, 25, 'Zdrowo', 'Zawiszy', 15),
(null,'Jan', 'Kowalski', 'Bicardiol', 3, 6, 'Dąb', 'Kłodarzowa', 32),
(null,'Kazimierz', 'Szelna', 'Atenolol', 15, 18, 'Dąb', 'Kłodarzowa', 32);

/* 2 POSTAĆ NORMALNA - wszytkie kolumny niebędące kluczem zależne tylko od jednego klucza 
(klucze są aż 3 w 1 postaci: pacjent, lek, apteka) */

CREATE TABLE pacjent_2 (
    id_pacjenta int PRIMARY KEY NOT NULL AUTO_INCREMENT UNIQUE,
    pacjent_imie varchar(255) NOT NULL UNIQUE,
    pacjent_nazwisko varchar(255) NOT NULL
    );
    
INSERT INTO pacjent_2
VALUES (null,'Jan', 'Kowalski'),
(null,'Beata', 'Szelna'),
(null,'Kazimierz', 'Szelna');

CREATE TABLE lek_2 (
    id_leku int PRIMARY KEY NOT NULL AUTO_INCREMENT UNIQUE,
    lek varchar(255) NOT NULL,
    ilość_tabletek int NOT NULL,
    cena int NOT NULL
    );
    
INSERT INTO lek_2
VALUES (null, 'Atenolol', 3, 6),
(null,'Atenolol', 15, 18),
(null,'Metocard', 15, 18),
(null,'Bicardiol', 40, 25),
(null,'Metocard', 40, 25),
(null,'Atenolol', 40, 25),
(null,'Bicardiol', 3, 6);

CREATE TABLE apteka_2 (
    id_apteki int PRIMARY KEY NOT NULL AUTO_INCREMENT UNIQUE,
    apteka_nazwa varchar(255) NOT NULL UNIQUE,
    apteka_ulica varchar(255) NOT NULL,
    apteka_nr_ulicy int NOT NULL
    );

INSERT INTO apteka_2
VALUES (null,'Zdrowo', 'Zawiszy', 15),
(null,'Familijna', 'Sobieskiego', 99),
(null,'Dąb', 'Kłodarzowa', 32);

/* 3 POSTAĆ NORMALNA - wszytkie kolumny niebędące kluczem zależne tylko od klucza, a nie od siebie nawzajem 
(w 3 postaci kolumna lek i ilość tabletek były od siebie zależne: 
(kcena zależy od ilości tabletek w opakowaniu)) */

CREATE TABLE lek_3 (
    id_leku int PRIMARY KEY NOT NULL AUTO_INCREMENT UNIQUE,
    lek varchar(255) NOT NULL,
    ilość_tabletek int NOT NULL
    );
    
INSERT INTO lek_3
VALUES (null, 'Atenolol', 3),
(null,'Atenolol', 15),
(null,'Metocard', 15),
(null,'Bicardiol', 40),
(null,'Metocard', 40),
(null,'Atenolol', 40),
(null,'Bicardiol', 3);

CREATE TABLE wielkość_opakowania_3 (
    id_opakowania int PRIMARY KEY NOT NULL AUTO_INCREMENT UNIQUE,
    ilość_tabletek int NOT NULL UNIQUE,
    cena int NOT NULL
    );
    
INSERT INTO wielkość_opakowania_3
VALUES (null,3, 6),
(null,15, 18),
(null,40, 25);

/*klucz własny i klucz obcy
redundancja i 3 poziomy normalizacji*/