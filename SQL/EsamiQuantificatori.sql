-- Creazione e riempimento DB

CREATE TABLE S
(   Matr            CHAR(9),
    SNome           CHAR(40),
    Citta           CHAR(20),
    ACorso          NUMERIC(2),
    PRIMARY KEY (Matr)
);

CREATE TABLE D
(   CD              CHAR(5),
    CNome           CHAR(40),
    Citta           CHAR(20),
    PRIMARY KEY (CD)
);

CREATE TABLE C
(   CC              CHAR(5),
    CNome           CHAR(40),
    CD              CHAR(5),
    PRIMARY KEY (CC),
    FOREIGN KEY (CD)
        REFERENCES D (CD)
        ON DELETE CASCADE
);

CREATE TABLE E
(   Matr            CHAR(9),
    CC              CHAR(5),
    Data            DATE,
    Voto            NUMERIC(3),
    PRIMARY KEY (Matr,CC),
    FOREIGN KEY (Matr)
        REFERENCES S (Matr)
        ON DELETE CASCADE,
    FOREIGN KEY (CC)
        REFERENCES C (CC)
        ON DELETE CASCADE,
    CHECK (((VOTO>=18) AND (VOTO<=30)) OR (VOTO=33))
);


--
-- Dati per database ESAMI
--

INSERT INTO S VALUES ('M1','Lucia Quaranta','SA',1);
INSERT INTO S VALUES ('M2','Giacomo Tedesco','PA',2);
INSERT INTO S VALUES ('M3','Carla Longo','MO',1);
INSERT INTO S VALUES ('M4','Ugo Rossi','MO',1);
INSERT INTO S VALUES ('M5','Valeria Neri','MO',2);
INSERT INTO S VALUES ('M6','Giuseppe Verdi','BO',1);
INSERT INTO S VALUES ('M7','Maria Rossi',NULL,1);

INSERT INTO D VALUES ('D1','Paolo Rossi','MO');
INSERT INTO D VALUES ('D2','Maria Pastore','BO');
INSERT INTO D VALUES ('D3','Paola Caboni','FI');

INSERT INTO C VALUES ('C1','Fisica 1','D1');
INSERT INTO C VALUES ('C2','Analisi Matematica 1','D2');
INSERT INTO C VALUES ('C3','Fisica 2','D1');
INSERT INTO C VALUES ('C4','Analisi Matematica 2','D3');

INSERT INTO E VALUES ('M1','C1','2014-06-29',24);
INSERT INTO E VALUES ('M1','C2','2015-08-09',33);
INSERT INTO E VALUES ('M1','C3','2015-03-12',30);
INSERT INTO E VALUES ('M2','C1','2014-06-29',28);
INSERT INTO E VALUES ('M2','C2','2015-07-07',24);
INSERT INTO E VALUES ('M3','C2','2015-07-07',27);
INSERT INTO E VALUES ('M3','C3','2015-11-11',25);
INSERT INTO E VALUES ('M4','C3','2015-11-11',33);
INSERT INTO E VALUES ('M6','C2','2015-01-02',28);
INSERT INTO E VALUES ('M7','C1','2014-06-29',24);
INSERT INTO E VALUES ('M7','C2','2015-04-11',27);
INSERT INTO E VALUES ('M7','C3','2015-06-23',27);

-- QUERY
-- Città di studenti ma non di docenti
SELECT Citta FROM S WHERE Citta NOT IN (SELECT Citta FROM D)
SELECT Citta FROM S EXCEPT SELECT Citta FROM D  -- Rispetto alla query sopra aggiunge anche il valore nullo

-- Studenti che hanno sostenuto C1
SELECT SNome FROM S, E WHERE S.Matr = E.Matr AND E.CC = 'C1'
SELECT SNome FROM S WHERE Matr IN (
	SELECT Matr FROM E WHERE CC = 'C1'
)

-- Studenti con anno di corso più basso
SELECT * FROM S WHERE ACorso <= ALL(SELECT ACorso FROM S)

-- Studenti che non hanno sostenuto C1
SELECT SNome FROM S WHERE Matr NOT IN (
	SELECT Matr FROM E WHERE CC = 'C1'
)
SELECT SNome FROM S AS STUD WHERE NOT EXISTS (
	SELECT Matr FROM E WHERE E.Matr = STUD.Matr and E.CC = 'C1'
)
SELECT SNome FROM S WHERE Matr != ALL (
	SELECT Matr FROM E WHERE CC = 'C1'
)

-- Studenti che hanno sostenuto tutti gli esami relati ai corsi del docente D1
SELECT DISTINCT * FROM S AS STUD WHERE NOT EXISTS(
	SELECT CC FROM C, D WHERE C.CD = D.CD AND C.CD = 'D1' INTERSECT SELECT CC FROM E WHERE CC NOT IN (
		SELECT CC FROM S NATURAL JOIN E WHERE S.Matr = STUD.Matr
	)
)