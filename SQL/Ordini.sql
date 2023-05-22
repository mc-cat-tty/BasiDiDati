-- creazione tabelle del database:
CREATE TABLE MAGAZZINO
	(   COD_PROD        	NUMERIC(3) NOT NULL,
	    QTA_DISP           	NUMERIC(5),
	    QTA_RIORD          	NUMERIC(5),
	    PRIMARY KEY (COD_PROD)
	);

CREATE TABLE RIORDINO
	(   COD_PROD           	NUMERIC(3) NOT NULL,
	    DATA               	DATE,
	    QTA_ORD            	NUMERIC(5),
	    PRIMARY KEY (COD_PROD),
	    FOREIGN KEY (COD_PROD) REFERENCES MAGAZZINO (COD_PROD)
	);

---- tuple inserite nella tabella magazzino:
INSERT INTO MAGAZZINO VALUES (1,150,100);
INSERT INTO MAGAZZINO VALUES (3,130,80);
INSERT INTO MAGAZZINO VALUES (4,170,50);
INSERT INTO MAGAZZINO VALUES (5,500,150);

-- Es 1.a
create function prelievo(prod integer, quant integer) returns integer as $$
	declare
		QD INTEGER;
	begin
		select QTA_DISP into QD from MAGAZZINO where COD_PROD = prod;
		update MAGAZZINO set QTA_DISP = QD - quant where COD_PROD = prod;
		return QD - quant;
	end;
$$ language 'plpgsql'

select prelievo(1, 25);

-- Es 1.b
create function riordino() returns trigger as $$
	begin
		if new.qta_disp < 0
			then raise exception 'Quantità negativa non consentita';
		end if;
		insert into RIORDINO values(new.cod_prod, current_date, new.qta_riord);
		return new;
	end;
$$ language 'plpgsql';

create trigger gestione_riordino
	after update on magazzino
	for each row
	when (new.qta_disp < new.qta_riord)
	execute procedure riordino();

select prelievo(1, 5);
select prelievo(3, 200);

-- Es 1.d
create function arrivo_ordine(prod integer) returns integer as $$
	declare
	begin
		if (select count(distinct cod_prod) from riordino where cod_prod = prod) = 0
			then raise exception 'Prodotto non in riordino';
		end if;
		update magazzino set qta_disp = qta_disp + (
			select qta_ord from riordino where cod_prod = prod
		) where cod_prod = prod;
		delete from riordino where cod_prod = prod;
		return (select qta_disp from magazzino where cod_prod = prod);
	end;
$$ language 'plpgsql';

select arrivo_ordine(1);
