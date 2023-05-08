-- Creazione database ESAMI
CREATE TABLE S(
	Matr            CHAR(9),
    SNome           CHAR(40),
    Citta           CHAR(20),
    ACorso          NUMERIC(2),
    PRIMARY KEY (Matr)
);

CREATE TABLE D(
	CD              CHAR(5),
    CNome           CHAR(40),
    Citta           CHAR(20),
    PRIMARY KEY (CD)
);

CREATE TABLE C(
	CC              CHAR(5),
    CNome           CHAR(40),
    CD              CHAR(5),
    PRIMARY KEY (CC),
    FOREIGN KEY (CD)
        REFERENCES D (CD)
        ON DELETE CASCADE
);

CREATE TABLE E(
	Matr            CHAR(9),
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


-- Dati per database ESAMI
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

-- Inizio Esercizio
SELECT * FROM S WHERE ACorso = 2;
SELECT * FROM E WHERE Voto BETWEEN 24 AND 28;
SELECT * FROM S WHERE SNome LIKE 'G%';
SELECT DISTINCT Citta FROM S;
SELECT * FROM S WHERE Citta IS NULL;
SELECT S1.Matr, S2.Matr FROM S as S1, S as S2 WHERE S1.Citta = S2.Citta AND S1.Matr < S2.Matr;
SELECT S.SNome, C.CD FROM S, C, E WHERE E.Matr = S.Matr AND C.CC = E.CC AND E.Voto > 24;
SELECT DISTINCT SY.Matr FROM S AS SX, S AS SY, E AS EX, E AS EY WHERE EX.Matr = SX.Matr AND EY.Matr = SY.Matr AND EY.CC = EX.CC AND SX.SNome = 'Ugo Rossi';