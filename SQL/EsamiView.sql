-- Creazione database ESAMI

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

-- Esercizio 1
select * from S where not exists (
	select distinct C.CC
	from C
	where C.CD = 'D1'
	
	except
	
	select distinct C.CC
	from E natural join C
	where C.CD = 'D1'
	and E.Matr = S.Matr
);

select * from S where not exists (
	select distinct C.CC
	from E natural join C
	where E.Matr = 'M7'
	except
	select distinct C.CC
	from E natural join C
	where E.Matr = S.Matr
);

-- Esercizio 2
select Matr from S where exists (
	select *
	from C natural join E
	where E.Matr = S.Matr
	and (E.CC, E.Data) in (
		select E2.CC, E2.Data
		from E E2
		where Matr = 'M2'
	)
);

select Matr, max(Voto)
from (
	select * from S natural join E
	where Voto != 33
) AS filtedr
group by Matr
having count(Voto) > 1
order by max(Voto) asc;

select CD, CC
from C C1 natural join E E1
group by CD, CC
having count(*) >= all(
	select count(*)
	from C C2 natural join E E2
	where C1.CD = C2.CD
	group by C2.CC
);

create view doc_cor_esami as (
	select CD, CC, count(*) as num_esami
	from C natural join E
	group by CD, CC
);

select * from doc_cor_esami de1
where num_esami >= all(
	select de2.num_esami
	from doc_cor_esami de2
	where de2.cd = de1.cd
)