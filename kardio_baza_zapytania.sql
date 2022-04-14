/*DML (Data Manipulation Language), polecenia: SELECT, INSERT, UPDATE, DELETE*/

SELECT * FROM kardio_baza_1 WHERE lek='Atenolol' OR lek='Bicardiol';
SELECT * FROM kardio_baza_1 WHERE lek IN('Atenolol','Bicardiol');
SELECT * FROM kardio_baza_1 WHERE lek!='Bicardiol';
SELECT lek AS drug, cena AS price, apteka_ulica AS pharmacy FROM kardio_baza_1 WHERE lek!='Bicardiol' AND cena<20;
SELECT * FROM kardio_baza_1 ORDER BY cena;
SELECT * FROM kardio_baza_1 WHERE apteka_nazwa LIKE('Familijna') ORDER BY cena;
SELECT * FROM kardio_baza_1 ORDER BY cena DESC LIMIT 5;
/*DISTINCT-bez powtórzeń, dotyczy całego polecenia SELECT*/
SELECT DISTINCT apteka_nazwa FROM kardio_baza_1;

SELECT concat(upper(pacjent_nazwisko),': ',apteka_nazwa, ' ul.', apteka_ulica) AS 'pacjent i apteka', concat (cena, ' zł') AS wydatki
 FROM kardio_baza_1;
 
SELECT apteka_nazwa, AVG(cena) AS srednia FROM kardio_baza_1 GROUP BY apteka_nazwa HAVING AVG(cena) >15;
SELECT apteka_nazwa, COUNT(apteka_nazwa) AS 'liczba transakcji' FROM kardio_baza_1 GROUP BY apteka_nazwa;

INSERT INTO kardio_baza_1 /*nie trzeba (), ale trzeba teraz podać 9 wartości w values bo dla wszystkich kolumn w tabeli:*/
VALUES (null,'Marcin', 'Nowak', 'Bicardiol', 3, 6, 'Zdrowo', 'Zawiszy', 15);

UPDATE kardio_baza_1 SET apteka_nazwa='Dąb', apteka_ulica='Kłodarzowa', apteka_nr_ulicy=32 WHERE id_zamówienia=9;

DELETE FROM kardio_baza_1 WHERE id_zamówienia=9;

/*podzapytania*/
SELECT apteka_nazwa, cena FROM kardio_baza_1
WHERE cena < (SELECT cena FROM kardio_baza_1 WHERE id_zamówienia=4)
ORDER BY cena DESC;

/**JOIN**/

SELECT wielkość_opakowania_3.id_opakowania, lek_3.lek
FROM lek_3 INNER JOIN wielkość_opakowania_3
ON lek_3.ilość_tabletek=wielkość_opakowania_3.ilość_tabletek;

/*LEFT JOIN - poda wszystkie leki a do nich wielkości opakowań (nawet jeśli przy jakimś leku nie ma określonej wlk opakowania)*/
SELECT wielkość_opakowania_3.id_opakowania, lek_3.lek
FROM lek_3 LEFT JOIN wielkość_opakowania_3
ON lek_3.ilość_tabletek=wielkość_opakowania_3.ilość_tabletek;

/*RIGHT JOIN - poda wszystkie wielkości opakowań do nich leki (nawet jeśli jakiś lek jest null)*/
SELECT wielkość_opakowania_3.id_opakowania, lek_3.lek
FROM lek_3 RIGHT JOIN wielkość_opakowania_3
ON lek_3.ilość_tabletek=wielkość_opakowania_3.ilość_tabletek;

SELECT wielkość_opakowania_3.id_opakowania, lek_3.lek
FROM wielkość_opakowania_3 NATURAL JOIN lek_3;
