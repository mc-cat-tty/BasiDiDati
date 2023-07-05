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
select * from studenti s where not exists (
	(select codice from corsi where codice_docente = 'D1')
	except
	(select codice_corso from esami where esami.matricola = s.matricola)
);

-- Alternativa

select * from studenti s where not exists (
	select * from corsi c
	where codice_docente = 'D1' and not exists (
		select * from esami
		where esami.matricola = s.matricola
		and esami.codice_corso = c.codice
	)
);

select * from studenti s where not exists (
	(select codice_corso from esami where matricola = 'M7')
	except
	(select codice_corso from esami where matricola = s.matricola)
) and matricola != 'M7';

-- Alternativa

select * from studenti s
where s.matricola != 'M7' and not exists (
	select * from esami e
	where e.matricola = 'M7'
	and not exists (
		select * from esami
		where esami.matricola = s.matricola and esami.codice_corso = e.codice_corso
	)
);

select distinct matricola from esami natural join (select data, codice_corso from esami where matricola = 'M2') as R1 where matricola != 'M2';
select distinct matricola from esami where matricola != 'M2' and (codice_corso, data) in (select codice_corso, data from esami where matricola = 'M2');

select matricola, max(voto) as massimo from esami where voto != 33 group by matricola having count(distinct codice_corso) > 1 order by massimo asc;

select c.codice_docente, e.codice_corso
from esami e join corsi c on e.codice_corso = c.codice
group by codice_docente, codice_corso
having count(*) >= all(
	select count(*)
	from esami join corsi on esami.codice_corso = corsi.codice
	where c.codice_docente = codice_docente
	group by codice_docente, codice_corso
);

create view doc_cor_esami (codice_docente, codice_corso, numero_esami_sostenuti) as
select codice_docente, codice_corso, count(*)
from esami join corsi on codice_corso = codice
group by codice_docente, codice_corso;

select * from doc_cor_esami dce where numero_esami_sostenuti >= all(
	select numero_esami_sostenuti
	from doc_cor_esami
	where codice_docente = dce.codice_docente
);