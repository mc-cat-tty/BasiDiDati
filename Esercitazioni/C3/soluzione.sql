-- Creazione degli schemi di Netflux
create table clienti (
	email varchar(30) primary key,
	nome varchar(15) not null,
	cognome varchar(15) not null,
	tel int
);

create table film (
	codice char(5) primary key,
	titolo varchar(30),
	regista varchar(30),
	voto smallint check (voto >= 1 and voto <= 10),
	trama text
);

create table visioni (
	codice_film char(5) references film(codice)
		on delete no action on update cascade,
	email_cliente varchar(30) references clienti(email)
		on delete cascade on update cascade,
	data date,
	primary key (codice_film, email_cliente)
);

-- Riempimento degli schemi di Netflux con stub
insert into clienti (email, nome, cognome, tel) values ('test.azz@gmail.com', 'luigi', 'rossi', 33344455);
insert into clienti (email, nome) values ('test.azz@gmail.com', 'luigi');  -- invalid

insert into film values ('12345', 'Hollywoodian movie title', 'Random director', 10);
insert into film values ('12346', 'Hollywoodian movie title', 'Random director', 0);  -- invalid

insert into visioni values ('12345', 'test.azz@gmail.com', '2023-07-03');
insert into visioni values ('12346', 'test.azz@gmail.com', '2023-07-03');  -- invalid

update film set voto = voto - 3 where codice = '12345';

-- Interrogazioni
select * from film where voto > 5;  -- select [voto > 5] film
select tel from clienti where nome = 'luigi';  -- project [tel] select [nome = 'luigi'] clienti
select codice_film from visioni where email_cliente in ('carlo@gl.com', 'paolo@gl.com', 'sandra@gl.com', 'test.azz@gmail.com');  -- project [codice_film] select [email_cliente in (SET)] visioni