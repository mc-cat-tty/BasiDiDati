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
select * from studenti where citta = 'MO' order by anno_corso asc;
select matricola, codice_corso, voto*2 as voto_sessantesimi from esami where codice_corso = 'C1' order by voto_sessantesimi desc, matricola asc;
select count(*) from studenti;
select count(distinct matricola) from esami;
select avg(voto) from esami where matricola = 'M2';
select matricola, min(voto) as voto_minimo, max(voto) as voto_massimo from esami where codice_corso != 'C2' group by matricola;
select matricola, nome, min(voto) as voto_minimo, max(voto) as voto_massimo from esami natural join studenti where codice_corso != 'C2' group by matricola, nome;
select codice, nome, count(*) as esami_sostenuti from corsi join esami on codice = codice_corso group by codice, nome;
select voto, count(*) as numero_voti from esami group by voto having voto between 23 and 28 order by voto asc;
select codice_corso, avg(voto) from esami group by codice_corso having count(matricola) >= 2;
select distinct matricola from esami group by matricola, voto having count(*) >= 2;