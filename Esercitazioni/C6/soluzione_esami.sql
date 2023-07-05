-- Creazione schemi
create table studenti (
	matricola char(9) primary key,
	nome varchar(30),
	citta varchar(30),
	anno_corso numeric(2)
);

create table docenti (
	codice char(9) primary key,
	nome varchar(30),
	citta varchar(30)
);

create table corsi (
	codice char(9) primary key,
	nome varchar(30),
	codice_docente char(9) references docenti(codice)
		on delete cascade on update cascade
);

create table esami (
	matricola char(9) references studenti(matricola)
		on delete cascade on update cascade,
	codice_corso char(9) references corsi(codice)
		on delete cascade on update cascade,
	data date,
	voto numeric(3) check (voto between 18 and 30 or voto = 33),
	primary key (matricola, codice_corso)
);

-- Riempimento
INSERT INTO studenti VALUES ('M1','Lucia Quaranta','SA',1);
INSERT INTO studenti VALUES ('M2','Giacomo Tedesco','PA',2);
INSERT INTO studenti VALUES ('M3','Carla Longo','MO',1);
INSERT INTO studenti VALUES ('M4','Ugo Rossi','MO',1);
INSERT INTO studenti VALUES ('M5','Valeria Neri','MO',2);
INSERT INTO studenti VALUES ('M6','Giuseppe Verdi','BO',1);
INSERT INTO studenti VALUES ('M7','Maria Rossi',NULL,1);

INSERT INTO docenti VALUES ('D1','Paolo Rossi','MO');
INSERT INTO docenti VALUES ('D2','Maria Pastore','BO');
INSERT INTO docenti VALUES ('D3','Paola Caboni','FI');

INSERT INTO corsi VALUES ('C1','Fisica 1','D1');
INSERT INTO corsi VALUES ('C2','Analisi Matematica 1','D2');
INSERT INTO corsi VALUES ('C3','Fisica 2','D1');
INSERT INTO corsi VALUES ('C4','Analisi Matematica 2','D3');

INSERT INTO esami VALUES ('M1','C1','2014-06-29',24);
INSERT INTO esami VALUES ('M1','C2','2015-08-09',33);
INSERT INTO esami VALUES ('M1','C3','2015-03-12',30);
INSERT INTO esami VALUES ('M2','C1','2014-06-29',28);
INSERT INTO esami VALUES ('M2','C2','2015-07-07',24);
INSERT INTO esami VALUES ('M3','C2','2015-07-07',27);
INSERT INTO esami VALUES ('M3','C3','2015-11-11',25);
INSERT INTO esami VALUES ('M4','C3','2015-11-11',33);
INSERT INTO esami VALUES ('M6','C2','2015-01-02',28);
INSERT INTO esami VALUES ('M7','C1','2014-06-29',24);
INSERT INTO esami VALUES ('M7','C2','2015-04-11',27);
INSERT INTO esami VALUES ('M7','C3','2015-06-23',27);

-- Interrogazioni
select citta from studenti except select citta from docenti;
select citta from studenti where citta not in (select citta from docenti);
select * from studenti where matricola in (select matricola from esami where codice_corso = 'C1');
select s.* from studenti s natural join esami where codice_corso = 'C1';
select * from studenti where anno_corso <= all(select anno_corso from studenti);
select * from studenti where matricola not in (select matricola from esami where codice_corso = 'C1');
select * from studenti s where not exists (select matricola from esami where codice_corso = 'C1' and esami.matricola = s.matricola);
select * from studenti where matricola != all (select matricola from esami where codice_corso = 'C1');
-- PROJECT [MATRICOLA, CODICE_CORSO AS CODICE] ESAMI ÷ PROJECT [CORSI.CODICE] (CORSI SEMI-JOIN [CORSI.CODICE_DOCENTE = DOCENTI.CODICE] (SELECT [DOCENTI.CODICE = 'D1']  DOCENTI))
select matricola
from esami join corsi on codice_corso = codice
where codice_docente = 'D1'
group by matricola
having count(*) = (
	select count(*)
	from corsi
	where codice_docente = 'D1'
)