-- Creazione schemi
create table taxi (
	targa char(10) primary key,
	autista varchar(30),
	modello varchar(30),
	parcheggio char(10)
);

create table cliente(
	codice_fiscale char(20),
	data date,
	posizione_partenza varchar(30),
	posizione_arrivo varchar(30),
	primary key(codice_fiscale, data)
);

create table corsa (
	targa char(10) references taxi
		on delete no action on update cascade,
	codice_fiscale char(20),
	data date,
	costo smallint,
	primary key(targa, codice_fiscale, data),
	foreign key(codice_fiscale, data) references cliente
		on delete no action on update cascade
);

-- Stub data - non pervenuti

-- Interrogazioni
select distinct modello from taxi where modello not in (
	select modello
	from taxi natural join corsa natural join cliente
	where posizione_partenza = 'Parco della Vittoria'
);

select * from cliente cl
where cl.codice_fiscale != 'xy' and not exists (
	select * from corsa co
	where co.codice_fiscale = 'xy' and not exists (
		select * from corsa
		where targa = co.targa and codice_fiscale = cl.codice_fiscale
	)
);

select c2.targa, c2.data, sum(c1.costo) as incasso_fino_al_giorno_precedente
from corsa c1 join corsa c2 on c1.targa = c2.targa
where c1.data < c2.data
group by c2.targa, c2.data
order by targa asc, data asc;

select posizione_partenza
from corsa co natural join cliente cl
group by posizione_partenza
having count(*) >= all (
	select count(*)
	from corsa natural join cliente
	group by posizione_partenza
) and (
	select count(*)
	from corsa natural join cliente
	where posizione_partenza = cl.posizione_partenza and costo > 100
	group by posizione_partenza
) >= 3;